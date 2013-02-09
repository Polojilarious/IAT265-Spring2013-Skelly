boolean toggle = false;
boolean catflip = false;
float catx,caty,catdx,catdy = 0;

void setup()
{
  size(600,400);
  catx = 200;
  caty = 250;
  catdx = -2;
  catdy = .6;
}
void draw()
{
  background(200);
  
  fill(145,200,255);
  rect(0,0,width,100);
  
  
  if(frameCount%105 == 0) toggle = !toggle;
  if(frameCount%20 == 0) toggle = !toggle;
  
  //catx = mouseX;
  //caty = mouseY;
  
  
  
  float scaleFactor = map(caty,100,400,.5,1); 
  

  
  catx+= catdx*scaleFactor;
  caty+= catdy*scaleFactor;
  
  if (catx - 90*scaleFactor < 0)catdx = -catdx;
  if (catx + 90*scaleFactor > width)catdx = -catdx;
  //if (caty - 90*scaleFactor < 100)catdy = -catdy;
  if (caty < 100)catdy = -catdy;
  if (caty + 100*scaleFactor > height - 20)catdy = -catdy;
  
  if (catdx > 0)catflip = true;
  else catflip = false;
  drawCat(catx, caty, 0,scaleFactor,toggle,catflip);
}

void drawCat(float inpx, float inpy, float inpRot, float inpScale,boolean state,boolean flip)
{
  pushMatrix();
 translate(inpx,inpy);
  rotate(inpRot);
  if (flip)scale(-1,1);
  scale(inpScale);
  
  //bounding box
  //fill(255);
  //stroke(1);
  //rect(-100,-100,200,200);
  //line(100,0,-100,0);
  //line(0,100,0,-100);
  
  //animation values
  //1 and 2 are for legs and tail
  float temprot = sin((float)frameCount/8);
  float temprot2 = cos((float)frameCount/8);
  //3 and 4 are twice as fast, for head and ears.
  float temprot3 = cos((float)frameCount/4);
  float temprot4 = sin((float)frameCount/4);
  
  //shadow
  fill(50,70);
  pushMatrix();
  translate(3,104);
  ellipse(0,0,150 - temprot3*3/2,25 - temprot3/4);
  scale(.7);
  ellipse(0,0,150 - temprot3*3/2,25 - temprot3/4);
  scale(.7);
  ellipse(0,0,150 - temprot3*3/2,25 - temprot3/4);
  
  popMatrix();
  
  translate(0,temprot3*3);
  
  noStroke();
 
    //rear hind leg
  fill(200,100,0); // dark orange
  pushMatrix();
  translate(-25,-10);
  shearX(temprot/7);
  scale(1,1+ temprot2/15);
  quad(40,25, 75,30, 55,75, 35,60);
  quad(50,50, 55,100,60,100, 70,60);
  popMatrix();
  
  
  
  //front legs
  pushMatrix();
  translate(0,20);
  
  //back leg
  fill(200,100,0);// dark orange
  pushMatrix();
  translate(-temprot*5 + 3,temprot2/2);
  shearX(-temprot/7);
  scale(1,1- temprot2/15);
  quad(-35,10,-50,72,-45,72,-20,10);
  popMatrix();
  
  
  //front legs
  translate(15,10);
  fill(255,125,0); //orange
  pushMatrix();
  translate(temprot*5 - 3,temprot2/2);
  shearX(temprot/7);
  scale(1,1+ temprot2/15);
  quad(-35,10,-40,70,-35,70,-20,10);
  popMatrix();
  
  popMatrix();
  
  //chest
  quad(-40,0,-30,45,10,40,10,10);

  //hips
  quad(9,40,9,10,40,5,40,45);
  
  //front hind leg
  pushMatrix();
  shearX(-temprot/7);
  scale(1,1- temprot2/15);
  quad(40,5, 65,20, 55,75, 25,55);
  quad(50,50, 55,100,60,100, 70,60);
  popMatrix();
  
  //tail

  pushMatrix();
  translate(40,5);
  
  rotate( -temprot/2  + PI/8);
  curve(-70,15,0,0,20,-25,25,-75);
  translate(20,-25);
  rotate(temprot2/(1.5) + PI/8);
  curve(-20,30,0,0,-15,-25, -60,-20);
  translate(-15,-25);
  rotate(temprot2/(1.3) - PI/4);
  curve(15,20,0,0, 10,-30, 75, -90);
  popMatrix();
  
   //head
   pushMatrix();
   translate(0,temprot4*1);
  ellipse(-40,0,70,70);
  
  //ears
  triangle(-45 - temprot3,-50- temprot3 * 2, -40,-35 , -70,-18);
  triangle(5 - temprot3,-40- temprot3 * 2, -7,-5, -35,-30);
  
  //eyes
  if(toggle){
  fill(255);
  ellipse(-70,0,7,20);
  ellipse(-47,5,17,24); 
  }
  else
  {
    stroke(255);
    noFill();
    
    arc(-70,0,7,20,.4,PI);
    arc(-47,5,17,24,.3,PI); 
    
    noStroke();
  }
  popMatrix();
  popMatrix();
}
