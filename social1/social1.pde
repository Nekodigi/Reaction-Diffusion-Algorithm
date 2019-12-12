Data[][] datas;
int gridInterval = 10;
float zoff = 0;

void setup(){
  fullScreen(JAVA2D);
  datas = new Data[(int)(width/gridInterval)+1][(int)(height/gridInterval)+1];
  for(int y = 0; y < (int)(height/gridInterval)+1; y++){
    for(int x = 0; x < (int)(width/gridInterval)+1; x++){
      Data data = new Data();
      data.things = 1000;
      data.poplation = 100;
      datas[x][y] = data;
    }
  }
}

void draw(){
  background(360);
  float yoff = 0;
  zoff+=0.01;
  for(int y = 0; y < (int)(height/gridInterval)+1; y++){
    float xoff = 0;
    for(int x = 0; x < (int)(width/gridInterval)+1; x++){
      Data data = datas[x][y];
      data.things += map(noise(xoff, yoff, zoff), 0, 1, 0, 100);
      if(data.poplation < data.things){
        data.things -= data.poplation;
        data.poplation = data.poplation*1.001;
      }
      else{
        data.poplation = (int)data.things;
        data.things = 0;
      }
      colorMode(HSB, 360, 100, 100, 100);
      fill((-(float)data.things/100)*(float)gridInterval+250, 100, 100);
      rect(x*gridInterval, y*gridInterval, ((float)data.poplation/50)*(float)gridInterval, ((float)data.poplation/50)*(float)gridInterval);
      //ellipse(x*gridInterval, y*gridInterval, ((float)data.things/10000)*(float)gridInterval, ((float)data.things/10000)*(float)gridInterval);
      xoff+=0.02;
    }
    yoff+=0.02;
  }
}

void mousePressed(){
  Data data = datas[(int)(mouseX)][(int)(mouseY)];
  data.amount = random(0, 10000);
  data.tier = random(0, 50);
}

class Data {
  float poplation;
  //resource;
  float amount;
  float tier;
  float things;
}