// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for this video: https://youtu.be/BV9ny785UNc

// Written entirely based on
// http://www.karlsims.com/rd.html

// Also, for reference
// http://hg.postspectacular.com/toxiclibs/src/44d9932dbc9f9c69a170643e2d459f449562b750/src.sim/toxi/sim/grayscott/GrayScott.java?at=default
float dA = 1.0;
float dB = 0.5;
float feed = 0.055;
float k = 0.062;
float B_power = 0.001;
float B_size = 100;
boolean hs = false;
boolean simple = false;

Cell[][] grid;
Cell[][] prev;

void setup() {
  size(1000, 1000);
  grid = new Cell[width][height];
  prev = new Cell[width][height];

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j ++) {
      float a = 1;
      float b = 0;
      grid[i][j] = new Cell(a, b, feed, k);
      prev[i][j] = new Cell(a, b, feed, k);
    }
  }

  for (int n = 0; n < 10; n++) {
    int startx = int(random(width/2+20, width/2-20));
    int starty = int(random(height/2+20, height/2-20));

    for (int i = startx; i < startx+10; i++) {
      for (int j = starty; j < starty+10; j ++) {
        float a = 1;
        float b = 1;
        grid[i][j] = new Cell(a, b, feed, k);
        prev[i][j] = new Cell(a, b, feed, k);
      }
    }
  }
}



void update() {
  for (int i = 1; i < width-1; i++) {
    for (int j = 1; j < height-1; j ++) {

      Cell spot = prev[i][j];
      Cell newspot = grid[i][j];

      float a = spot.a;
      float b = spot.b;
      
      float laplaceA = 0;
      
      float c1 = 0.25/(1.0+sqrt(2))*1.0;
      float c2 = 0.25 - c1;
      laplaceA += a*-1;
      laplaceA += prev[i+1][j].a*c2;
      laplaceA += prev[i-1][j].a*c2;
      laplaceA += prev[i][j+1].a*c2;
      laplaceA += prev[i][j-1].a*c2;
      laplaceA += prev[i-1][j-1].a*c1;
      laplaceA += prev[i+1][j-1].a*c1;
      laplaceA += prev[i-1][j+1].a*c1;
      laplaceA += prev[i+1][j+1].a*c1;

      float laplaceB = 0;
      laplaceB += b*-1;
      laplaceB += prev[i+1][j].b*c2;
      laplaceB += prev[i-1][j].b*c2;
      laplaceB += prev[i][j+1].b*c2;
      laplaceB += prev[i][j-1].b*c2;
      laplaceB += prev[i-1][j-1].b*c1;
      laplaceB += prev[i+1][j-1].b*c1;
      laplaceB += prev[i-1][j+1].b*c1;
      laplaceB += prev[i+1][j+1].b*c1;

      newspot.a = a + (dA*laplaceA - a*b*b + prev[i][j].feed*(1-a))*1;
      newspot.b = b + (dB*laplaceB + a*b*b - (prev[i][j].k+prev[i][j].feed)*b)*1;

      newspot.a = constrain(newspot.a, 0, 1);
      newspot.b = constrain(newspot.b, 0, 1);
    }
  }
}

void swap() {
  Cell[][] temp = prev;
  prev = grid;
  grid = temp;
}

void keyPressed(){
  if(key=='h'){
    hs = !hs;
  }
  if(key=='s'){
    simple = !simple;
  }
}

void draw() {
  println(frameRate);
  int iter = 1;
  if(hs){
    iter = 100;
  }
  for (int i = 0; i < iter; i++) {
    update();
    swap();
  }
  
  if(!hs){
    show();
  }
}