int levelSize = 10;
public Room[][] rooms = new Room[levelSize][levelSize];

public class Level extends Drawable
{
  boolean firstGenerated = true;
  boolean keyGot = false;
  Key exitKey = new Key (-10,-10);
  Exit exitDoor = new Exit (-40,-40);
  
  int roomsGenerated = 0;
  //int levelSize = 10;
  //public Room[][] rooms = new Room[levelSize][levelSize];
  static final int roomGap = Wall.wallThickness*2;
  public ArrayList<Room> activeRooms = new ArrayList<Room>();


  Level()
  {
    reset();
  }
  
  void reset()
  {
    println("levelReset");
    roomsGenerated = 0;
    keyGot = false;
    firstGenerated = true;
    exitKey = new Key (-10,-10);
    exitDoor = new Exit (-40,-40);
    for (int i = 0; i < rooms.length; i ++)
    {
      for (int j = 0; j < rooms[0].length; j ++)
      {
        //rooms[i][j] = generateRoom(i, j);
        ArrayList<Integer> tempE = new ArrayList<Integer>();
        rooms[i][j] = new Room(i* (Room.roomSize + roomGap) + 10, j* (Room.roomSize + roomGap) + 10, tempE);
        drawList.add(rooms[i][j]);
        colList.add(rooms[i][j]);
      }
    }
    drawList.add(exitKey);
  }

  void update()
  {

    int rx = floor(p.x/(Room.roomSize + roomGap));
    int ry = floor(p.y/(Room.roomSize + roomGap));

    p.cx = rx;
    p.cy = ry;
    activeRooms.clear();
    activeRooms.add(rooms[rx][ry]);
    
    if (!rooms[rx][ry].generated)rooms[rx][ry] = generateRoom(rx,ry);

    if (rx > 0 && rooms[rx][ry].walls.get(1).door)
    {
      activeRooms.add(rooms[rx-1][ry]);
      if (!rooms[rx-1][ry].generated)rooms[rx-1][ry] = generateRoom(rx-1,ry);
    }
    if (ry >0 && rooms[rx][ry].walls.get(0).door)
    {
      activeRooms.add(rooms[rx][ry-1]);
      if (!rooms[rx][ry-1].generated)rooms[rx][ry-1] = generateRoom(rx,ry-1);
    }
    if (ry <rooms[0].length-1 && rooms[rx][ry].walls.get(2).door)
    {
      if (!rooms[rx][ry+1].generated)rooms[rx][ry+1] = generateRoom(rx,ry+1);
      activeRooms.add(rooms[rx][ry+1]);
    }
    if (rx < rooms.length-1 && rooms[rx][ry].walls.get(3).door)
    {
      if (!rooms[rx+1][ry].generated)rooms[rx+1][ry] = generateRoom(rx+1,ry);
      activeRooms.add(rooms[rx+1][ry]);
    }
    
    drawList.clear();
    colList.clear();
    drawList.addAll(activeRooms);
    drawList.add(exitKey);
    drawList.add(exitDoor);
    colList.addAll(activeRooms);
    
    for(Room room: activeRooms)
    {
      room.update(this.getCol());
    }
    
  }

  public Room generateRoom(int i, int j)
  {
    ArrayList<Integer> tempE = new ArrayList<Integer>();
    tempE.add(-1);
    // left = 1    top = 0     bottom is 2    right is 3

    //edge handling
    if (i == 0)tempE.add(1);
    if (j == 0)tempE.add(0);
    if (i == rooms.length-1)tempE.add(3);
    if (j == rooms[0].length-1)tempE.add(2);
    Room tempRoom = new Room(i* (Room.roomSize + roomGap) + 10, j* (Room.roomSize + roomGap) + 10, tempE);
    if (i>0)roomHelper(i, j, 1,tempRoom);
    if (j>0)roomHelper(i, j, 0,tempRoom);
    if (j<rooms[0].length-1)roomHelper(i, j, 2,tempRoom);
    if (i< rooms.length-1)roomHelper(i, j, 3,tempRoom);
    tempRoom.resetWalls();
    if (!firstGenerated)
    {
      if (random(0,2)<1)
      {
        float eNum = random (0,2 + currentLevel);
        while (eNum > 0)
        {
          Enemy temp = new Enemy(tempRoom.x +random(7,Room.roomSize-7),tempRoom.y +random(7,Room.roomSize-7));
          tempRoom.enemies.add(temp);
          eNum -=1;
        }
      }
      if ((random(roomsGenerated,200) > 190 || roomsGenerated> 20 + currentLevel*3)&& !exitKey.init)
      {
        println("keygenned!  " + i + " " + j);
        exitKey = new Key(tempRoom.x +random(7,Room.roomSize-7),tempRoom.y +random(7,Room.roomSize-7));
        exitKey.init = true;
      } else if ((random(roomsGenerated,200) > 190 || roomsGenerated> 20 + currentLevel*3)&& !exitDoor.init)
      {
        println("exit genned!  " + i + " " + j);
        exitDoor = new Exit(tempRoom.x +(Room.roomSize-40)/2,tempRoom.y +(Room.roomSize-40)/2);
        exitDoor.init = true;
      }
    }
    tempRoom.generated = true;
    roomsGenerated ++;
    firstGenerated = false;
    tempRoom.cellx = i;
    tempRoom.celly = j;
    
    return (tempRoom);
  }

  public void roomHelper(int i, int j, int o, Room inpRoom)
  {
    if (o == 1)
    {
      if (rooms[i-1][j].generated)
      {
        inpRoom.walls.get(1).door = rooms[i-1][j].walls.get(3).door;
      }
      else if (inpRoom.walls.get(1).door)
      {
        if (random(0,3)<1 && !firstGenerated)inpRoom.walls.get(1).door = false;
      }
    }
    else if (o == 0)
    {
      if (rooms[i][j-1].generated)
      {
        inpRoom.walls.get(0).door = rooms[i][j-1].walls.get(2).door;
      }
      else if (inpRoom.walls.get(0).door)
      {
        if (random(0,3)<1 && !firstGenerated)inpRoom.walls.get(0).door = false;
      }
    }
    else if (o == 3)
    {
      if (rooms[i+1][j].generated)
      {
        inpRoom.walls.get(3).door = rooms[i+1][j].walls.get(1).door;
      }
      else if (inpRoom.walls.get(3).door)
      {
        if (random(0,3)<1 && !firstGenerated)inpRoom.walls.get(3).door = false;
      }
    }
    else if (o == 2)
    {
      if (rooms[i][j+1].generated)
      {
        inpRoom.walls.get(2).door = rooms[i][j+1].walls.get(0).door;
      }
      else if (inpRoom.walls.get(2).door)
      {
        if (random(0,3)<1 && !firstGenerated)inpRoom.walls.get(2).door = false;
      }
    }
    
  }
  
  void levelComplete()
  {
    currentLevel ++;
    fadein = 255;
    reset();
    
  }
}

