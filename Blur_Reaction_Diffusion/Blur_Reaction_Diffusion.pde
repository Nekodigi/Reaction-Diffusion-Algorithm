float sbRange = 2;//small blur size
float lbRange = 4;//large blur size
float sbPow = 3;//small blur power
float lbPow = 2;//large blur power
float ces = 2;//cell size
PGraphics pg;
PImage img, imgSB, imgLB, resImg;//base image, small blur, large blur, resultImg

void setup(){
  size(1000, 1000);
  //fullScreen();
  
  pg = createGraphics(PApplet.parseInt(width/2.f/ces), PApplet.parseInt(height/2.f/ces));
  pg.beginDraw();
  pg.background(0);
  pg.noStroke();
  pg.ellipse(width/4/ces, height/4/ces, 20, 20);
  pg.endDraw();
  img = pg;
  //img = loadImage("ErodeTest.png");
  textSize(20);
  textAlign(LEFT, TOP);
}

int imgIx(int i, int j){//imageIndex
  return j*img.width + i;
}

void draw(){
  
  solver();
  
  image(img, 0, 0, width/2, height/2);
  image(resImg, width/2, 0, width/2, height/2);
  image(imgSB, 0, height/2, width/2, height/2);
  image(imgLB, width/2, height/2, width/2, height/2);
  text(String.format("%.1f, %.1f, %.1f, %.1f",sbRange, lbRange, sbPow, lbPow), 0, 0);
}

void solver(){
  imgSB = img.copy();
  imgLB = img.copy();
  resImg = img.copy();
  imgSB.filter(BLUR, sbRange);
  imgLB.filter(BLUR, lbRange);
  
  for(int i=0; i<img.width; i++){
    for(int j=0; j<img.height; j++){
      int ix = imgIx(i, j);
      PVector sbC = col2RGB(imgSB.pixels[ix]).mult(sbPow);
      PVector lbC = col2RGB(imgLB.pixels[ix]).mult(lbPow);
      PVector sub = PVector.sub(sbC, lbC);
      resImg.pixels[ix] = RGB2col(sub);
    }
  }
  img = resImg;
}
PVector col2RGB(int col){
  return new PVector(red(col), green(col), blue(col));
}

int RGB2col(PVector rgb){
  return color(rgb.x, rgb.y, rgb.z);
}
