import java.time.Instant;

void sceneSetup() {
  background(0);

  for (int i=0; i < N; i++) {
    color col = color(0, CALPHA);
    particles[i] = new Particle(col, width/2, height/2, random(-PSPEEDLIM, PSPEEDLIM), random(-PSPEEDLIM, PSPEEDLIM), PRAD);
  }

  if (ENABLE_CC) {
    for (int i=0; i < ccN; i++) {
      colorCircles[i] = new ColorCircle(0, 0, 0, color(0));
    }
  }
}

void setup() {
  fullScreen();
  colorMode(HSB, 360, 100, 100, 100);
  ellipseMode(RADIUS);
  textAlign(LEFT, TOP);
  frameRate(setFrameRate);
  //blendMode(BLEND);  // Default.
  //blendMode(LIGHTEST);
  //blendMode(REPLACE);


  cmdistCalc = new HPolynomial(3, h_hxs, h_hys, h_hdys);
  nnCalc = new HPolynomial(3, s_hxs, s_hys, s_hdys);

  sceneSetup();
}

void keyReleased() {
  if (keyCode == ESC) {
    exit();
  } else if (key == 'r') {
    sceneSetup();
  } else if (key == '=') {
    //gameSpeed += gsstep;
    gameSpeed *= gsmult;
  } else if (key == '-') {
    //gameSpeed -= gsstep;
    gameSpeed /= gsmult;
  } else if (key == 'p') {
    save("/home/kmnjkl/Documents/Projects/processing_colors/Pictures/frame_"+Instant.now().toString()+".png");
  }
}

void draw() {
  if (ENABLE_CC) {
    if (frameCount % CCDELAY == 0) {
      for (int i=0; i < N; i++) {
        Particle cp = particles[i];
        colorCircles[ccRound*N + i].set(cp.px, cp.py, cp.prad, cp.pcolor);
      }
      ccRound = (ccRound+1) % CCNMULT;
    }

    for (int i=0; i < ccN; i++) {
      colorCircles[i].draw();
    }
  }

  for (int i=0; i < N; i++) {
    particles[i].draw();
    particles[i].move();
  }

  fill(320);
  stroke(250);
  strokeWeight(3);
  rect(10, 10, 200, 100);

  fill(0);
  String prt;
  prt = "gameSpeed ";
  text(prt, 15, 15);
  text(gameSpeed, 100, 15);
  prt = "frameRate";
  text(prt, 15, 30);
  text(frameRate, 100, 30);
  text(setFrameRate, 160, 30);
  float avgcmdist = 0, mincmdist=PINTERRAD, maxcmdist=0;
  for (int i=0; i < N; i++) {
    float cmdist = centerofmassdist(particles[i]);
    avgcmdist += cmdist;
    if (cmdist < mincmdist) mincmdist = cmdist;
    if (cmdist > maxcmdist) maxcmdist = cmdist;
  }
  avgcmdist /= N;
  text("cmdist", 15, 45);
  text(avgcmdist/PINTERRAD, 65, 45);
  text(mincmdist/PINTERRAD, 105, 45);
  text(maxcmdist/PINTERRAD, 145, 45);
  float avgnn = 0;
  int minnn=N, maxnn=0;
  for (int i=0; i < N; i++) {
    int nn = neighbours(particles[i]);
    avgnn += nn;
    if (nn < minnn) minnn = nn;
    if (nn > maxnn) maxnn = nn;
  }
  avgnn /= N;
  text("nn", 15, 60);
  text(avgnn/(N-1), 50, 60);
  text((float)minnn/(N-1), 90, 60);
  text((float)maxnn/(N-1), 130, 60);
  text(N, 180, 60);
}
