PShader sh;

void setup(){
  size(640,640,P3D);
  sh = loadShader("shader.glsl");
}

void draw(){
  background(0);
  shader(sh);
  sh.set("u_mouse",float(mouseX),float(mouseY));
  sh.set("u_resolution",float(width),float(height));
  float toSeconds = 1000.0; 
  sh.set("u_time",millis()/toSeconds);
  rect(0,0,width,height);
  delay(1000);
}
