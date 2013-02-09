boolean toggle = false;
void setup()
{
  size(400,400);
}
void draw()
{
  background(200);
  if(frameCount%105 == 0) toggle = !toggle;
  if(frameCount%20 == 0) toggle = !toggle;
  fill(0,100);
  ellipse(205,345,160,30);
  drawCat(200, 250, 0,1,toggle);
}

void drawCat(int inpx, int inpy, float inpRot, float inpScale,boolean state)
{
 translate(inpx,inpy);
  rotate(inpRot);
  scale(inpScale);
  
  //bounding box
  //fill(255);
  //stroke(1);
  //rect(-100,-100,200,200);
  //line(100,0,-100,0);
  //line(0,100,0,-100);
  
  noStroke();
  
  //orange
  fill(255,125,0);
  
 
  
    //rear hind leg
  fill(200,100,0); // dark orange
  pushMatrix();
  translate(-25,-10);
  quad(40,25, 65,30, 55,75, 35,60);
  quad(50,50, 55,100,60,100, 70,60);
  fill(255,125,0); //orange
  popMatrix();
  
  
  
  //front legs
  pushMatrix();
  translate(0,20);
  fill(200,100,0);// dark orange
  quad(-35,10,-50,70,-45,70,-20,10);
  translate(15,10);
  fill(255,125,0); //orange
  quad(-35,10,-40,70,-35,70,-20,10);
  popMatrix();
  
  //chest
  quad(-40,0,-30,45,10,40,10,10);

  //hips
  quad(9,40,9,10,40,5,30,45);
  
  //front hind leg
  quad(40,5, 65,20, 55,75, 25,55);
  quad(50,50, 55,100,60,100, 70,60);
  
  
  //tail

  pushMatrix();
  translate(40,5);
  float temprot = sin((float)frameCount/10);
  float temprot2 = cos((float)frameCount/10);
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
  ellipse(-40,0,70,70);
  
  //ears
  triangle(-45,-50, -40,-35, -70,-18);
  triangle(5,-40, -7,-5, -35,-30);
  
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
}
