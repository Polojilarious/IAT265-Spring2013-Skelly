public class Enemy extends Actor
{
  float targetx = 0;
  float targety = 0;
  float spdMod = .5;
  boolean playerTarget = false;
  boolean roomSwap = false;
  boolean doorTarget = false;
  float targetAngle;
  
  Enemy(float inpx, float inpy)
  {
    x = inpx;
    y = inpy;
    spdMod = random(.5,1.5);
    updateRect();
    targetx = x;
    targety = y;
  }
  
  void draw()
  {
    pushMatrix();
    noStroke();
    translate(x+r,y+r);
    rotate(-targetAngle);
    translate(-r,-r);
    fill(0,75 + 50*spdMod,0);
    ellipse(r,r,8,8);
    rect(0,3,2,10);
    rect(8,3,2,10);
    popMatrix();

  }
  
  void update(){
    if (doorTarget)
    {
      targetx -= r;
      targety -= r;
    }
    
    targetAngle = atan2(targetx-x,targety-y);
    this.tempx += sin(targetAngle)*spdMod;
    this.tempy += cos(targetAngle)*spdMod;
    //if (sin(targetAngle)*spdMod >0) this.bound.x += ceil(sin(targetAngle)*spdMod);
    //else this.bound.x += floor(sin(targetAngle)*spdMod);
    //if (cos(targetAngle)*spdMod >0) this.bound.y += ceil(cos(targetAngle)*spdMod);
    //else this.bound.y += floor(cos(targetAngle)*spdMod);
  }
  
}
