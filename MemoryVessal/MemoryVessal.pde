// Palllette
color sand = #FFD16C;
color lightBlue = #65b2CA;
color darkBlue = #186690;
color sky = #A2DAF7;
color from = lightBlue;
color wto = darkBlue;
color interA;
color foliageColor = #4CAF50;
color trunkColor = #8B4513;
color cloudColor = #FFFFFF;
color Star = #D34F4F;
float cloudMove =150;
int cloud1 = 150;
int cloud2 = 350;
int cloud3 = 600;
int waveMove;
int waveSize;
boolean waveMoving;
int pos = int(random(100));
int t = 0;
boolean WaveBack;
boolean shellSpawned;
int shellnum = 6;

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

  drawCloud(cloudMove, 150, 100, cloud1);

  if (cloud1 <= 1000) {
    cloud1 += random(2);
  } else {
    cloud1 = -200;
  }

  drawCloud(cloudMove, 200, 80, cloud2);


  if (cloud2 <= 1000) {
    cloud2 += random(3);
  } else {
    cloud2 = -200;
  }
  drawCloud(cloudMove, 120, 120, cloud3);
  if (cloud3 <= 1000) {
    cloud3 += random(4);
  } else {
    cloud3 = -200;
  }



  if (t == 200) {
    pos = int(random(1000));
    drawWave(pos, 600, 10, waveMove);
    waveMoving = true;
    t = 0;
    waveMove = 0;
    waveSize = 0;
    shellSpawned = false;
  }
  if (waveMoving == true && waveMove <= 100 && WaveBack == false) {
    waveMove += 1;
    waveSize += 1;
    drawWave(pos, 600, waveSize, waveMove);
  } else if (waveMoving == true && waveMove <= 200 && waveMove >=0) {
    waveMove -= 1;
    waveSize -= 1;
    drawWave(pos, 600, waveSize, waveMove);
    WaveBack = true;
  } else {
    WaveBack = false;
  }


  t += 1;


  for (float x = 0; x<= 900; x+= 5) {
    interA = lerpColor(wto, from, x/450);
    fill(interA);
    for (float y = 350; y <= 650; y+= 1) {
      rect(x, y, 5, 1);
    }
  }

  drawPalmTree(750, 750);
  drawPalmTree(850, 680);
  if (waveMoving == true && shellSpawned == false) {
    shellnum = int(random(5));
    shellSpawned = true;
  } else if (shellSpawned == true) {
    randomShell(shellnum, pos, 800);
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


void drawWave(float x, float y, float size, int move) {
  fill(darkBlue);
  ellipse( x, y+ move, size+30, size * 1.6);
  fill(interA);
  ellipse( x, y+ move, size+20, size * 1.5);
  fill(lightBlue);
  ellipse(x, y +move, size+10, size * 1.4);
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

void randomShell(int num, float x, float y) {
  fill(Star);
  if (num == 0) {
    drawScallop(x, y, 20);
  }
  if (num == 1) {
    drawStarfish(x, y, 20);
  }
  if (num == 2) {
    drawSandDollar(x, y, 20);
  }
  if (num == 3) {
    drawSpiralShell(x, y, 20);
  }
  if (num == 4) {
    drawSnailShell(x, y, 20);
  }
  if (num == 5) {
    drawScallop(x, y, 20);
  }
}
