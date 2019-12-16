
class Controller {

  float P;
  float I;
  float D;

  float p = 0;
  float i = 0;
  float d = 0;

  float lastError = 0;

  Controller(float nP, float nI, float nD) {

    P = nP;
    I = nI;
    D = nD;
  }

  void updatePID(float error){
    p = error;
    i += error;
    d = error - lastError;
  }

  float output() {
    return p*P + i*I + d*D;
  }
}