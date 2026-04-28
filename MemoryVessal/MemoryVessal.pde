// --- New Colors ---
color sand = #FFD16C;
color lightBlue = #65b2CA;
color darkBlue = #186690;
color sky = #A2DAF7;
color from = lightBlue;
color wto = darkBlue;
color interA;
color interB;

// New constants for tree and cloud colors
color foliageColor = #4CAF50;
color trunkColor = #8B4513;
color cloudColor = #FFFFFF; 

// --- Setup remains the same ---
void setup() {
  size(900, 900);
}

// --- draw() Method with New Elements ---
void draw() {
  background(sky);
  noStroke();

  // 1. Draw the Sand
  fill(sand);
  rect(450, 450, 450, 450);

  // 2. Draw the Water Gradient
  // This uses lerpColor to create the smooth transition
  for(float x = 0; x<= 450; x+= 1){
    interA = lerpColor(wto, from, x/450);
    fill(interA);
    rect(x,450,1,450);
  }
  
  // 3. New Elements below this line
  // --- Draw Clouds ---
  drawCloud(150, 150, 100);
  drawCloud(350, 200, 80);
  drawCloud(600, 120, 120);

  // --- Draw Trees (Simple Palms) ---
  drawPalmTree(50, 750);
  drawPalmTree(150, 680);
}

// --- Custom functions to keep draw() clean ---

// draws a simple cluster cloud
void drawCloud(float x, float y, float size) {
  fill(cloudColor);
  ellipse(x, y, size, size * 0.6);
  ellipse(x + size * 0.4, y + size * 0.1, size * 0.8, size * 0.5);
  ellipse(x - size * 0.3, y - size * 0.1, size * 0.7, size * 0.5);
}

// draws a stylized palm tree
void drawPalmTree(float x, float y) {
  // Draw the trunk
  fill(trunkColor);
  rect(x - 5, y, 10, 150); // thin rectangle
  
  // Draw the fronds (simplified foliage)
  fill(foliageColor);
  // Stacked circles create a basic 'leafy' shape
  ellipse(x, y - 10, 60, 40); 
  ellipse(x, y - 30, 80, 50); 
  ellipse(x, y - 50, 100, 60); 
}
