// Palllette
color sand = #FFD16C;
color lightBlue = #65b2CA;
color darkBlue = #186690;
color sky = #A2DAF7;
color from = lightBlue;
color wto = darkBlue;
color interA;
color interB;
color foliageColor = #4CAF50;
color trunkColor = #8B4513;
color cloudColor = #FFFFFF;
float y = 350;

// Setup
void setup() {
  size(900, 900);
}


// Draw
void draw() {
  noStroke();

  fill(sand);
  rect(0, 450, 900, 450);
  for (float x = 0; x<= 650; x+= 1) {
    interA = lerpColor(wto, from, x/450);
    fill(interA);
    ellipse(x, y+x/15, 1, 1);
  }


  drawCloud(150, 150, 100);
  drawCloud(350, 200, 80);
  drawCloud(600, 120, 120);

  drawPalmTree(750, 750);
  drawPalmTree(850, 680);
}


void drawCloud(float x, float y, float size) {
  fill(cloudColor);
  ellipse(x, y, size, size * 0.6);
  ellipse(x + size * 0.4, y + size * 0.1, size * 0.8, size * 0.5);
  ellipse(x - size * 0.3, y - size * 0.1, size * 0.7, size * 0.5);
}

void drawPalmTree(float x, float y) {
  fill(trunkColor);
  rect(x - 5, y, 10, 150);
  fill(foliageColor);
  ellipse(x, y - 10, 60, 40);
  ellipse(x, y - 30, 80, 50);
  ellipse(x, y - 50, 100, 60);
}
