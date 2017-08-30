import processing.sound.*;

AudioIn in;
Amplitude amp;

float threshold = 0.01;
float scale = 1000.0;
float rhythm = 0;
int lastClap = 0;
boolean listening = true;
int t_bloqueo = 50;

void setup() {

  background(255,10);
  size(700, 592);  
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  ellipseMode(CENTER);
  textMode(CENTER);
}

void draw() {
  
  int t = millis();
  background(255);
  float read = amp.analyze();
  // println(read);  
  fill(255,0,0);
  noStroke();
  text(rhythm, width/2, 100);
  if ((listening)&&(read > threshold)) {
    ellipse(width/2, height/2, 50, 50);
    println(t, lastClap, t-lastClap);
    rhythm = t - lastClap;
    lastClap = t;
    listening = false;
  }
  
  if ((!listening)&&(t > (lastClap + t_bloqueo))) {
    // Desbloqueo
    listening = true;
  } 
 
}