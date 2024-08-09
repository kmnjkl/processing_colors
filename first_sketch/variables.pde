// VARIABLES
final int N = 50;
Particle[] particles = new Particle[N];

final boolean ENABLE_CC = false;
final int CCNMULT = 3;
final int ccN = N * CCNMULT;
ColorCircle[] colorCircles = new ColorCircle[ccN];
int ccRound = 0;

float gameSpeed = 1;

HPolynomial cmdistCalc;
HPolynomial nnCalc;

// CONSTANTS
final float gsstep = 0.1;
final float gsmult = 2;

final int setFrameRate = 240;

final int HUESTEP = 1;
final int CALPHA = 10;

final float PSPEEDLIM = 3, PRAD = 15, PBOUNCERAD = 10;
final float PINTERRAD = 300;

final float CCRADSPEED = 10;
final float CCDELAY = 50;
final float CCALPHA = 10;

final float[] h_hxs =   {0, 0.2,         0.6,        1};
final float[] h_hys =   {0, 0.2,         0.8,        1};
final float[] h_hdys =  {0, 33.43/18.58, 8.98/15.21, 0};

final float[] s_hxs =   {0, 0.05,       0.1601,      1};
final float[] s_hys =   {0, 0.3,        0.6652,      1};
final float[] s_hdys =  {0, 33.16/4.15, 13.48/13.99, 0};
