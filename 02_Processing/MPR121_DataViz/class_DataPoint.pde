class DataPoint {
  // COORDINATES
  public float X;      // X coordinate of the data point
  public float Y;      // Y coordinate of the data point

  // DATA VALUES
  private boolean state;               // array list to store each new incoming raw data

  DataPoint(int ind_) {
    // Compute center of data point coordinated based on sensor index
    float w_ = NSENS * maxDiameter;
    float h_ = maxDiameter;
    float x0 = (width - w_)/2. + maxDiameter/2.;
    float y0 = (height - h_)/2. + maxDiameter/2.;
    this.X = x0 + ind_ * maxDiameter;
    this.Y = y0;

    this.state = false;
  }

  //----------------------------------------------------------------------------

  public void setState(boolean state_) {
    this.state = state_;
  }

  public void display(float maxDiameter_) {
    fill(colorPoints);
    noStroke();
    float d_ = 0;
    if(this.state) {
      d_ = maxDiameter_;
    } else {
      d_ = 0.3 * maxDiameter_;
    }
    ellipse(this.X, this.Y, d_, d_);
  }
}
