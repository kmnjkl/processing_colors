int neighbours(Particle p) {
  int n = 0;
  for (int i=0; i < N; i++) {
    Particle tp = particles[i];
    float dist = sqrt(pow(p.px - tp.px, 2) + pow(p.py - tp.py, 2));
    if (dist < PINTERRAD) {
      n++;
    }
  }
  return n;
}

float neardist(Particle p) {
  float d = PINTERRAD;
  for (int i=0; i < N; i++) {
    Particle tp = particles[i];
    if (tp == p) continue;
    float td = sqrt(sq(p.px - tp.px) + sq(p.py - tp.py));
    if (td < d) {
      d = td;
    }
  }
  return d;
}

float centerofmassdist(Particle p) {
  float cmx=p.px, cmy=p.py;
  int n = 1;
  for (int i=0; i < N; i++) {
    Particle tp = particles[i];
    if (tp == p) continue;
    float dist = sqrt(pow(p.px - tp.px, 2) + pow(p.py - tp.py, 2));
    if (dist < PINTERRAD) {
      cmx += tp.px;
      cmy += tp.py;
      n++;
    }
  }
  cmx /= n;
  cmy /= n;
  
  float cmdist = sqrt(sq(p.px - cmx) + sq(p.py - cmy));
  return cmdist;
}

float globalcenterofmassdist(Particle p) {
  float cmx=p.px, cmy=p.py;
  for (int i=0; i < N; i++) {
    Particle tp = particles[i];
    if (tp == p) continue;
    cmx += tp.px;
    cmy += tp.py;
  }
  cmx /= N;
  cmy /= N;
  
  float cmdist = sqrt(sq(p.px - cmx) + sq(p.py - cmy));
  return cmdist;
}


class Particle {
  color pcolor;
  float px, py, pvx, pvy;
  float prad;
  
  Particle (color pcol, float px, float py, float pvx, float pvy, float prad) {
    this.pcolor = pcol;
    this.px = px;
    this.py = py;
    this.pvx = pvx;
    this.pvy = pvy;
    this.prad = prad;
  }
  
  void draw() {
    fill(pcolor);
    noStroke();
    circle(px, py, prad);
  }
  
  void move() {
    //pcolor = color(hue(pcolor)+HUESTEP*gameSpeed, saturation(pcolor), brightness(pcolor));
    
    float h, s=100, b=100;
    //println((float)neighbours(this)/(N-1));
    float ns = nnCalc.calc((float)neighbours(this)/(N-1));
    float neardist = neardist(this)/PINTERRAD;
    float cmdist = cmdistCalc.calc(centerofmassdist(this)/PINTERRAD);
    //float cmdist = cmdistCalc.calc(globalcenterofmassdist(this)/width);
    h = cmdist * 360;
    s = 100 * ns;
    //print(ns);
    //s = 30;
    b = (1 - neardist) * 50 + 50;
    pcolor = color(h, s, b, CALPHA);
    
    float pxinc = pvx*gameSpeed;
    float pyinc = pvy*gameSpeed;
    
    px += pxinc;
    py += pyinc;
    
    if (px + PBOUNCERAD >= width || px - PBOUNCERAD < 0) {
      float newpvx = random(0, PSPEEDLIM);
      if (pvx > 0) pvx = -newpvx;
      else pvx = newpvx;
      
      float newpvy = random(0, PSPEEDLIM);
      if (pvy > 0) pvy = newpvy;
      else pvy = -newpvy;
    }
    if (py + PBOUNCERAD >= height || py - PBOUNCERAD < 0) {
      float newpvy = random(0, PSPEEDLIM);
      if (pvy > 0) pvy = -newpvy;
      else pvy = newpvy;
      
      float newpvx = random(0, PSPEEDLIM);
      if (pvx > 0) pvx = newpvx;
      else pvx = -newpvx;
    }
  }
}
