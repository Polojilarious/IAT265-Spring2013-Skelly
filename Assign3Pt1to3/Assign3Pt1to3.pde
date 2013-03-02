int gridW = 40;
int gridH = 40;

PImage screenshot;

gridShape[] boxes;

void setup()
{
  size(800,800);
  screenshot = createImage(width,height,RGB);
  
  boxes = new gridShape[gridW*gridH];
  
  for (int i = 0; i < boxes.length; i ++)
  {
    int column = i% gridW;
    int row = (i - column)/40;
    println(column + " " + row);
    if ((i+ row)%3 == 0)boxes[i] = new gridShape(map(column,0,gridW,0,width),map(row,0,gridH,0,width));
    else if ((i+ row)%3 == 1)boxes[i] = new altShape(map(column,0,gridW,0,width),map(row,0,gridH,0,width));
    else boxes[i] = new fancyShape(map(column,0,gridW,0,width),map(row,0,gridH,0,width));
  }
  
}

void draw()
{
  background(0);
  colorMode(HSB,255);
  noFill();
  
  for (int i = 0; i < boxes.length; i ++)
  {
    boxes[i].update();
  }
  Arrays.sort(boxes);
  for (int i = 0; i < boxes.length; i ++)
  {
    boxes[i].render();
  }
}

void keyTyped() {
  if (key == 's' || key == 'S')
  {
    loadPixels();
    screenshot.loadPixels();
    screenshot.pixels = pixels;
    screenshot.save("screenshot " + frameCount + ".png" );
  }
}



class gridShape implements Comparable
{
  float x,y = 0;
  float rot = 0;
  float shapeScale = 1;
  int col = 0;
  float mouseDist = 0;
  int shapeAlpha = 120;
  
  gridShape(float x, float y)
  {
    this.x = x;
    this.y = y;
    
  }
  
  void render()
  {
    pushMatrix();
    translate(x,y);
    rotate(rot);
    //scale(shapeScale);
    stroke(col,255,255,shapeAlpha);
    fill(0);
    rect(-10,-10,20,20);
    rotate(PI/4);
    rect(-5,-5,10,10);
    /*if (mouseDist < 200)
    {
    noStroke();
    fill(col,255,255,shapeAlpha/4);
    rect(-width,0,2*width,1);
    rect(0,-height,1,2*height);
    noFill();
    }
    */
    popMatrix();
  }
  
  void update()
  {
    mouseDist = dist(x,y,mouseX,mouseY);
    shapeScale = map(mouseDist,0,400,2,.1);
    rot = map(mouseDist,0,400,0,PI);
    float temp = atan2(x-mouseX,y-mouseY);
    while (temp < 0)temp+= PI;
    temp += map(mouseX,0,width,0,PI);
    col = (int)map(temp,0,2*PI,0,255 );
  }
  
  
  int compareTo(Object o)
  {
    gridShape other=(gridShape)o;
    if(other.mouseDist>mouseDist)  
      return 1;
    if(other.mouseDist==mouseDist)
      return 0;
    else
      return -1;
  }
}

class altShape extends gridShape
{
  altShape(float x, float y)
  {
    super(x,y);
    this.x = x;
    this.y = y;
    
  }
  void render()
  {
    pushMatrix();
    translate(x,y);
    rotate(rot);
    scale(shapeScale);
    stroke(col,255,255,shapeAlpha);
    fill(0);
    ellipse(-10,-5,20,10);
    //rotate(PI/4);
    ellipse(-5,-10,10,20);
    if (mouseDist < 200)
    {
    //noStroke();
    //fill(col,255,255,shapeAlpha/4);
    //rect(-width,0,2*width,1);
    //rect(0,-height,1,2*height);
    //noFill();
    }
    popMatrix();
    
  }
  
}

class fancyShape extends gridShape
{
  fancyShape(float x, float y)
  {
    super(x,y);
    this.x = x;
    this.y = y;
    
  }
  void render()
  {
    pushMatrix();
    translate(x,y);
    rotate(rot);
    scale(shapeScale);
    stroke(col,255,255,shapeAlpha);
    fill(0);
    rect(-10,-10,20,20);
    rotate(PI/4);
    rect(-5,-5,10,10);
    if (mouseDist < 200)
    {
    noStroke();
    fill(col,255,255,shapeAlpha/4);
    rect(-width,0,2*width,1);
    rect(0,-height,1,2*height);
    noFill();
    }
    popMatrix();
    
  }
  
}
