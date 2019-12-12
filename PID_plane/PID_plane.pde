
class Controller {

  float P;
  float I;
  float D;

  Controller(float nP, float nI, float nD) {

    P = nP;
    I = nI;
    D = nD;
  }

  float output(float p, float i, float d) {
    return p*P + i*I + d*D;
  }
}

class Plane {

  float fWingSize;
  float bWingSize;
  float com; //as a percent of the way along the plane

  float fWingAngle;
  float bWingAngle;

  float planeAngle;

  float yVel;
  float h;

  Plane(float f, float b, float m) {
    fWingSize = f;
    bWingSize = b;
    com = m;

    fWingAngle = -15;
    bWingAngle = 50;

    planeAngle = 10;

    yVel = 0;
    h = height/2;
  }

  void physicsStep() {

    float fLift = fWingAngle * .075; //the .075 is determined as a roughly acceptable value;
    float bLift = bWingAngle * .075; //in units of kilo Newtons. plane weights 10 kilo Newtons

    float lift = fLift + bLift;
    yVel += (lift - 10)/10;
    h += yVel;

    //TODO: calculate torque and then rotate the craft
  }
}

void setup() {


  size(500, 500);
}

void draw() {

  Plane plane = new Plane(50, 20, 0.5);

  //drawing

  background(0);

  translate(width/2, plane.h);

  rotate(radians(plane.planeAngle));
  rect(-150, -10, 300, 20);

  translate(-140 + plane.fWingSize/2, 0);
  rotate(radians(plane.fWingAngle));
  rect(-plane.fWingSize/2, -5, plane.fWingSize, 10);
  rotate(radians(-plane.fWingAngle));
  translate(140 - plane.fWingSize/2, 0);

  translate(140 - plane.bWingSize/2, 0);
  rotate(radians(plane.bWingAngle));
  rect(-plane.bWingSize/2, -5, plane.bWingSize, 10);
  translate(140 + plane.bWingSize/2, 0);

  //physics

  plane.physicsStep();
}