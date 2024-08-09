class ColorCircle {
  float x, y, rad;
  color col;
  
  ColorCircle (float x, float y, float rad, color col) {
    this.set(x, y, rad, col);
  }
  
  void set(float x, float y, float rad, color col) {
    this.x = x;
    this.y = y;
    this.rad = rad;
    this.col = col;
  }
  
  void draw() {
    fill(col);
    noStroke();
    circle(x, y, rad);
    
    rad += CCRADSPEED*gameSpeed;
  }
}
