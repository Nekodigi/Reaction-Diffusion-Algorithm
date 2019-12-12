import controlP5.*;

Data[][] datas;
int gridInterval = 10;
float zoff = 0;
float basePopulationIncrease = 3;
float wealthPopulationIncrease = -10;
float maxPopulation =2;
float minpopulation = 1;
float capaOverThingsIncrease = 0;
float thingsRange = 4;
float fade = 100;
float lineFade = 100;
boolean populationLimitEnable = false;
boolean AutoSpawnEnable = true;
boolean thingsSpread = true;
boolean populationSpread = false;
boolean parlinEnable = false;

void setup(){
  fullScreen(P3D);
  datas = new Data[(int)(width/gridInterval)+3][(int)(height/gridInterval)+3];
  Gridclear();
  noStroke();
  
}

void Gridclear(){
  for(int y = 0; y < (int)(height/gridInterval)+3; y++){
    for(int x = 0; x < (int)(width/gridInterval)+3; x++){
      Data data = new Data();
      datas[x][y] = data;
    }
  }
  setupGUI();
  Agentsetup();
  background(360);
}

void impulse(int x, int y, int pow){
  Data data = datas[x][y];
  data.things = random(0, pow);
}

void mine(int x, int y){
  Data data = datas[x][y];
  data.amount += random(0, 100);
  data.tier = random(0, 1);
}

void draw(){
  fill(360,fade);
  rect(0, 0, width, height);
  zoff+=0.01;
  float yoff = 0;;
  if(mouseButton == LEFT){
    impulse((int)(mouseX/gridInterval), (int)(mouseY/gridInterval), 100000000);
  }
  if(mouseButton == RIGHT){
    mine((int)(mouseX/gridInterval), (int)(mouseY/gridInterval));
  }
  for(int y = 0; y < (int)(height/gridInterval)+2; y++){
    float xoff = 0;
    for(int x = 0; x < (int)(width/gridInterval)+2; x++){
      Data data = datas[x][y];
      if(parlinEnable){
        data.poplation += map(noise(xoff,yoff,zoff),0,1,0,10);
      }
      if(thingsSpread && y>0 && x>0 && y < (int)(height/gridInterval)+1 && x < (int)(width/gridInterval)+1){
      tspread(x, y);
      }
      if(populationSpread && y>0 && x>0 && y < (int)(height/gridInterval)+1 && x < (int)(width/gridInterval)+1){
      pspread(x, y);
      }
      if(AutoSpawnEnable){
      if(random(0, 1) < 0.000001){
        impulse(x, y,100000000);
      }
      if(random(0, 1) < 0.0000001){
        mine(x, y);
      }
      }
      if(data.amount > 0){
        data.things += data.tier*1000000;
        data.amount -= data.tier;
      }
      if(data.poplation < data.things){
        data.things -= data.poplation;
        data.poplation = data.poplation*convPow(basePopulationIncrease, 5)+data.poplation*data.things*pow(10,wealthPopulationIncrease);
      }
      else{
        data.poplation = (int)data.things;
        data.things = 0;
      }
      fill((-(float)data.things/pow(10,thingsRange))*(float)gridInterval+250, 100, 100, lineFade);
      if(data.poplation < 1){
        data.poplation = pow(10,minpopulation);
        rect(x*gridInterval, y*gridInterval, ((float)data.poplation/pow(10,maxPopulation))*(float)gridInterval, ((float)data.poplation/pow(10,maxPopulation))*(float)gridInterval);
      }
      else if(data.poplation > pow(10,maxPopulation)){
        if(populationLimitEnable){
          data.poplation = pow(10,maxPopulation);
        }
        data.things *= convPow(capaOverThingsIncrease, 3);
              rect(x*gridInterval, y*gridInterval, gridInterval,gridInterval);
      }
      else{
        rect(x*gridInterval, y*gridInterval, ((float)data.poplation/pow(10,maxPopulation))*(float)gridInterval, ((float)data.poplation/pow(10,maxPopulation))*(float)gridInterval);
      }
      xoff+=0.1;
      colorMode(HSB, 360, 100, 100, 100);
      //rect(x*gridInterval, y*gridInterval, ((float)data.things/10000)*(float)gridInterval, ((float)data.things/10000)*(float)gridInterval);
    }
    yoff+=0.1;
  }
  controlP5.show();
  controlP5.draw();
  Agentdraw();
}

float convPow(float value, float range){
  float genbp = 0;
  if(value > 0){
    genbp = pow(10,-range+abs(value))+1;
  }
  else{
    genbp = -pow(10,-range+abs(value))+1;
  }
  return genbp;
}

void tspread(int x, int y){
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
  totalnum += nedata.things*0.75;
  totalnum += nwdata.things*0.75;
  totalnum += sedata.things*0.75;
  totalnum += swdata.things*0.75;
  data.things = totalnum/7;
}
void pspread(int x, int y){
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
  totalnum += ndata.poplation;
  totalnum += edata.poplation;
  totalnum += wdata.poplation;
  totalnum += sdata.poplation;
  totalnum += nedata.poplation*0.75;
  totalnum += nwdata.poplation*0.75;
  totalnum += sedata.poplation*0.75;
  totalnum += swdata.poplation*0.75;
  data.poplation = totalnum/7;
}

void mousePressed(){
  
}

class Data {
  float poplation = 40;
  //resource;
  float amount = 1000000000;
  float tier = 0;
  float things = 10000;
}