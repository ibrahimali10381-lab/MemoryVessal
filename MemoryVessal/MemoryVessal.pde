color sand =#FFD16C;
color lightBlue = #65b2CA;
color darkBlue =#186690;
color sky =#A2DAF7;
color from = lightBlue;
color wto = darkBlue;
color interA;
color interB;

void setup() {
  size(900, 900);
  background(sky);
}


void draw() {
  noStroke();
  fill(sand);
  rect(450, 450, 450, 450);
  for(float x = 0; x<= 450; x+= 1){
    interA = lerpColor(wto, from, x/450);
    fill(interA);
    rect(x,450,1,450);
  }
}
