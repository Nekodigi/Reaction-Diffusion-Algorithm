Data[][] datas;
int gridInterval = 10;
float zoff = 0;

void setup(){
  fullScreen(JAVA2D);
  datas = new Data[(int)(width/gridInterval)+3][(int)(height/gridInterval)+3];
  for(int y = 0; y < (int)(height/gridInterval)+3; y++){
    for(int x = 0; x < (int)(width/gridInterval)+3; x++){
      Data data = new Data();
      datas[x][y] = data;
    }
  }
  noStroke();
}

void draw(){
  background(360);
  float yoff = 0;;
  for(int y = 1; y < (int)(height/gridInterval)+2; y++){
    float xoff = 0;
    for(int x = 1; x < (int)(width/gridInterval)+2; x++){
      Data data = datas[x][y];
        spread(x, y);
      if(random(0, 1) < 0.000001){
        data.things = random(100000000, 1000000000);
      }
      if(random(0, 1) < 0.00000001){
        data.amount += random(0, 100000000);
        data.tier = random(1000000, 10000000);
      }
      if(data.amount > 0){
        data.things += data.tier*100000;
        data.amount -= data.tier;
      }
      if(data.poplation < data.things){
        data.things -= data.poplation;
        data.poplation = data.poplation*1.0001+data.poplation*data.things/2000000000;
      }
      else{
        data.poplation = (int)data.things;
        data.things = 0;
      }
      if(data.poplation < 1){
        data.poplation = 10;
        rect(x*gridInterval, y*gridInterval, ((float)data.poplation/10000)*(float)gridInterval, ((float)data.poplation/10000)*(float)gridInterval);
      }
      else if(data.poplation > 10000){
        data.things *= 1.1;
              rect(x*gridInterval, y*gridInterval, gridInterval,gridInterval);
      }
      else{
        data.poplation *= 1.1;
        rect(x*gridInterval, y*gridInterval, ((float)data.poplation/10000)*(float)gridInterval, ((float)data.poplation/10000)*(float)gridInterval);
      }
      colorMode(HSB, 360, 100, 100, 100);
      fill((-(float)data.things/1000000)*(float)gridInterval+250, 100, 100);
      //rect(x*gridInterval, y*gridInterval, ((float)data.things/10000)*(float)gridInterval, ((float)data.things/10000)*(float)gridInterval);
    }
  }
}

void spread(int x, int y){
  Data data = datas[x][y];
  Data ndata = datas[x][y+1];
  Data edata = datas[x+1][y];
  Data wdata = datas[x-1][y];
  Data sdata = datas[x][y-1];
  Data nedata = datas[x+1][y+1];
  Data nwdata = datas[x-1][y+1];
  Data sedata = datas[x+1][y-1];
  Data swdata = datas[x-1][y-1];
  float totalnum = 0;
  totalnum += ndata.things;
  totalnum += edata.things;
  totalnum += wdata.things;
  totalnum += sdata.things;
  totalnum += nedata.things;
  totalnum += nwdata.things;
  totalnum += sedata.things;
  totalnum += swdata.things;
  data.things = totalnum/8;
}

void mousePressed(){
  Data data = datas[(int)(mouseX)][(int)(mouseY)];
  data.amount = random(0, 10000);
  data.tier = random(0, 50);
}

class Data {
  float poplation = 1;
  //resource;
  float amount = 1000000000;
  float tier = 0;
  float things = 0;
}