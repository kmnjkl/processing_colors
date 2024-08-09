class HPolynomial {
  // p - the number of data points -1
  int p;
  float[] xs;
  float[] ys;
  float[] dys;
  
  HPolynomial (int p, float[] xs, float[] ys, float[] dys) {
    this.p = p;
    this.xs = xs;
    this.ys = ys;
    this.dys = dys;
  }
  
  float calc(float x) {
    float res = 0;
    for (int k=0; k <= p; k++) {
      float sum1 = 0;
      float prod1 = 1;
      for (int i=0; i <= p; i++) {
        if (i==k) continue;
        sum1 += (x - xs[k]) / (xs[k] - xs[i]);
      }
      for (int j=0; j <= p; j++) {
        if (j==k) continue;
        prod1 *= sq((x - xs[j]) / (xs[k] - xs[j]));
      }
      res += ((x - xs[k])*dys[k] + (1 - 2*sum1)*ys[k]) * prod1;
    }
    return res;
  }
} 
