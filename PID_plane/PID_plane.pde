
float targetHeight;
//float targetAngle;

Controller controller = new Controller( 0.1, 0.0, 0.2);
Plane plane = new Plane(50, 20, 0.5);

void setup() {

  targetHeight = 250;
  //targetAngle = 0;

  //adjust the inital values. These are not the tuning values
  controller.updatePID(0);

  size(500, 500);
}

void draw() {


  background(0);
  plane.drawPlane();

  plane.physicsStep();

  //assign the p,i,d values
  controller.updatePID(plane.h - targetHeight);

  plane.setF(controller.output());
}