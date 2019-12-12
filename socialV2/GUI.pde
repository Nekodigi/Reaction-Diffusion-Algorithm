ControlP5 controlP5;
int sliderValue;

void setupGUI() {
  ControlFont cf1 = new ControlFont(createFont("Source Code Pro",20));
  colorMode(HSB, 360, 100, 100, 100);
  controlP5 = new ControlP5(this)
  .setColorBackground(color(300,50))
  .setColorForeground(color(150,100,100,80))
  .setColorActive(color(150,50,80,1000))
  .setColorValueLabel(color(50))
  .setColorCaptionLabel(color(50));
  controlP5.setFont(cf1);
  ControlGroup ctrl = controlP5.addGroup("setting", 15, 25, 35);
  ctrl.activateEvent(true);
  ctrl.setColorLabel(color(0));
  int posX = 50;
  controlP5.addSlider("basePopulationIncrease", -5, 5, 0, posX, 1000, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  controlP5.addSlider("wealthPopulationIncrease", 0, -10, 0, posX, 1000, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  controlP5.addSlider("maxPopulation", 0, 10, 0, posX, 1000, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  controlP5.addSlider("minpopulation", -3, 3, 0, posX, 1000, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  controlP5.addSlider("capaOverThingsIncrease", -3, 3, 0, posX, 1000, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  controlP5.addSlider("thingsRange", 0.8, 10, 0, posX, 1000, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  //controlP5.addSlider("basePopulationIncrease", 0, 2, 0, posX, 1000, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  //controlP5.addSlider("basePopulationIncrease", 0, 2, 0, posX, 1000, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  //controlP5.addSlider("basePopulationIncrease", 0, 2, 0, posX, 1000, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  //controlP5.addSlider("basePopulationIncrease", -3, 3, 0, posX, 1000, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  //controlP5.addSlider("basePopulationIncrease", 0, 2, 0, posX, 1000, 30);
  posX += 50;
  controlP5.addToggle("populationLimitEnable", false, 0, posX, 30, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  controlP5.addToggle("AutoSpawnEnable", true, 0, posX, 30, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  controlP5.addToggle("thingsSpread", true, 0, posX, 30, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  controlP5.addToggle("populationSpread", true, 0, posX, 30, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  controlP5.addToggle("parlinEnable", false, 0, posX, 30, 30).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
  posX += 50;
  controlP5.addButton("Gridclear", 0 , 0, posX, 200, 50).setGroup(ctrl).getCaptionLabel().setColorBackground(color(360,80));
}