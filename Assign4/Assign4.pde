ArrayList<Level> storedLevels = new ArrayList<Level>();
int currentLevel = 0;
int cx = 0;
int cy = 0;
Player p = new Player();
int fadein = 0;

int mode = 0;


PFont font;



void setup()
{
  size(800, 600);
  Level temp = new Level();
  storedLevels.add(temp);
  font = loadFont("UniversLT-Condensed-24.vlw");

  Level currentL = storedLevels.get(currentLevel);
  currentL.drawAll();
  p.x = 400;
  p.y = 300;
  p.updateRect();
  background(0);
  gameDraw();
  fill(0,100);
  rect(0,0,width,height);
}

void draw()
{
  if (p.dead && mode != 0)
  {
    fill(0,100);
    rect(0,0,width,height);
  }
  if (p.dead) mode = 0;
  if (mode == 0)menuDraw();
  if (mode ==1)gameDraw();
  
}

void menuDraw()
{
  smooth();
  textFont(font, 24);
  fill(255);
  text("Zombified!", width/2-40, height/2-40);
  if (p.dead)text("You Died!", width/2-35, height/2-90);
  textFont(font, 12);
  text("Press Space to Play!", width/2-40, height/2 + 40);
  text("Grab the key and get to the exit!", width/2-66, height/2-20);
  text("use W,A,S,D to move!", width/2-40, height/2);
  if (p.dead)text("You survived " + currentLevel + " levels!", width/2-40, height/2-70);
  //noSmooth();
}

void gameDraw()
{
  background (0);
  keyUpdate();
  Level currentL = storedLevels.get(0);
  currentL.update();
  p.update();

  ArrayList<CollidableObj> cObjList = new ArrayList<CollidableObj>();
  cObjList = currentL.getCol();

  if (!p.checkCol(cObjList))
  {
    p.move();
  }
  else
  {
    p.updateRect();
    if (p.left)cx -= 2;
    if (p.right)cx += 2;
    if (p.up)cy -= 2;
    if (p.down)cy += 2;
  }
  if (p.left && p.horzfail)cx -= 2;
  if (p.right&& p.horzfail)cx += 2;
  if (p.up&& p.vertfail)cy -= 2;
  if (p.down&& p.vertfail)cy += 2;


  if (dist(p.x+p.r,p.y+p.r,currentL.exitKey.x + 4, currentL.exitKey.y + 4) < 10 && ! currentL.keyGot)
  {
    println("key grabbed");
    currentL.keyGot = true;
    currentL.exitKey.nabbed = true;
  }
  if (dist(p.x+p.r,p.y+p.r,currentL.exitDoor.x + 20, currentL.exitDoor.y + 20) < 20 && currentL.keyGot)
  {
    println("Level up!");
    currentL.levelComplete();
  }

  pushMatrix();
  translate(cx, cy);
  currentL.drawAll();
  p.draw();
  popMatrix();
  
  if (fadein > 0)
  {
  fill(0,fadein);
  rect(0,0,width,height);
  fadein -=3;
  }
}



void keyUpdate()
{
  if (p.left) {
    cx += 2;
    //p.bound.x-=2;
    p.tempx -=2;
  }
  if (p.right) {
    cx -= 2;
    //p.bound.x+=2;
    p.tempx +=2;
  }
  if (p.up) {
    cy += 2;
    //p.bound.y-=2;
    p.tempy -=2;
  }
  if (p.down) {
    cy -= 2;
    //p.bound.y+=2;
    p.tempy += 2;
  }
}

void keyPressed()
{
  if (key == 'A' || key == 'a') {
    p.left = true;
  }
  if (key == 'D' || key == 'd') {
    p.right = true;
  }
  if (key == 'W' || key == 'w') {
    p.up = true;
  }
  if (key == 'S' || key == 's') {
    p.down = true;
  }
  if (key == ' ' ) 
  {
    
    
    if (p.dead && mode == 0)
    {
      println("reset");
      p.x = 400;
      p.y = 300;
      p.updateRect();
      p.dead = false;
      cx = 0;
      cy = 0;
      currentLevel = 0;
      Level currentL = storedLevels.get(0);
      currentL.reset();
    }
    mode = 1;
  }
}
void keyReleased()
{
  if (key == 'A' || key == 'a') {
    p.left = false;
  }
  if (key == 'D' || key == 'd') {
    p.right = false;
  }
  if (key == 'W' || key == 'w') {
    p.up = false;
  }
  if (key == 'S' || key == 's') {
    p.down = false;
  }
}


