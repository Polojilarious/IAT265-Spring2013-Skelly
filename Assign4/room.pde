public class Room extends Drawable
{
  public static final int roomSize = 150;
  ArrayList<Wall> walls = new ArrayList<Wall>();
  boolean generated = false;
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  int cellx = 0;
  int celly = 0;


  Room(float inpx, float inpy, ArrayList<Integer> inpEdge)
  {
    x = inpx;
    y = inpy;
    //edge = inpEdge;
    for (int i =0; i <4;i++)
    {
      Wall n = new Wall(x, y, i, true);
      for (int tempEdge:inpEdge) {
        if (i == tempEdge) n = new Wall(x, y, i, false);
      }
      walls.add(n);
      drawList.add(n);
      colList.add(n);
    }
  }
  public void drawAll()
  {
    pushMatrix();
    noStroke();
    translate(x, y);
    fill(100, 100, 100);
    rect(-Wall.wallThickness, -Wall.wallThickness, roomSize + Wall.wallThickness*2, roomSize+ Wall.wallThickness*2);
    popMatrix();

    for (Drawable dObj: drawList)
    {
      dObj.drawAll();
    }
    for (Enemy e : enemies)
    {
      e.draw();
    }
  }

  public void update(ArrayList<CollidableObj> cObjs)
  {
    for (Enemy e : enemies)
    {
      if (p.cx == cellx && p.cy == celly)
      {
        e.targetx = p.x;
        e.targety = p.y;
        e.playerTarget = true;
        e.doorTarget = false;
        e.update();
      }
      else
      {
        e.playerTarget = false;
        e.doorTarget = true;
        int tempSml = -1;
        float smallest = 300;

        if (dist(e.x, e.y, rooms[p.cx][p.cy].x +Room.roomSize/2, rooms[p.cx][p.cy].y)< smallest)
        {
          smallest = dist(e.x, e.y, rooms[p.cx][p.cy].x +Room.roomSize/2, rooms[p.cx][p.cy].y);
          tempSml = 0;
        }
        if (dist(e.x, e.y, rooms[p.cx][p.cy].x, rooms[p.cx][p.cy].y +Room.roomSize/2)< smallest)
        {
          smallest =dist(e.x, e.y, rooms[p.cx][p.cy].x, rooms[p.cx][p.cy].y +Room.roomSize/2);
          tempSml = 1;
        }
        if (dist(e.x, e.y, rooms[p.cx][p.cy].x +Room.roomSize, rooms[p.cx][p.cy].y +Room.roomSize/2)< smallest)
        {
          smallest =dist(e.x, e.y, rooms[p.cx][p.cy].x +Room.roomSize, rooms[p.cx][p.cy].y +Room.roomSize/2);
          tempSml = 2;
        }
        if (dist(e.x, e.y, rooms[p.cx][p.cy].x +Room.roomSize/2, rooms[p.cx][p.cy].y +Room.roomSize)< smallest)
        {
          smallest =dist(e.x, e.y, rooms[p.cx][p.cy].x +Room.roomSize/2, rooms[p.cx][p.cy].y +Room.roomSize);
          tempSml = 3;
        }

        if (tempSml == 0)
        {
          e.targetx = rooms[p.cx][p.cy].x +Room.roomSize/2;
          e.targety = rooms[p.cx][p.cy].y;
        }
        else if (tempSml == 1)
        {
          e.targetx = rooms[p.cx][p.cy].x ;
          e.targety = rooms[p.cx][p.cy].y+Room.roomSize/2;
        }
        else if (tempSml == 2)
        {
          e.targetx = rooms[p.cx][p.cy].x +Room.roomSize;
          e.targety = rooms[p.cx][p.cy].y+Room.roomSize/2;
        }
        else if (tempSml == 3)
        {
          e.targetx = rooms[p.cx][p.cy].x +Room.roomSize/2;
          e.targety = rooms[p.cx][p.cy].y+Room.roomSize;
        }
        e.update();
      }
      

      if (!e.checkCol(cObjs))
      {
        e.move();
      }
      else
      {
        e.updateRect();
      }
      
      if (dist(e.x,e.y,e.targetx,e.targety)<2)
      {
        if (e.playerTarget)
        {
          println("zombified!");
          p.dead = true;
          
        }
        else if (e.doorTarget)
        {
          rooms[p.cx][p.cy].enemies.add(e);
          e.roomSwap = true;
        }
        
      }
      
    }
    
    for (int i = 0; i < enemies.size(); i++)
    {
      if (enemies.get(i).roomSwap)
      {
        enemies.get(i).roomSwap = false;
        enemies.remove(i);
      }
    }
    
  }

  void resetWalls()
  {
    for (Wall tempWall:walls) {
      tempWall.reset(x, y, tempWall.facing, tempWall.door);
    }
  }
}

