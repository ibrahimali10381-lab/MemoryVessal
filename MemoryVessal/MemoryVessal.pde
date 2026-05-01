color sand = #FFD16C;
color lightBlue = #65B2CA;
color darkBlue = #186690;
color sky = #A2DAF7;
color from = lightBlue;
color wto = darkBlue;
color interA;
color foliageColor = #4CAF50;
color trunkColor = #8B4513;
color cloudColor = #FFFFFF;

float cloudMove = 150;
int cloud1 = 150;
int cloud2 = 350;
int cloud3 = 600;

int waveMove;
int waveSize;
boolean waveMoving;
int pos = int(random(100, 800));
int t = 0;
boolean WaveBack;
boolean shellSpawned;
int shellnum = 6;

ArrayList<int[]> shells = new ArrayList<int[]>();

int sceneTimer = 0;
boolean transitioning = false;
boolean showcase = false;
float fadeAlpha = 0;

void setup() {
  size(900, 900);
}

void draw() {
  sceneTimer++;

  if (!showcase && !transitioning && sceneTimer >= 1200) {
    transitioning = true;
    fadeAlpha = 0;
  }

  if (transitioning) {
    fadeAlpha += 3;
    if (fadeAlpha >= 255) {
      fadeAlpha = 255;
      transitioning = false;
      showcase = true;
    }
  }

  if (!showcase) {
    drawBeachScene();
    if (transitioning) {
      fill(0, fadeAlpha);
      noStroke();
      rect(0, 0, width, height);
    }
  } else {
    drawShowcase();
  }
}

void drawBeachScene() {
  noStroke();
  background(sky);
  fill(sand);
  rect(0, 450, 900, 450);

  drawCloud(cloudMove, 150, 100, cloud1);
  if (cloud1 <= 1100) cloud1 += random(2);
  else cloud1 = -200;

  drawCloud(cloudMove, 200, 80, cloud2);
  if (cloud2 <= 1100) cloud2 += random(3);
  else cloud2 = -200;

  drawCloud(cloudMove, 120, 120, cloud3);
  if (cloud3 <= 1100) cloud3 += random(4);
  else cloud3 = -200;

  for (int[] s : shells) {
    drawShell(s[0], s[1], s[2], 22);
  }

  for (float x = 0; x <= 900; x += 5) {
    interA = lerpColor(wto, from, x / 450);
    fill(interA);
    for (float y = 350; y <= 650; y += 1) {
      rect(x, y, 5, 1);
    }
  }

  if (t == 200) {
    pos = int(random(100, 800));
    waveMoving = true;
    WaveBack = false;
    t = 0;
    waveMove = 0;
    waveSize = 0;
    shellSpawned = false;
  }

  if (waveMoving && waveMove <= 100 && !WaveBack) {
    waveMove += 1;
    waveSize += 1;
    drawWave(pos, 600, waveSize, waveMove);
    if (waveMove == 50 && !shellSpawned) {
      shellnum = int(random(5));
      shells.add(new int[]{shellnum, pos, 695});
      shellSpawned = true;
    }
  } else if (waveMoving && waveMove >= 0 && WaveBack) {
    waveMove -= 1;
    waveSize -= 1;
    drawWave(pos, 600, max(waveSize, 0), waveMove);
    if (waveMove <= 0) {
      waveMoving = false;
      WaveBack = false;
    }
  } else if (waveMoving && waveMove > 100) {
    WaveBack = true;
  }

  t += 1;

  noStroke();
  drawPalmTree(750, 750);
  drawPalmTree(850, 680);
}

void drawShowcase() {
  background(#F5ECD7);
  noStroke();
  fill(#D4B896);
  rect(0, 860, 900, 40);

  fill(#8B6F47);
  textSize(22);
  textAlign(CENTER);
  text("Shell Collection", 450, 80);

  String[] names = {"Scallop", "Starfish", "Sand Dollar", "Spiral Shell", "Snail Shell", "Scallop"};
  int[] cols = {0, 1, 2, 0, 1, 2};
  int[] rows = {0, 0, 0, 1, 1, 1};

  for (int i = 0; i < 6; i++) {
    float cx = 180 + cols[i] * 260;
    float cy = 280 + rows[i] * 300;

    fill(255, 240, 210);
    stroke(#C8A870);
    strokeWeight(1);
    rect(cx - 90, cy - 110, 180, 200, 12);

    noStroke();
    drawShell(i < 5 ? i : 0, cx, cy + 10, 50);

    fill(#8B6F47);
    textSize(14);
    textAlign(CENTER);
    text(names[i], cx, cy + 90);
  }
}

void drawShell(int type, float x, float y, float size) {
  if (type == 0) drawScallop(x, y, size);
  else if (type == 1) drawStarfish(x, y, size);
  else if (type == 2) drawSandDollar(x, y, size);
  else if (type == 3) drawSpiralShell(x, y, size);
  else if (type == 4) drawSnailShell(x, y, size);
  else drawScallop(x, y, size);
}

void drawScallop(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  fill(#E8C87A);
  stroke(#B8924A);
  strokeWeight(1);
  arc(0, 0, size * 2, size * 1.6, PI, TWO_PI);
  stroke(#B8924A);
  strokeWeight(0.8);
  for (int i = 0; i <= 7; i++) {
    float angle = PI + (i * PI / 7);
    line(0, 0, cos(angle) * size, sin(angle) * size);
  }
  noStroke();
  fill(#B8924A);
  ellipse(0, 0, size * 0.3, size * 0.2);
  popMatrix();
}

void drawStarfish(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  fill(#D4724A);
  stroke(#A84C28);
  strokeWeight(1);
  beginShape();
  for (int i = 0; i < 10; i++) {
    float angle = i * TWO_PI / 10 - HALF_PI;
    float r = (i % 2 == 0) ? size : size * 0.42;
    vertex(cos(angle) * r, sin(angle) * r);
  }
  endShape(CLOSE);
  noStroke();
  fill(#C25E38);
  for (int i = 0; i < 5; i++) {
    float angle = i * TWO_PI / 5 - HALF_PI;
    for (float d = size * 0.25; d <= size * 0.85; d += size * 0.22) {
      ellipse(cos(angle) * d, sin(angle) * d, size * 0.12, size * 0.12);
    }
  }
  fill(#A84C28);
  ellipse(0, 0, size * 0.32, size * 0.32);
  popMatrix();
}

void drawSandDollar(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  fill(#F0DEB0);
  stroke(#C8A870);
  strokeWeight(1);
  ellipse(0, 0, size * 2, size * 2);
  noFill();
  stroke(#C8A870);
  strokeWeight(1);
  for (int i = 0; i < 5; i++) {
    float angle = i * TWO_PI / 5 - HALF_PI;
    float cx = cos(angle) * size * 0.38;
    float cy = sin(angle) * size * 0.38;
    ellipse(cx, cy, size * 0.48, size * 0.68);
  }
  fill(#C8A870);
  noStroke();
  for (int i = 0; i < 5; i++) {
    float angle = i * TWO_PI / 5 - HALF_PI + (TWO_PI / 10);
    ellipse(cos(angle) * size * 0.92, sin(angle) * size * 0.92, size * 0.18, size * 0.18);
  }
  fill(#C8A870);
  ellipse(0, 0, size * 0.15, size * 0.15);
  popMatrix();
}

void drawSpiralShell(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  noStroke();
  for (float r = size; r > size * 0.08; r -= size * 0.06) {
    float t2 = map(r, size, size * 0.08, 0, 4 * PI);
    color c1 = lerpColor(#E07050, #F0C090, 1 - r / size);
    fill(c1);
    float px = cos(t2) * r;
    float py = sin(t2) * r;
    ellipse(px, py, r * 0.5, r * 0.5);
  }
  stroke(#B05030);
  strokeWeight(1.2);
  noFill();
  beginShape();
  for (float tt = 0; tt < 4 * PI; tt += 0.08) {
    float r = size * 0.05 * (tt + 0.5);
    vertex(cos(tt) * r, sin(tt) * r);
  }
  endShape();
  noStroke();
  fill(#D06040);
  ellipse(0, 0, size * 0.25, size * 0.25);
  popMatrix();
}

void drawSnailShell(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  fill(#9B6B4A);
  stroke(#6B3B2A);
  strokeWeight(1);
  ellipse(0, -size * 0.1, size * 1.8, size * 1.4);
  noFill();
  stroke(#6B3B2A);
  strokeWeight(0.9);
  ellipse(0, -size * 0.1, size * 1.3, size * 1.0);
  ellipse(0, -size * 0.1, size * 0.8, size * 0.6);
  ellipse(0, -size * 0.1, size * 0.4, size * 0.3);
  fill(#3B1A10);
  noStroke();
  arc(size * 0.55, size * 0.3, size * 0.55, size * 0.55, HALF_PI, PI + HALF_PI);
  stroke(#6B3B2A);
  strokeWeight(1);
  noFill();
  arc(size * 0.55, size * 0.3, size * 0.6, size * 0.6, HALF_PI, PI + HALF_PI);
  noStroke();
  popMatrix();
}

void drawCloud(float x, float y, float size, int num) {
  fill(cloudColor);
  noStroke();
  ellipse(num + x, y, size, size * 0.6);
  ellipse(num + x + size * 0.4, y + size * 0.1, size * 0.8, size * 0.5);
  ellipse(num + x - size * 0.3, y - size * 0.1, size * 0.7, size * 0.5);
}

void drawPalmTree(float x, float y) {
  noStroke();
  fill(trunkColor);
  rect(x - 5, y, 10, 150);
  fill(foliageColor);
  ellipse(x, y - 10, 60, 40);
  ellipse(x, y - 30, 80, 50);
  ellipse(x, y - 50, 100, 60);
}

void drawWave(float x, float y, float size, int move) {
  noStroke();
  fill(darkBlue);
  ellipse(x, y + move, size + 30, size * 1.6);
  fill(interA);
  ellipse(x, y + move, size + 20, size * 1.5);
  fill(lightBlue);
  ellipse(x, y + move, size + 10, size * 1.4);
}
