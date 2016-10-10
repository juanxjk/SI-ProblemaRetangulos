class Rect {
  float xL, yL;
  float x_min, y_min;
  float x_max, y_max;

  Rect(float x_min, float y_min, float x_max, float y_max) {
    this.xL = x_max - x_min;
    this.yL = y_max - y_min;
    this.x_min = x_min;
    this.y_min = y_min;
    this.x_max = x_max;
    this.y_max = y_max;
  }

  void draw() {
    fill(128, 15);
    rectMode(CORNERS);
    rect(x_min, y_min, x_max, y_max);
  }

  float area() {
    return this.xL*this.yL;
  } 

  boolean isSobreposition(Rect a) {
    if (this.x_max<a.x_min) return false;
    if (this.x_min>a.x_max) return false;
    if (this.y_max<a.y_min) return false;
    if (this.y_min>a.y_max) return false;
    return true;
  }

  void randomize() {
    this.x_min = random(0, width - this.xL);
    this.y_min = random(0, height - this.yL);
    this.x_max = this.x_min + this.xL;
    this.y_max = this.y_min + this.yL;
  }
}