public class Key extends Drawable
{
  int keysize = 8;
  ArrayList<CollidableObj> cObjList = new ArrayList<CollidableObj>();
  boolean nabbed = false;
  boolean init = false;
  
  Key(float inpx, float inpy)
  {
    x = inpx;
    y = inpy;
    CollidableObj bounds = new CollidableObj(inpx,inpy,keysize,keysize,1);
    cObjList.add(bounds);
  }
  
  public void drawAll()
  {
    pushMatrix();
    noStroke();
    translate(x,y);
    fill(255,255,0);
    if (!nabbed && init)
    {
      
      //ellipse(keysize/2,keysize/2,keysize,keysize);
      rect(0,0,keysize,keysize/2);
      rect(3,0,2,9);
    }
    popMatrix();
  }
  public ArrayList<CollidableObj> getCol()
  {
    return (cObjList);
  }
}

