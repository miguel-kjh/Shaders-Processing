PShader sh;
boolean paintPoint;
float[] vecX = {random(0.,.99), random(0.,.99),random(0.,.99), random(0.,.99)};
float[] vecY = {random(0.,.99), random(0.,.99),random(0.,.99), random(0.,.99)};

void setup(){
  size(640,640,P3D);
  sh = loadShader("shader.glsl");
  paintPoint = false;
  sh.set("u_vecX",vecX);
  sh.set("u_vecY",vecY);
}

void draw(){
  background(0);
  shader(sh);
  sh.set("u_mouse",float(mouseX),float(mouseY));
  sh.set("u_resolution",float(width),float(height));
  float toSeconds = 3000.0; 
  sh.set("u_time",millis()/toSeconds);
  sh.set("u_paintPoint",paintPoint);
  rect(0,0,width,height);
}

void mousePressed(){
  paintPoint = true;
}

void mouseReleased(){
  paintPoint = false;
}
