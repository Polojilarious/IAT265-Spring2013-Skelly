import java.awt.Rectangle;

public class Actor {

  float x, y, r = 5;
  Rectangle bound;
  boolean vertfail = false;
  boolean horzfail = false;

  float tempx, tempy = 0;

  Actor()
  {
    bound = new Rectangle();
    updateRect();
  }


  void draw()
  {
    pushMatrix();
    fill(255, 0, 0);
    noStroke();
    translate(x, y);

    rect(0, 0, 2*r, 2*r);

    popMatrix();
  }

  void update() {
  }
  void move()
  {
    //this.x = this.bound.x;
    //this.y = this.bound.y;
    x = tempx;
    y = tempy;
  }


  boolean checkCol(ArrayList<CollidableObj> cObjs)
  {
    horzfail = false;
    vertfail = false;
    for (CollidableObj cObj:cObjs)
    {
      //if (this.bound.intersects(cObj.bound))
      if (cObj.bound.contains(this.tempx, this.tempy + r))
      {
        //return true;
        tempx = x;
        
        horzfail = true;
      }
      if (cObj.bound.contains(this.tempx + r*2, this.tempy +r))
      {
        //return true;
        tempx = x;
        horzfail = true;
      }
      if (cObj.bound.contains(this.tempx+r, this.tempy +r*2))
      {
        //return true;
        tempy = y;
        vertfail = true;
      }
      if (cObj.bound.contains(this.tempx + r, this.tempy))
      {
        //return true;
        tempy = y;
        vertfail = true;
      }
    }
    return false;
  }


  void updateRect()
  {
    tempx = x;
    tempy = y;
    //bound.x = (int)x;
    //bound.y = (int)y;
    //bound.width = (int)r*2;
    //bound.height = (int)r*2;
  }
}

