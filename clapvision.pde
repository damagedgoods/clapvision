import processing.sound.*;
import processing.video.*;

AudioIn in;
Amplitude amp;
Movie m;

float threshold = 0.3;
float scale = 1000.0;
int rhythm = 1000;
int lastClap = 0;
boolean listening = true;
int t;
int t_bloqueo = 100;
float speed = 1;

int min_rhythm = 300;
int step = 500;

boolean silentMode = true;

void setup() {

  background(255, 10);
  size(1200, 600);  
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  ellipseMode(CENTER);
  textMode(CENTER);
  m = new Movie(this, "test3.mp4");
  m.loop();
}

void draw() {  

  t = millis();
  background(255);

  float read = amp.analyze();
  fill(255, 0, 0);
  noStroke();
  image(m, 0, 0);

  if (listening) {
    rhythm = t - lastClap;
    if (read > threshold) {
      ellipse(width/2, height/2, 50, 50);      
      lastClap = t;
      listening = false;
      strokeWeight(10);
      stroke(100, 0, 0);
      noFill();
      rect(0, 0, width, height);
    } else {
      rhythm = t - lastClap;    
    }    
  }

  if ((!listening)&&(t > (lastClap + t_bloqueo))) {
    // Pasa el tiempo de espera, desbloqueo la escucha
    listening = true;
  }

  float new_speed = getSpeed(rhythm);

  if (new_speed != speed) {
    speed = new_speed;
    m.speed(speed);
  }  
  text(rhythm +" - "+speed, width/2, 100);
}

float getSpeed(int rhythm) {
  if (rhythm < min_rhythm) {
    return 4;
  } else if (rhythm < min_rhythm+step) {
    return 2;
  } else if (rhythm < min_rhythm+step*2) {
    return 1;
  } else if (rhythm < min_rhythm+step*3) {
    return 0.75;
  } else if (rhythm < min_rhythm+step*4) {
    return 0.5;
  } else {
    return 0.25;
  }

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
