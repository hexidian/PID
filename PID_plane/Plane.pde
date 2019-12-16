
class Plane {

  float fWingSize;
  float bWingSize;
  float com; //as a percent of the way along the plane

  float fWingAngle;
  float bWingAngle;

  float planeAngle;
  float rotVel;

  float yVel;
  float h;

  Plane(float f, float b, float m) {
    fWingSize = f;
    bWingSize = b;
    com = m;

    fWingAngle = 0;
    bWingAngle = 0;

    planeAngle = 0;
    rotVel = 0;

    yVel = 0;
    h = height/2;
  }

  void physicsStep() {

    float fLift = (fWingAngle + planeAngle) * .075; //the .075 is determined as a roughly acceptable value;
    float bLift = (bWingAngle + planeAngle) * .075; //in units of kilo Newtons. plane weights 10 kilo Newtons

    float lift = fLift + bLift;
    yVel += (1 - lift)/10000;
    h += yVel;

    float torque = (fLift * com) - (bLift * (1-com) );
    rotVel += torque / 10000;
    planeAngle += rotVel;
    println(h);


    planeAngle %= 360;
    if (planeAngle > 180) {
      planeAngle -= 360;
    }
    /*
    if (fWingAngle > PI) {
     fWingAngle -= 2 * PI;
     }
     if (bWingAngle > PI) {
     bWingAngle -= 2 * PI;
     }
     */
  }

  void drawPlane() {
    translate(width/2, h);

    rotate(radians(planeAngle));
    rect(-150, -10, 300, 20);

    translate(-140 + fWingSize/2, 0);
    rotate(radians(fWingAngle));
    rect(-fWingSize/2, -5, fWingSize, 10);
    rotate(radians(-fWingAngle));
    translate(140 - fWingSize/2, 0);

    translate(140 - bWingSize/2, 0);
    rotate(radians(bWingAngle));
    rect(-bWingSize/2, -5, bWingSize, 10);
    translate(140 + bWingSize/2, 0);
  }

  void setF(float nf) {
    if (nf > 45) {
      fWingAngle = 45;
      return;
    }
    if (nf < -45) {
      fWingAngle = -45;
      return;
    }
    fWingAngle = nf;
  }

  void setB(float nb) {
    bWingAngle = nb;
  }
}