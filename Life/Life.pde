int decimation = 10;
int airwid;
int airhei;
int drawmode;
float drawrange = 40;
int lifetime = 35;
int grownup = 30;
int oldman = 20;
int die = 10;

float[][] wavect;
float[][] waveenable;

void setup(){
  //fullScreen(P3D);
  size(1900,1800,P3D);
  frameRate(60);
  airwid=width/decimation;
  airhei=height/decimation;
  wavect = new float[airwid][airhei];
  waveenable = new float[airwid][airhei];
   for(int x = 0; x < airwid; x++){
    for(int y = 0; y < airhei; y++){
      //vector airvec = airvecs[x][y];
      wavect[x][y] = 0;
      waveenable[x][y] = 0;
    }
  }
}
void mousePressed(){
  if(mouseButton == RIGHT){
    drawmode++;
  }
}

void keyPressed(){
}

void draw(){
  background(200);
  if(mousePressed){
  spoint();
  }
  box(150, 150, 150);
  for(int x = 1; x < airwid-1; x++){
    for(int y = 1; y < airhei-1; y++){
      //vector airvec = airvecs[x][y];
      wavect[x][y]--;
      stroke(0);
      if(wavect[x][y] < grownup && wavect[x][y] > oldman){
        spawn(x+1, y+1);
        spawn(x+1, y);
        spawn(x+1, y-1);
        spawn(x-1, y+1);
        spawn(x-1, y);
        spawn(x-1, y-1);
        spawn(x, y+1);
        spawn(x, y-1);
      }
      else if(wavect[x][y] < die){
        waveenable[x][y] = 0;
      }
      switch(drawmode){
        case 0:
          line(x*decimation, y*decimation, waveenable[x][y], (x+1)*decimation, y*decimation, waveenable[x+1][y]);
          line(x*decimation, y*decimation, waveenable[x][y], x*decimation, (y+1)*decimation, waveenable[x][y+1]);
          break;
        case 1:
          ellipse(x*decimation, y*decimation, waveenable[x][y]+10, waveenable[x][y]+10);
          break;
        case 2:
          line(x*decimation, y*decimation, waveenable[x][y], (x+1)*decimation, y*decimation, waveenable[x+1][y]);
          line(x*decimation, y*decimation, waveenable[x][y], x*decimation, (y+1)*decimation, waveenable[x][y+1]);
          ellipse(x*decimation, y*decimation, waveenable[x][y]+10, waveenable[x][y]+10);
          break;
        default:
          drawmode=0;
      }
      noStroke();
      fill(0);
      
    }
  }
}

void spoint(){
  int mposX = mouseX/decimation;
  int mposY = mouseY/decimation;
  if(mposX>0 && mposX<airwid-1 && mposY>0 && mposY<airhei-1){
    spawn(mposX, mposY);
  }
}

void spawn(int x, int y){
  if(wavect[x][y] <= 0){
    wavect[x][y] = lifetime;
    waveenable[x][y] = 40;
  }
}