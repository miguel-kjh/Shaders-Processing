PShader sh;
boolean paintPoint;
Graph graph;

void setup(){
  size(640,640,P3D);
  sh = loadShader("shader.glsl");
  paintPoint = false;
  graph = new Graph();
}

void draw(){
  background(0);
  shader(sh);
  sh.set("u_mouse",(0.99*mouseX)/width,(0.99*mouseY)/height);
  sh.set("u_resolution",float(width),float(height));
  sh.set("u_vecX", graph.getVecX());
  sh.set("u_vecY", graph.getVecY());
  sh.set("u_size", graph.getSize());
  float toSeconds = 2500.0; 
  sh.set("u_time",millis()/toSeconds);
  sh.set("u_paintPoint",paintPoint);
  rect(0,0,width,height);
}

void mousePressed(){
  paintPoint = true;
}

void mouseReleased(){
  paintPoint = false;
  graph.addVertx((0.99*mouseX)/width,(0.99*mouseY)/height);
}

class Graph {
  ArrayList<PVector> graph;
  
  public Graph(){
     graph = new ArrayList<PVector>();
  }
  
  public void addVertx(float x, float y){
    graph.add(new PVector(x,y));
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
