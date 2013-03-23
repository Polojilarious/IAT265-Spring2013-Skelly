public class Wall extends Drawable
{
  public static final int wallThickness = 7;
  int facing = 0;
  ArrayList<CollidableObj> cObjList = new ArrayList<CollidableObj>();
  boolean door = true;

  Wall(float inpx, float inpy, int i,boolean inpd)
  {
    reset(inpx,inpy,i,inpd);
  }
  
  void reset(float inpx, float inpy, int i,boolean inpd)
  {
    door = inpd;
    x = inpx;
    y = inpy;
    facing = i;
    cObjList.clear();
    if (door)
    {
      CollidableObj temp1;
      CollidableObj temp2;
      temp1 = new CollidableObj(0, 0, 0, 0, 0);
      temp2 = new CollidableObj(0, 0, 0, 0, 0);
      switch (facing)
      {
      case 0: 
        temp1 = new CollidableObj(x-Wall.wallThickness, y-Wall.wallThickness, Room.roomSize/3+ Wall.wallThickness*2, wallThickness, facing);
        temp2 = new CollidableObj(x-Wall.wallThickness + Room.roomSize/3 *2, y-Wall.wallThickness, Room.roomSize/3+ Wall.wallThickness*2, wallThickness, facing);
        break;
      case 1: 
        temp1 = new CollidableObj(x-Wall.wallThickness, y-Wall.wallThickness, wallThickness, Room.roomSize/3+ Wall.wallThickness*2, facing);
        temp2 = new CollidableObj(x-Wall.wallThickness, y-Wall.wallThickness + Room.roomSize/3 *2, wallThickness, Room.roomSize/3+ Wall.wallThickness*2, facing);
        break;
      case 2: 
        temp1 = new CollidableObj(x-Wall.wallThickness, y+Room.roomSize, Room.roomSize/3+ Wall.wallThickness*2, wallThickness, facing);
        temp2 = new CollidableObj(x-Wall.wallThickness + Room.roomSize/3 *2, y+Room.roomSize, Room.roomSize/3+ Wall.wallThickness*2, wallThickness, facing);
        break;
      case 3: 
        temp1 = new CollidableObj(x+Room.roomSize , y-Wall.wallThickness, wallThickness, Room.roomSize/3+ Wall.wallThickness*2, facing);
        temp2 = new CollidableObj(x+Room.roomSize , y-Wall.wallThickness + Room.roomSize/3 *2, wallThickness, Room.roomSize/3+ Wall.wallThickness*2, facing);
        break;
      default: 

        break;
      }
      cObjList.add(temp1);
      cObjList.add(temp2);
    }
    else
    {
      CollidableObj temp1;
      temp1 = new CollidableObj(0, 0, 0, 0, 0);
      switch (facing)
      {
      case 0: 
        temp1 = new CollidableObj(x-Wall.wallThickness, y-Wall.wallThickness, Room.roomSize+ Wall.wallThickness*2, wallThickness, facing);
        break;
      case 1: 
        temp1 = new CollidableObj(x-Wall.wallThickness, y-Wall.wallThickness, wallThickness, Room.roomSize+ Wall.wallThickness*2, facing);
        break;
      case 2: 
        temp1 = new CollidableObj(x-Wall.wallThickness, y+Room.roomSize, Room.roomSize+ Wall.wallThickness*2, wallThickness, facing);
        break;
      case 3: 
        temp1 = new CollidableObj(x+Room.roomSize , y-Wall.wallThickness, wallThickness, Room.roomSize+ Wall.wallThickness*2, facing);
        break;
      default: 

        break;
      }
      cObjList.add(temp1);
    }
  }



  public void drawAll()
  {
    pushMatrix();
    translate(x, y);
    switch (facing)
    {
    case 0: //rotate(PI/2); 
      break;
    case 1: 
      translate(-Wall.wallThickness, 0);
      rotate(PI/2); 
      break;
    case 2: //rotate(PI); 
      translate(0, Room.roomSize + Wall.wallThickness);
      break;
    case 3: 
      translate(Room.roomSize, 0);
      rotate(PI/2); 
      break;
    default: 
      break;
    }

    fill(255, 100);
    noStroke();
    //rect(0,0,Room.roomSize,Room.roomSize);



    //rect(-Wall.wallThickness,-Wall.wallThickness,Room.roomSize+ Wall.wallThickness*2,wallThickness);
    if (door)
    {
      rect(-Wall.wallThickness, -Wall.wallThickness, Room.roomSize/3+ Wall.wallThickness*2, wallThickness);
      rect(-Wall.wallThickness + Room.roomSize/3 *2, -Wall.wallThickness, Room.roomSize/3+ Wall.wallThickness*2, wallThickness);
    }
    else
    {
      rect(-Wall.wallThickness,-Wall.wallThickness,Room.roomSize+ Wall.wallThickness*2,wallThickness);
    }
    //rect(-Wall.wallThickness, Room.roomSize,Room.roomSize + Wall.wallThickness*2,wallThickness);

    //rect(-Wall.wallThickness,-Wall.wallThickness,Wall.wallThickness,Room.roomSize + Wall.wallThickness*2);
    //rect(Room.roomSize,-Wall.wallThickness, wallThickness,Room.roomSize + Wall.wallThickness*2);

    popMatrix();
    //println("drawn");
  }
  public ArrayList<CollidableObj> getCol()
  {
    return (cObjList);
  }
}

