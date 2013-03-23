public class Exit extends Drawable
{
  int exitSize = 40;
  ArrayList<CollidableObj> cObjList = new ArrayList<CollidableObj>();
  boolean init = false;
  
  Exit(float inpx, float inpy)
  {
    x = inpx;
    y = inpy;
    CollidableObj bounds = new CollidableObj(inpx,inpy,exitSize,exitSize,1);
    cObjList.add(bounds);
  }
  
  public void drawAll()
  {
    pushMatrix();
    noStroke();
    translate(x,y);
    fill(0,0,0,100);
    if (init)rect(0,0,exitSize,exitSize);
    popMatrix();
  }
  public ArrayList<CollidableObj> getCol()
  {
    return (cObjList);
  }
}
