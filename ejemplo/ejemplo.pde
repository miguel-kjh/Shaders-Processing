PShader sh;
boolean paintCircules;

float[] v1,v2;

void setup(){
  size(640,640,P3D);
  sh            = loadShader("shader.glsl");
  v1            = new float[2];
  v1[0]         = random(0.,.99);
  v1[1]         = random(0.,.99);
  
  v2            = new float[2];
  v2[0]         = random(0.,.99);
  v2[1]         = random(0.,.99);
  println(v1);
  println(v2);
  sh.set("u_pos1",v1[0], v1[1]);
  sh.set("u_pos2",v2[0], v2[1]);
}

void draw(){
  background(0);
  shader(sh);
  sh.set("u_mouse",float(mouseX),float(mouseY));
  sh.set("u_resolution",float(width),float(height));
  float toSeconds = 1000.0; 
  sh.set("u_time",millis()/toSeconds);
  rect(0,0,width,height);
  paintCircules = false;
}
