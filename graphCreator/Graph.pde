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
  
  public void removeAll(){
    graph.clear();
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
