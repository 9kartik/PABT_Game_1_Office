PFont oc;

void showAll()
{
  size(displayWidth,displayHeight);
  background(0);
  border();
  oc=loadFont("OCRAExtended-48.vlw");
  showUpTop(60,3,skore);
  showUpMid();
  pressStart();
  showUpBot();
}

void border()
{
  pushStyle();
  strokeWeight(5);
  stroke(255);
  line(0,0,width,0);
  line(0,height,width,height);
  line(0,0,0,height);
  line(width,0,width,height);
  popStyle();
}
void showUpTop(int T,int Tr,int S)
{
  //Time 
  pushStyle();
  textMode(CENTER);
  textFont(oc,height/50);
  text("TIME:"+T+"s",width/30,2*height/50);
  if(screen1)text("TRIAL:"+Tr,width*12/30,2*height/50);
  text("SCORE:"+S,width*24/30,2*height/50);
  popStyle();
}
void showUpMid()
{
  //Time 
  pushStyle();
  textFont(oc,height/30);
  textMode(CENTER);
  text("CONTROL VELOCITY TEST",width/10,height/2-height/25);
  //text("TEST",width*12/30,height/2);
  popStyle();
}
boolean triggerGame;
void pressStart()
{
  pushStyle();
  textFont(oc,height/50);
  textMode(CENTER);
  text("PRESS",width*12/30,height*2/3+height/50);
  text("TO",width*14/30,height*2/3+2*height/50);
  //Start Button
  noSmooth();
  textFont(oc,height/45);
  stroke(255,255,0);
  fill(255,255,0);
  rect(width*16/30,height*2/3,width/8,height/25,4);
  fill(0);
  text("START",width*16/30,height*2/3+height*3/100);
  if(mousePressed)
  {  if(mouseX>width*16/30 && mouseX<(width*16/30+width/8) && mouseY<(height/25+height*2/3) && mouseY>(height*2/3))
    {
      screen1=false;
      tri=tri-1;
      skore=0;
    }
  } 
  popStyle();  
}

int y=0;

/*void draw()
{
  if(mousePressed)
  {  if(mouseX>width*16/30 && mouseX<(width*16/30+width/8) && mouseY<(height/25+height*2/3) && mouseY>(height*2/3))
    {
      println(y++);
      triggerGame=true;
    }
  } 
}*/

void showUpBot()
{
  //Time 
  pushStyle();
  textFont(oc,height/50);
  textMode(CENTER);
  text("TILT PHONE LEFT-RIGHT TO CATCH FALLING BALLS",width/32,height-height/50);
  popStyle();
}
