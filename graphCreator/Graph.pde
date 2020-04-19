class Graph {
  private ArrayList<PVector> graph;
  private final int maxVertex = 128;
  
  public Graph(){
     graph = new ArrayList<PVector>();
  }
  
  public void addVertex(float x, float y){
    if(graph.size() < maxVertex){
      graph.add(new PVector(x,y));
    }
  }
  
  public void deleteVertex(){
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
