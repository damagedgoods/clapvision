import processing.sound.*;
import processing.video.*;

AudioIn in;
Amplitude amp;
Movie m;

float threshold = 0.03;
float scale = 1000.0;
float rhythm = 0;
int lastClap = 0;
boolean listening = true;
int t_bloqueo = 50;
float speed = 1;

void setup() {

  background(255,10);
  size(700, 592);  
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  ellipseMode(CENTER);
  textMode(CENTER);
  m = new Movie(this, "test3.mov");
  m.loop();
}

void draw() {
  
  
  
  int t = millis();
  background(255);
  image(m,0,0);
  float read = amp.analyze();  
  fill(255,0,0);
  noStroke();
  //text(rhythm, width/2, 100);
  text(speed, width/2, 100);
  if ((listening)&&(read > threshold)) {
    ellipse(width/2, height/2, 50, 50);
    //println(t, lastClap, t-lastClap);
    rhythm = t - lastClap;
    lastClap = t;
    listening = false;
  }    
  
  if ((!listening)&&(t > (lastClap + t_bloqueo))) {
    // Desbloqueo
    listening = true;
  }    
  
  float new_speed = 1;
  
  if (rhythm < 500) {
    new_speed = 4;
  } if (rhythm < 1000) {
    new_speed = 2;
  } else if (rhythm < 2000) {
    new_speed = 1;
  } else if (rhythm < 3000) {
    new_speed = 0.75;
  } else if (rhythm < 4000) {
    new_speed = 0.5;
  } else {
    new_speed = 0.25;
  }
  
  if (new_speed != speed) {
    speed = new_speed;
    m.speed(speed);
  }
  
  //speed = map(rhythm, 0, 4000, 5, 0.1);
  //println(speed);
  
  // m.speed(speed);
 
}

void movieEvent(Movie m) {
  m.read();
}