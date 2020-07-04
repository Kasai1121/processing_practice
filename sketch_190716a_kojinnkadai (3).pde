 int xspacing = 10;  
 int w;  
 float theta = 0.0;  
 float amplitude = 20.0; 
 float period = 500.0;  
 float dx;  
 float[] yvalues;  
 float z;
 float xspeed;
 float xpos;
 float ypos;
 float amp;
 import processing.serial.*;
 Serial microbit;
 float val = 0;
 import processing.sound.*;
 SoundFile wave;
 Drop [] drops = new Drop[500];

void setup(){
  size(900,900);
  frameRate(60);
  smooth();
  wave = new SoundFile(this, "sea-storm1.mp3");
  wave.loop();


  
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
  String portName = Serial.list()[2]; // [3]・・・・PCによって異なるので[0]から順にデータを取得できるかどうかを試す [0] → [1] → [2]・・・
  println(portName);
  microbit = new Serial(this, portName, 115200);
  microbit.clear();
  microbit.bufferUntil(10);
  
  for (int i = 0; i < drops.length; i++){
  drops[i] = new Drop();
  }
  
}

void draw(){
   background(0);
   drawSand();
   calcWave();
   renderWave();
   sky();
   bowlmove();
   wave.amp(amp);
   for (int i = 0; i < drops.length; i++){
  drops[i].show();
  drops[i].fall();
  }
 
 }
void drawSand() {
  noStroke();
  float x;
  float y;
  fill(#00a0e9);
 rect(0,300,900,300);
   fill(#FAF2DF);
    beginShape();
  for(x=0; x<=900; x +=0.1){
    y= 20*sin(x/50)+450;
    vertex(x,y);}
    vertex(900,500); vertex(900,900);
    vertex(0,900); vertex(0,500);
    endShape(CLOSE);
}
  

void calcWave() {
   theta += val;

   float x = theta;
   for (int i = 0; i < yvalues.length; i++) {
     yvalues[i] = sin(x)*amplitude;
     x+=dx;
   }
 }

 void renderWave() {
   for(z=0; z<=0.5; z += 0.01){
   noStroke();
   fill(#00a0e9);
   
   for (int x = 0; x < yvalues.length; x++) {
     ellipse(x*xspacing, height/(1.7+z)+yvalues[x], 35, 16);
   }
 }
 }
 
 void serialEvent(Serial microbit) {
String str = microbit.readStringUntil('\n'); 
str = trim(str); //
println(str);
int sensors[] = int(split(str, ' '));
println(sensors[0]);
val = map(sensors[0], -1023, 1023, 0.01, 0.3); 
xspeed = map(sensors[0], -1023, 1023, 1, 15);
amp = map(sensors[0], -1023, 1023, 0.0, 3.0);
}

void sky(){
noStroke();
color c1=color(#20262E);
color c2=color(#B5B9BF);
for(float h=0; h<height; h+=5){
 color c=lerpColor(c1,c2,h/height);
 fill(c);
 rect(0,h-550,width,5);
}
}

void bowlmove(){
  xpos += -xspeed;
  
  if( xpos < -100 ){
    xpos = width;
  }
  
  fill(#1EB936);
  ellipseMode(CENTER);
  ellipse( xpos, 15*sin(xpos/50)+450, 70, 70);
}
