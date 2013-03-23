public class Drawable{
  ArrayList<Drawable> drawList = new ArrayList<Drawable>();
  float x,y = 0;
  ArrayList<Drawable> colList = new ArrayList<Drawable>();
  
  public void drawAll()
  {
    for(Drawable dObj: drawList)
    {
      dObj.drawAll();
    }
  }
  
   public ArrayList<CollidableObj> getCol()
  {
    ArrayList<CollidableObj> tempList = new ArrayList<CollidableObj>();
    for (Drawable cObj: colList)
    {
      tempList.addAll(cObj.getCol());
    }
    return (tempList);
  }
}
