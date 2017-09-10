import processing.sound.*;
import processing.video.*;

AudioIn in;
Amplitude amp;
Movie m;

float threshold = 0.03;
float scale = 1000.0;
float rhythm = 1000;
int lastClap = 0;
boolean listening = true;
int t;
int t_bloqueo = 50;
float speed = 1;

boolean silentMode = true;

void setup() {

  background(255, 10);
  size(700, 592);  
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  ellipseMode(CENTER);
  textMode(CENTER);
  m = new Movie(this, "test.mov");
  m.loop();
}

void draw() {  

  t = millis();
  background(255);

  float read = amp.analyze();  
  fill(255, 0, 0);
  noStroke();
  image(m, 0, 0);

  if ((listening)&&(read > threshold)) {
    ellipse(width/2, height/2, 50, 50);
    rhythm = t - lastClap;
    lastClap = t;
    listening = false;
    strokeWeight(10);
    stroke(100, 0, 0);
    noFill();
    rect(0, 0, width, height);
  }      

  if ((!listening)&&(t > (lastClap + t_bloqueo))) {
    // Pasa el tiempo de espera, desbloqueo la escucha
    listening = true;
  }    

  float new_speed = 1;

  if (rhythm < 300) {
    new_speed = 4;
  } else if (rhythm < 750) {
    new_speed = 2;
  } else if (rhythm < 1500) {
    new_speed = 1;
  } else if (rhythm < 2000) {
    new_speed = 0.75;
  } else if (rhythm < 2500) {
    new_speed = 0.5;
  } else {
    new_speed = 0.25;
  }

  if (new_speed != speed) {
    speed = new_speed;
    m.speed(speed);
  }  
  text(rhythm +" - "+speed, width/2, 100);
}


void movieEvent(Movie m) {
 m.read();
 }
 
/* 
 void keyPressed() {
 ellipse(width/2, height/2, 50, 50);
 rhythm = t - lastClap;
 lastClap = t;
 listening = false;  
 }
 */