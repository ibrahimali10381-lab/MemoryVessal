// ── Palette ────────────────────────────────────────────────────
color sand        = #F5C96A;
color skyTop      = #5AABDE;   // deeper blue at the zenith
color skyBottom   = #C2E8F7;   // pale haze near the horizon
color oceanDeep   = #1E7EA1;   // dark teal far water
color oceanShallow= #4FBACF;   // lighter near shore
color foam        = #E8F6FA;   // wave foam
color islandRock  = #8B5E3C;   // rocky headland
color islandGrass = #4B7C2D;   // scrub on top of island
color trunkColor  = #7A4E2C;
color leafColor   = #3A7D27;
color leafLight   = #5CAF3E;   // lighter frond highlight
color cloudWhite  = #FFFFFF;
color cloudShadow = #D8EEF6;   // cool underside of cloud
color boatHull    = #E8DDB5;
color boatLine    = #8B6040;

// ── Horizon and shore Y positions ──────────────────────────────
float horizon  = 310;   // where sky meets sea
float shoreTop = 420;   // where ocean meets sand

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
  drawCloud(140, 110, 110); // large cloud top-left
  drawCloud(370, 145,  80); // small cloud centre
  drawCloud(620,  90, 130); // large cloud right
  drawPalmTree(790, 590, 220, -0.15);  // tall tree, right side
  drawPalmTree(870, 560, 170,  0.10);  // shorter tree, far right
  drawPalmTree(840, 520, 130, -0.25);  // leaning tree background
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

// ── Boat: simple wooden dinghy silhouette ─────────────────────────
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

// ── Cloud: layered ellipses with a faint shadow base ─────────────
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

// ── Palm tree: leaning trunk + layered fronds ────────────────────
// lean: negative = leans left, positive = leans right
void drawPalmTree(float bx, float by, float h, float lean) {
  strokeWeight(0);
  noStroke();
  // trunk (tapered, slightly curved via segments)
  int segs = 12;
  for (int i = 0; i < segs; i++) {
    float t0 = i       / float(segs);
    float t1 = (i + 1) / float(segs);
    float x0 = bx + lean * h * t0 * t0;
    float y0 = by - h * t0;
    float x1 = bx + lean * h * t1 * t1;
    float y1 = by - h * t1;
    float w0 = lerp(14, 5, t0);   // wide at base, narrow at tip
    fill(lerpColor(#5C3A1E, trunkColor, t0));
    beginShape();
      vertex(x0 - w0, y0);
      vertex(x0 + w0, y0);
      vertex(x1 + w0 * 0.6, y1);
      vertex(x1 - w0 * 0.6, y1);
    endShape(CLOSE);
  }
  // tip position after curve
  float tx = bx + lean * h;
  float ty = by - h;
  // fronds radiating from the crown
  drawFrond(tx, ty,  -80, 100, leafColor);   // left droop
  drawFrond(tx, ty,  -50,  90, leafColor);
  drawFrond(tx, ty,  -20,  85, leafLight);   // near-upright, lighter
  drawFrond(tx, ty,   10,  90, leafColor);
  drawFrond(tx, ty,   40, 100, leafColor);   // right droop
  drawFrond(tx, ty,  -140,  70, leafColor);  // rear frond for volume
  drawFrond(tx, ty,   130,  70, leafColor);
}

// ── Single palm frond: tapered leaf blade with midrib ─────────────
void drawFrond(float x, float y, float angleDeg, float len, color c) {
  pushMatrix();
  translate(x, y);
  rotate(radians(angleDeg));
  // leaf blade
  fill(c);
  noStroke();
  beginShape();
    vertex(0, 0);
    vertex(len * 0.25,  -6);
    vertex(len,          0);
    vertex(len * 0.25,   6);
  endShape(CLOSE);
  // midrib (darker line along centre)
  stroke(#2A5C18);
  strokeWeight(0.8);
  line(0, 0, len, 0);
  popMatrix();
}
