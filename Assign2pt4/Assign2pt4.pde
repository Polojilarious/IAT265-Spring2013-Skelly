int maxCats = 8;
Cat[] cats = new Cat[maxCats];

void setup()
{
  size(600, 400);
  for (int i = 0; i< cats.length; i++)
  {
    cats[i] = new Cat();
  }
  colorMode(HSB, 255);
}
void draw()
{
  background(200);

  fill(145, 200, 255);
  rect(0, 0, width, 100);

  //update the cats
  for (int i = 0; i< cats.length; i++)
  {
    cats[i].update();
  }

  //check colission between the cats
  for (int i = 0; i< cats.length; i++)
  {
    for (int j = i+1; j< cats.length; j++)
    {

      float radius = dist(cats[i].x, cats[i].y, cats[j].x, cats[j].y); 
      if (radius < 50)
      {

        //horizontal
        if (cats[i].dx > 0 && cats[j].dx > 0) 
        {
          if (cats[i].dx > cats[j].dx) cats[i].dx = -cats[i].dx;
          else cats[j].dx = -cats[j].dx;
        }
        else if (cats[i].dx < 0 && cats[j].dx < 0) 
        {
          if (cats[i].dx < cats[j].dx) cats[i].dx = -cats[i].dx;
          else cats[j].dx = -cats[j].dx;
        }
        else
        {
          cats[i].dx = -cats[i].dx;
          cats[j].dx = -cats[j].dx;
        }

        //vertical
        if (cats[i].dy > 0 && cats[j].dy > 0) 
        {
          if (cats[i].dy > cats[j].dy) cats[i].dy = -cats[i].dy;
          else cats[j].dy = -cats[j].dy;
        }
        else if (cats[i].dy < 0 && cats[j].dy < 0) 
        {
          if (cats[i].dy < cats[j].dy) cats[i].dy = -cats[i].dy;
          else cats[j].dy = -cats[j].dy;
        }
        else
        {
          cats[i].dy = -cats[i].dy;
          cats[j].dy = -cats[j].dy;
        }

        //shifting cats to avoid getting stuck
        {
          if (cats[i].y >= cats[j].y)
          {
            cats[i].y += 1;
            cats[j].y -= 1;
          }
          else if (cats[i].y < cats[j].y)
          {
            cats[i].y -= 1;
            cats[j].y += 1;
          }
          if (cats[i].x >= cats[j].x)
          {
            cats[i].x += 1;
            cats[j].x -= 1;
          }
          else if (cats[i].x < cats[j].x)
          {
            cats[i].x -= 1;
            cats[j].x += 1;
          }
        }
      }
    }
  }

  //sort cats, painters algorithm, etc
  Arrays.sort(cats);
  
  //draw cats
  for (int i = 0; i< cats.length; i++)
  {
    cats[i].draw();
  }
}



class Cat implements Comparable
{
  boolean toggle = false;
  boolean catflip = false;
  float x, y, dx, dy = 0;
  int colorVal;
  int animOffset = 0;
  int animCount = 0;
  float scaleFactor = 0;

  //constructor
  Cat()
  {
    animOffset = (int)random(-50, 250);
    x = width/2 + random(-300,300);
    y = 250 + random(-100, 50);
    dx = random(-2, 2);
    dy= random(-.6, .6);
    int val = (int)random(0, 255);
    colorVal = val;
    //println("cat created");
  }

  // motion and boundary collision
  void update()
  {
    //eye blinking counter
    animCount = frameCount +animOffset;
    if (animCount%105 == 0) toggle = !toggle;
    if (animCount%20 == 0) toggle = !toggle;

    //setting scale based on position
    scaleFactor = map(this.y, 100, 400, .5, 1); 


    // updating position based on velocity and scale
    this.x+= dx*scaleFactor;
    this.y+= dy*scaleFactor;

    //boundary collision
    if (this.x - 90*scaleFactor < 0)
    {
      x +=1;
      dx = -dx;
    }
    if (this.x + 90*scaleFactor > width)
    {
      dx = -dx;
      x -=1;
    }
    if (this.y < 100)
    {
      dy = -dy;
      y+=1;
    }
    if (this.y + 100*scaleFactor > height - 20)
    {
      y-=1;
      dy = -dy;
    }

    //determine if cat is facing left or right
    if (dx > 0)catflip = true;
    else catflip = false;
  }

  //draw is just to make drawing easier from the outside, while retaining functionality.
  void draw()
  {

    drawCat(this.x, this.y, 0, scaleFactor, toggle, catflip);
  }

  //full draw method
  void drawCat(float inpx, float inpy, float inpRot, float inpScale, boolean state, boolean flip)
  {

    pushMatrix();
    translate(inpx, inpy);
    rotate(inpRot);
    if (flip)scale(-1, 1);
    scale(inpScale);

    //animation values
    //1 and 2 are for legs and tail
    float temprot = sin((float)animCount/8);
    float temprot2 = cos((float)animCount/8);
    //3 and 4 are twice as fast, for head and ears.
    float temprot3 = cos((float)animCount/4);
    float temprot4 = sin((float)animCount/4);

    //shadow
    fill(50, 70);
    pushMatrix();
    translate(3, 104);
    ellipse(0, 0, 150 - temprot3*3/2, 25 - temprot3/4);
    scale(.7);
    ellipse(0, 0, 150 - temprot3*3/2, 25 - temprot3/4);
    scale(.7);
    ellipse(0, 0, 150 - temprot3*3/2, 25 - temprot3/4);

    popMatrix();

    translate(0, temprot3*3);

    noStroke();

    //rear hind leg
    fill(colorVal, 200, 130); // dark color
    pushMatrix();
    translate(-25, -10);
    shearX(temprot/7);
    scale(1, 1+ temprot2/15);
    quad(40, 25, 75, 30, 55, 75, 35, 60);
    quad(50, 50, 55, 100, 60, 100, 70, 60);
    popMatrix();



    //front legs
    pushMatrix();
    translate(0, 20);

    //back leg
    fill(colorVal, 200, 130);// dark color
    pushMatrix();
    translate(-temprot*5 + 3, temprot2/2);
    shearX(-temprot/7);
    scale(1, 1- temprot2/15);
    quad(-35, 10, -50, 72, -45, 72, -20, 10);
    popMatrix();


    //front legs
    translate(15, 10);
    fill(colorVal, 200, 200); //light color
    pushMatrix();
    translate(temprot*5 - 3, temprot2/2);
    shearX(temprot/7);
    scale(1, 1+ temprot2/15);
    quad(-35, 10, -40, 70, -35, 70, -20, 10);
    popMatrix();

    popMatrix();

    //chest
    quad(-40, 0, -30, 45, 10, 40, 10, 10);

    //hips
    quad(9, 40, 9, 10, 40, 5, 40, 45);

    //front hind leg
    pushMatrix();
    shearX(-temprot/7);
    scale(1, 1- temprot2/15);
    quad(40, 5, 65, 20, 55, 75, 25, 55);
    quad(50, 50, 55, 100, 60, 100, 70, 60);
    popMatrix();

    //tail

    pushMatrix();
    translate(40, 5);

    rotate( -temprot/2  + PI/8);
    curve(-70, 15, 0, 0, 20, -25, 25, -75);
    translate(20, -25);
    rotate(temprot2/(1.5) + PI/8);
    curve(-20, 30, 0, 0, -15, -25, -60, -20);
    translate(-15, -25);
    rotate(temprot2/(1.3) - PI/4);
    curve(15, 20, 0, 0, 10, -30, 75, -90);
    popMatrix();

    //head
    pushMatrix();
    translate(0, temprot4*1);
    ellipse(-40, 0, 70, 70);

    //ears
    triangle(-45 - temprot3, -50- temprot3 * 2, -40, -35, -70, -18);
    triangle(5 - temprot3, -40- temprot3 * 2, -7, -5, -35, -30);

    //eyes
    if (toggle) {
      fill(255);
      ellipse(-70, 0, 7, 20);
      ellipse(-47, 5, 17, 24);
    }
    else
    {
      stroke(255);
      noFill();

      arc(-70, 0, 7, 20, .4, PI);
      arc(-47, 5, 17, 24, .3, PI); 

      noStroke();
    }
    popMatrix();
    popMatrix();
  }

  //sorting by y position
  int compareTo(Object o)
  {
    Cat other=(Cat)o;
    if (other.y>y)  
      return -1;
    if (other.y==y)
      return 0;
    else
      return 1;
  }
}

