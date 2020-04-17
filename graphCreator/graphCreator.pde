PShader sh;
boolean paintPoint;
Graph graph;
int typeSpeed;
float toSeconds;


void setup(){
  size(640,640,P3D);
  sh = loadShader("shader.glsl");
  paintPoint = false;
  graph = new Graph();
  typeSpeed = 1;
  toSeconds = 1000.0; 
}

void draw(){
  background(0);
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

class Graph {
  private ArrayList<PVector> graph;
  
  public Graph(){
     graph = new ArrayList<PVector>();
  }
  
  public Graph(int num){
    graph = new ArrayList<PVector>();
    for(int i = 0; i < num; i++){
      graph.add(new PVector(random(0.,0.99),random(0.,0.99)));
    }
  }
  
  public void addVertx(float x, float y){
    graph.add(new PVector(x,y));
  }
  
  public void deleteVertx(){
    if(graph.size() > 0){
      graph.remove(graph.size()-1);
    }
  }
  
  public boolean isEmpty(){
    return this.graph.isEmpty();
  }
  
  public float[] getVecX(){
    float[] vecX = new float[graph.size()];
    for(int i = 0; i < graph.size(); i++){
      vecX[i] = graph.get(i).x;
    }
    return vecX;
  }
  
  public float[] getVecY(){
    float[] vecY = new float[graph.size()];
    for(int i = 0; i < graph.size(); i++){
      vecY[i] = graph.get(i).y;
    }
    return vecY;
  }
  
  public int getSize(){
    return graph.size();
  }
}

void keyPressed(){
  int max = 4;
  if(key == 's'){
    typeSpeed = 1;
    toSeconds = 1000.0; 
  }
  if(key == 'v'){
    if(typeSpeed == max){
      typeSpeed = 1;
      toSeconds = 1000.0; 
      //println(typeSpeed);
      return;
    }
    typeSpeed += 1;
    toSeconds += 3000.0; 
  }
  if(key == 'd'){
    graph.deleteVertx();
    if(graph.isEmpty()){
      typeSpeed = 1;
      toSeconds = 1000.0; 
    }
  }
  //println(typeSpeed);
}
