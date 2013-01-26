float mouseRot;
float mouseScale;
void setup()
{
  size(400,400);
}

void draw()
{
  background(100);
  mouseRot = map(mouseX,0,width,-PI/4,PI/4);
  mouseScale = map(mouseY,0,height,.5,2);
  
  
  translate(200,200);
  rotate(mouseRot);
  scale(mouseScale);
  
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
  curve(-30,20,40,5,60,-20,45,-70);
  curve(40,5,60,-20,45,-50, 0,-50);
  curve(60,-30,45,-50, 55,-80, 120, -120);
  
   //head
  ellipse(-40,0,70,70);
  
  //ears
  triangle(-45,-50, -40,-35, -70,-18);
  triangle(5,-40, -7,-5, -35,-30);
  
  //eyes
  fill(255);
  ellipse(-70,0,7,20);
  ellipse(-47,5,17,24);
}
