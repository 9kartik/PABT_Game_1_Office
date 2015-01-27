import android.view.WindowManager;
import android.view.View;
import android.os.Bundle;

import ketai.sensors.*;

KetaiSensor sensor;
Maxim maxim;
AudioPlayer player;
float go;
boolean playit;


void onCreate(Bundle bundle) 
{
  super.onCreate(bundle);
  getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
}

int skore=0;
int tim=60,tri=3,sco=0;

class roundx{
    float R;
    color rgb;
    float x,y;
    
    void dr()
    {
    pushStyle();
    ellipseMode(CENTER);
    fill(rgb);
    stroke(rgb);
    ellipse(x,y,R,R);
    popStyle();
    }
}

class Ball extends roundx{
  Ball()
  {
  R=height/50;
  rgb=color(255,255,0);
  x=width/2;
  y=height-R;
  }
  void movR(float dx)
  {
    x=(width+x-dx)%width;
  }
  void movL(float dx)
  {
    x=(width+x-dx)%width;
  }
  float getX()
  {
    return x;
  }
  float getY()
  {
    return y;
  }
}


class Star extends roundx{
  Star()
  {
  R=height/50;
  rgb=color(255,255,255);
  x=width/2;
  y=-R;
  }
  float getX()
  {
    return x;
  }
  void setX(float dx)
  {
    x=dx;
    if(dx>width)
      x=width-dx-R*2;
    if(dx<0)
      x=-dx+R*2;  
  }
  
  float getY()
  {
    return y;
  }
  void setY(float dy)
  {
    y=dy;
  }
  void shiftdown()
  {
    y=(y+1)%(height);
  }
  boolean is_gt()
  {
    if(y==0) return true;
    return false;
  }
}

float initx,inity;
Ball B;
Star S[];
int g;
int nos;



void setup(){
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(PORTRAIT);
  oc=loadFont("OCRAExtended-48.vlw");
  size(displayWidth,displayHeight);
  noSmooth();
  maxim = new Maxim(this);////////////////     ___  sound at touch
  player = maxim.loadFile("touch.wav");///    | 
  player.setLooping(false);///////////////     ---\ 
  player.setAnalysing(false);/////////////    ----/
  g=30;
  nos=g;
  B=new Ball();
  S=new Star[g];
  for(int i=0;i<g;i++)  S[i]=new Star();
  //frameRate(4000);
  generate();
}

void generate()
{
  for(int i=0;i<nos;i++)
  {
  S[i].setX(S[(nos+i-1)%nos].getX()+width/20*random(-3.2,3.2));
  S[i].setY(S[(nos+i-1)%nos].getY()-(height/30));
  }
}
int hp=-1;

void drawLine(Ball B,Star S,int xp)
{
  pushStyle();
  if(dist(B.getX(),B.getY(),S.getX(),S.getY())<=(Rad+2) && hp!=xp)
  {
    player.play();
    skore++;
  }
  hp=xp;
  popStyle();
}

void changeme(int x)
{
      S[x].setX(S[(nos+x-1)%nos].getX()+width/20*random(-3.2,3.2));
      S[x].setY(S[(nos+x-1)%nos].getY()-(height/30));
}

int ixc=0;
int gh=0;
int Rad;
int xp=0;
boolean screen1=true;
void draw(){
  if(screen1) {tim=60;showAll();}
  else gameScreen();
}
int secC=-1;
int secD=-1;
void gameScreen(){
  background(0);
  Rad=height/50;
  secD=second();
  if(secD!=secC)
  {
    tim=tim-1;
    secC=secD;
  }
  if(tim==0) screen1=true;
  showUpTop(tim,tri,skore);
  textMode(CENTER);
  
  for(int i=0;i<nos;i++)
  {
    //generate2();
    S[i].dr();
    S[i].shiftdown();
  }
  //generate2();
  
  if(S[xp].getY()<height && S[xp].getY()>height-2*Rad )
  {
    drawLine(B,S[xp],xp);
  }
  if(S[xp].is_gt())
  {
    changeme(xp);
    xp=(xp+1)%nos;
  }
   B.dr();
   pushStyle();
   stroke(255,255,0);
   line(0,height-Rad/2,width,height-Rad/2);
   popStyle();
}

/*void keyPressed()
{
  if(keyCode==RIGHT)B.movR();
  if(keyCode==LEFT)B.movL();
  redraw();
}*/

void onAccelerometerEvent(float x,float y,float z)
{
  println(x);
  if(x<-1) B.movR(x);
  else if(x>1)  B.movL(x);
  else B.movR(0);
  // redraw();
}
