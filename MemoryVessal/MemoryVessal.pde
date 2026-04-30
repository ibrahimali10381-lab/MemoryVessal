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
float cloudMove =150;
int cloud1 = 150;
int cloud2 = 350;
int cloud3 = 600;

// Setup
void setup() {
  size(900, 900);
}


// Draw
void draw() {
  noStroke();
  background(sky);

  fill(sand);
  rect(0, 450, 900, 450);
  for (float x = 0; x<= 900; x+= 5) {
    interA = lerpColor(wto, from, x/450);
    fill(interA);
    for (float y = 350; y <= 650; y+= 1) {
      rect(x, y, 5, 1);
    }
  }

  drawCloud(cloudMove, 150, 100, cloud1);
  drawCloud(cloudMove, 200, 80, cloud2);
  drawCloud(cloudMove, 120, 120, cloud3);

  drawPalmTree(750, 750);
  drawPalmTree(850, 680);

  if (cloudMove <= 1000) {
    cloudMove += 10;
  } else {
    cloudMove = -652;
  }
}


void drawCloud(float x, float y, float size, int num) {
  fill(cloudColor);
  ellipse(num + x, y, size, size * 0.6);
  ellipse(num +x + size * 0.4, y + size * 0.1, size * 0.8, size * 0.5);
  ellipse(num + x - size * 0.3, y - size * 0.1, size * 0.7, size * 0.5);
}

void drawPalmTree(float x, float y) {
  fill(trunkColor);
  rect(x - 5, y, 10, 150);
  fill(foliageColor);
  ellipse(x, y - 10, 60, 40);
  ellipse(x, y - 30, 80, 50);
  ellipse(x, y - 50, 100, 60);
}



void drawScallop(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  for (int i = -3; i <= 3; i++) {
    arc(i * size * 0.15, 0, size * 0.6, size, PI, TWO_PI);
  }
  popMatrix();
}

void drawStarfish(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  beginShape();
  for (int i = 0; i < 10; i++) {
    float angle = i * TWO_PI / 10;
    float r = (i % 2 == 0) ? size : size * 0.4;
    vertex(cos(angle) * r, sin(angle) * r);
  }
  endShape(CLOSE);
  popMatrix();
}

void drawSandDollar(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  ellipse(0, 0, size, size);
  
  for (int i = 0; i < 5; i++) {
    float angle = i * TWO_PI / 5;
    line(0, 0, cos(angle) * size * 0.3, sin(angle) * size * 0.3);
  }
  popMatrix();
}

void drawClam(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  for (int i = 0; i < 5; i++) {
    arc(0, i * 5, size, size * 0.6, PI, TWO_PI);
  }
  popMatrix();
}

void drawSpiralShell(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  noFill();
  beginShape();
  for (float t = 0; t < 4 * PI; t += 0.1) {
    float r = size * 0.05 * t;
    float px = cos(t) * r;
    float py = sin(t) * r;
    vertex(px, py);
  }
  endShape();
  popMatrix();
}

void drawSnailShell(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  noFill();
  
  beginShape();
  for (float t = 0; t < 3 * PI; t += 0.1) {
    float r = size * 0.07 * t;
    vertex(cos(t) * r, sin(t) * r);
  }
  endShape();
  
  popMatrix();
}
