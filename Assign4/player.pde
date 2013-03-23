

public class Player extends Actor{
  boolean up,down,left,right = false;
  int cx = 0;
  int cy = 0;
  boolean dead = false;
  
  void draw()
  {
    pushMatrix();
    
    noStroke();
    translate(x,y);
    fill(255,0,0,100);
    //rect(0,0,2*r,2*r);
    fill(255,0,0);
    ellipse(r,r,2*r,2*r);
    popMatrix();

  }
}
