// ── Palette ────────────────────────────────────────────────────
color sand        = #F5C96A;
color skyTop      = #5AABDE;   
color skyBottom   = #C2E8F7;   
color oceanDeep   = #1E7EA1;  
color oceanShallow= #4FBACF;   
color foam        = #E8F6FA;  
color islandRock  = #8B5E3C;  
color islandGrass = #4B7C2D;   
color trunkColor  = #7A4E2C;
color leafColor   = #3A7D27;
color leafLight   = #5CAF3E;   
color cloudWhite  = #FFFFFF;
color cloudShadow = #D8EEF6;  
color boatHull    = #E8DDB5;
color boatLine    = #8B6040;

float horizon  = 310;  
float shoreTop = 420;   

// ── Setup ──────────────────────────────────────────────────────
void setup() {
  size(900, 600);
}

// ── Draw ───────────────────────────────────────────────────────
void draw() {
  drawSky();
  drawOcean();
  drawSand();
  drawIsland(200, 280);     // rocky island mid-left
  drawBoat(320, 305);       // small boat floating in the bay
  drawFoam();               // gentle wave line at shore
  drawCloud(140, 110, 110); 
  drawCloud(370, 145,  80); 
  drawCloud(620,  90, 130); 
  drawPalmTree(790, 590, 220, -0.15);  
  drawPalmTree(870, 560, 170,  0.10);  
  drawPalmTree(840, 520, 130, -0.25);  
}

// ── Sky: vertical gradient from deep blue (top) to pale (horizon) ──
void drawSky() {
  for (int y = 0; y <= horizon; y++) {
    float t = y / horizon;
    color c = lerpColor(skyTop, skyBottom, t);
    stroke(c);
    line(0, y, width, y);
  }
}

// ── Ocean: two colour bands + subtle horizontal shimmer ──────────
void drawOcean() {
  noStroke();
  // far water (narrow deep-blue band near horizon)
  fill(oceanDeep);
  rect(0, horizon, width, (shoreTop - horizon) * 0.45);
  // nearer water transitions to a lighter turquoise
  for (float y = horizon + (shoreTop - horizon) * 0.45; y < shoreTop; y++) {
    float t = (y - horizon) / (shoreTop - horizon);
    color c = lerpColor(oceanDeep, oceanShallow, t);
    fill(c);
    rect(0, y, width, 1);
  }
  // light shimmer streaks across the middle distance
  stroke(255, 255, 255, 30);
  strokeWeight(1);
  for (int i = 0; i < 8; i++) {
    float sy = horizon + 30 + i * 10;
    line(50, sy, 180 + i * 20, sy);
    line(500 + i * 15, sy, 680 + i * 12, sy);
  }
}

// ── Sand: flat golden fill below the shore ───────────────────────
void drawSand() {
  noStroke();
  fill(sand);
  rect(0, shoreTop, width, height - shoreTop);
  // subtle darker band at the wet-sand edge
  fill(#D4A94F, 80);
  rect(0, shoreTop, width, 18);
}

// ── Ocean foam / wave line where water meets sand ────────────────
void drawFoam() {
  noStroke();
  fill(foam);
  // irregular ellipses that mimic a gentle wave
  ellipse(120, shoreTop + 6, 200, 12);
  ellipse(420, shoreTop + 5, 260, 10);
  ellipse(730, shoreTop + 7, 180, 11);
  fill(255, 255, 255, 120);
  ellipse(270, shoreTop + 3, 120, 7);
  ellipse(600, shoreTop + 4, 100, 6);
}

// ── Island: rocky shape with a green scrub cap ───────────────────
void drawIsland(float x, float y) {
  // main rocky mass (rough triangle-ish shape)
  fill(islandRock);
  noStroke();
  beginShape();
    vertex(x - 55, y + 25);
    vertex(x - 40, y);
    vertex(x - 10, y - 18);
    vertex(x + 15, y - 22);
    vertex(x + 50, y - 8);
    vertex(x + 65, y + 25);
  endShape(CLOSE);
  // green vegetation on top
  fill(islandGrass);
  ellipse(x + 5, y - 20, 60, 28);
  fill(#3D6B22);   // darker patch for depth
  ellipse(x - 8, y - 15, 30, 18);
  // subtle shadow on water face
  fill(0, 0, 0, 30);
  beginShape();
    vertex(x + 45, y - 5);
    vertex(x + 65, y + 25);
    vertex(x + 30, y + 25);
  endShape(CLOSE);
}

void drawBoat(float x, float y) {
  noStroke();
  // hull
  fill(boatHull);
  beginShape();
    vertex(x - 22, y);
    vertex(x + 22, y);
    vertex(x + 16, y + 9);
    vertex(x - 16, y + 9);
  endShape(CLOSE);
  // gunwale line
  stroke(boatLine);
  strokeWeight(1.5);
  line(x - 22, y, x + 22, y);
  noStroke();
}

void drawCloud(float x, float y, float sz) {
  // cool underside shadow
  fill(cloudShadow);
  ellipse(x,             y + sz * 0.18, sz * 1.1, sz * 0.35);
  ellipse(x + sz * 0.4,  y + sz * 0.25, sz * 0.8, sz * 0.30);
  // bright white body
  fill(cloudWhite);
  ellipse(x,             y,             sz,        sz * 0.55);
  ellipse(x + sz * 0.38, y + sz * 0.08, sz * 0.78, sz * 0.50);
  ellipse(x - sz * 0.30, y + sz * 0.05, sz * 0.65, sz * 0.48);
  ellipse(x + sz * 0.12, y - sz * 0.12, sz * 0.55, sz * 0.45);
}
