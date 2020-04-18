PShader sh;
boolean paintPoint;
Graph graph;
int typeSpeed;
float toSeconds;
StarMenu startMenu;
Menu keyMenu;
int maxType;


void setup(){
  size(640,640,P3D);
  sh          = loadShader("shader.glsl");
  paintPoint  = false;
  graph       = new Graph();
  typeSpeed   = 1;
  toSeconds   = 1000.0;
  startMenu   = new StarMenu();
  keyMenu     = new KeyMenu();
  maxType     = 4;
}

void draw(){
  background(0);
  if(startMenu.hasToBePainted()){
    startMenu.paintMenu();
    if(startMenu.nextMenuKey()){
      keyMenu.allowToPaint();
    } else {
      keyMenu.prohibitPainting();
    }
    return;
  }
  if(keyMenu.hasToBePainted()){
    keyMenu.paintMenu();
    return;
  }
  defineShader();
}

void defineShader(){
  shader(sh);
  sh.set("u_mouse",float(mouseX),height-float(mouseY));
  sh.set("u_resolution",float(width),float(height));
  sh.set("u_vecX", graph.getVecX());
  sh.set("u_vecY", graph.getVecY());
  sh.set("u_size", graph.getSize());
  sh.set("u_time",millis()/toSeconds);
  sh.set("u_paintPoint",paintPoint);
  sh.set("u_typeSpeed",typeSpeed);
  rect(0,0,width,height);
}

void mousePressed(){
  paintPoint = true;
}

void mouseReleased(){
  paintPoint = false;
  graph.addVertx(float(mouseX)/width,(height-float(mouseY))/height);
}

void keyPressed(){
  if(startMenu.hasToBePainted() && keyCode == ENTER){
    startMenu.prohibitPainting();
  }
  if(startMenu.hasToBePainted() && keyCode == RIGHT){
    startMenu.chooseKey();
  }
  if(startMenu.hasToBePainted() && keyCode == LEFT){
    startMenu.chooseStart();
  }
  if(!startMenu.hasToBePainted() && !keyMenu.hasToBePainted()){
    if(key == 's' || key == 'S'){
      typeSpeed = 1;
      toSeconds = 1000.0; 
    }
    if(key == 'v' || key == 'V'){
      if(typeSpeed == maxType){
        typeSpeed = 1;
        toSeconds = 1000.0; 
        return;
      }
      typeSpeed += 1;
      switch(typeSpeed){
        case 2:
         toSeconds = 1000.0;
         break;
        case 3:
         toSeconds = 2000.0;
         break;
        case 4:
         toSeconds = 1000.0;
         break;
      } 
    }
    if(key == 'd' || key == 'D'){
      graph.deleteVertx();
      if(graph.isEmpty()){
        typeSpeed = 1;
        toSeconds = 1000.0; 
      }
    }
    if(key == 'r' || key == 'R'){
      graph.removeAll();
      typeSpeed = 1;
      toSeconds = 1000.0; 
    }
  }
  if(key == 'f' || key == 'F'){
      if(keyMenu.hasToBePainted()){
        keyMenu.prohibitPainting();
        startMenu.allowToPaint();
      } else if(!startMenu.hasToBePainted() && !keyMenu.hasToBePainted()){
        startMenu.allowToPaint();
        resetShader();
      }
   }
}
