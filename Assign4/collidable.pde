import java.awt.Rectangle;

public class CollidableObj
{
  //float x, y,w,h = 0;
  float v;
  Rectangle bound;
  
  CollidableObj(float inpx, float inpy,float inpw, float inph,float inpv)
  {
    /*
    x = inpx;
    y = inpy;
    w = inpw;
    h = inph;
    */
    v = inpv;
    
    
    bound = new Rectangle((int)inpx,(int)inpy,(int)inpw,(int)inph);
  }
}

