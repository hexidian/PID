class Controller {

  float P, I, D;
  Controller(float nP, float nI, float nD) {
    P = nP;
    I = nI;
    D = nD;
  }

  float throttle(float p, float i, float d) {
    return p*P + i*I + d*D;
  }
}

Controller yPid = new Controller(.075, .0075, .1);
Controller xPid = new Controller(-.1, -.01, -.1);

int x_target = 200;
int y_target = 250;

final float sim_slow = 10.0;

float y_throttle;
float x_throttle;

float y;
float x;

float y_vel;
float x_vel;

float y_i;
float y_d;

float x_i;
float x_d;

void setup() {

  noStroke();

  y = 150;
  x = 250;
  y_vel = 0;
  x_vel = 0;

  y_i = 0;
  y_d = 0;
  x_i = 0;
  x_d = 0;

  size(500, 500);
}

void draw() {

  background(0);

  float last_height = y;
  float last_x = x;

  y_throttle = yPid.throttle(y-y_target, y_i, y_d);
  if (y_throttle >= 0) {
    y_vel += (1-y_throttle)/sim_slow;
  } else {
    y_vel += 1/sim_slow;
  }

  x_throttle = xPid.throttle(x-x_target, x_i, x_d);
  x_vel += x_throttle/sim_slow;

  y += y_vel;
  x += x_vel;

  y_d = (y - last_height)*sim_slow;
  y_i += (y - y_target)/sim_slow;

  x_d = (x - last_x)*sim_slow;
  x_i += (x-x_target)/sim_slow;

  fill(0, 255, 0);

  rect(0, y_target-2, 500, 4);

  rect(x_target-2, 0, 4, 500);

  fill(255);
  ellipse(x, y, 20, 20);
  fill(255, 0, 0);



  fill (255);

  text("x_vel: " + x_vel*sim_slow, 250, 75);
  text("x_throttle: " + x_throttle, 250, 100);
  text("y_throttle: " + y_throttle, 250, 125);
  /*
  text("x_p: " + (x-x_target), 250, 150);
  text("x_i: " + x_i, 250, 175);
  text("x_d: " + x_d, 250, 200);
  */

  fill(255, 0, 0);

  if (y_throttle > 0) {
    translate (x, y);
    rotate(atan(x_throttle/y_throttle));
    rect(-5, 10, 10, sqrt(sq(y_throttle) + sq(x_throttle)) * 10);
  } else {
    translate (x, y);
    rotate((x_throttle/abs(x_throttle)) * PI/2);
    rect(-5, 10, 10, x_throttle * 10);
  }
}

void keyPressed() {
  if (key=='w' || key =='W') {
    y_target -= 50;
  } else if (key == 's' || key == 'S') {
    y_target += 50;
  } else if (key == 'a' || key == 'A') {
    x_target -= 50;
  } else if (key == 'd' || key == 'D') {
    x_target += 50;
  }
}