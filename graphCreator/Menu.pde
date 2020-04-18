interface Menu{
  void paintMenu();
  void allowToPaint();
  void prohibitPainting();
  boolean hasToBePainted();
}

class StarMenu implements Menu{
  private boolean shoulBePaint = true;
  private String textStart,textKey;
  private boolean controllers;
  
  public StarMenu(){
    textStart = "> Start";
    textKey = " Controls";
    controllers = false;
  }
  
  @Override
  void paintMenu(){
    fill(0, 102, 153);
    textSize(65);
    textAlign(CENTER,CENTER);
    text("Graph Creator",width/2,height * 0.10);
    textSize(18);
    text("press enter, move with the arrow keys",width * 0.50,height * 0.80);
    textSize(30);
    text(textStart,width * 0.30,height * 0.90);
    text(textKey,width * 0.70,height * 0.90);
    crateFigure();
  }
  
  private void crateFigure(){
    fill(255, 255, 255);
    int dim = 20;
    
    ellipse(width * 0.5,  height * 0.5,dim,dim);
    ellipse(width * 0.35, height * 0.45,dim,dim);
    ellipse(width * 0.6,  height * 0.65,dim,dim);
    ellipse(width * 0.75, height * 0.45,dim,dim);
    
    stroke(255,255,255);
    strokeWeight(5);
    line(width * 0.5,  height * 0.5,  width * 0.35, height * 0.45);
    line(width * 0.35, height * 0.45, width * 0.35, height * 0.45);
    line(width * 0.5,  height * 0.5,  width * 0.6,  height * 0.65);
    line(width * 0.75, height * 0.45, width * 0.5,  height * 0.5);
    noStroke();
    strokeWeight(1);
  }
  
  @Override
  void allowToPaint(){
    shoulBePaint = true;
  }
  
  @Override
  void prohibitPainting(){
    shoulBePaint = false;
  }
  
  @Override
  boolean hasToBePainted(){
    return shoulBePaint;
  }
  
  boolean nextMenuKey(){
    return controllers;
  }
  
  public void chooseKey(){
    textStart = " Start";
    textKey   = "> Controls";
    controllers = true;
  }
  
  public void chooseStart(){
    textStart = "> Start";
    textKey   = " Controls";
    controllers = false;
  }
  
}

class KeyMenu implements Menu{
  private boolean shoulBePaint = true;
    
  @Override
  void paintMenu(){
    stroke(255);
    textAlign(CENTER,CENTER);
    textSize(20);
    int dim = 30;
    paintKey(width * 0.20,height * 0.10, 'F',dim);
    text("to return or delete figures",(width+dim)/2,(height+dim) * 0.10);
    
    paintKey(width * 0.20,height * 0.20, 'D',dim);
    text("delete nodes",(width+dim)/2,(height+dim) * 0.20);
    
    paintKey(width * 0.20,height * 0.30, 'V',dim);
    text("change graph speed",(width+dim)/2,(height+dim) * 0.30);
    
    paintKey(width * 0.20,height * 0.40, 'S',dim);
    text("stop graph",(width+dim)/2,(height+dim) * 0.40);
    
    paintKey(width * 0.20,height * 0.50, 'R',dim);
    text("remove all points",(width+dim)/2,(height+dim) * 0.50);
    
    text("Use the mouse and do click for make points",width * 0.50,height * 0.70);
    
    
    
    
    
  }
  
  private void paintKey(float x, float y,char letter, int dim){
    fill(0);
    rect(x,y,dim,dim);
    fill(255);
    text(letter, x+dim/2, y+dim/2);
    noFill();
  }
  
  @Override
  void allowToPaint(){
    shoulBePaint = true;
  }
  
  @Override
  void prohibitPainting(){
    shoulBePaint = false;
  }
  
  @Override
  boolean hasToBePainted(){
    return shoulBePaint;
  }
}
