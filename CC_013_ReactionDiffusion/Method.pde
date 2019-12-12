void show(){
  float mult  = 1;
  if(keyPressed && keyCode == SHIFT){
    mult = -1;
  }
  
  loadPixels();
  for (int i = 1; i < width-1; i++) {
    for (int j = 1; j < height-1; j ++) {
      Cell spot = grid[i][j];
      float a = spot.a;
      float b = spot.b;
      if(mousePressed){
        if(mouseButton == LEFT){
          spot.feed += mult*constrain(1-dist(mouseX, mouseY, i, j)/B_size, 0, 1)*B_power;
        }
        else{
          spot.k += mult*constrain(1-dist(mouseX, mouseY, i, j)/B_size, 0, 1)*B_power;
        }
      }
      int pos = i + j * width;
      if(simple){
        pixels[pos] = color((a-b)*255);
      }
      else{
        pixels[pos] = color((a-b)*255, (spot.feed-feed)*36000+127, (spot.k-k)*36000+127);
      }
    }
  }
  updatePixels();
}