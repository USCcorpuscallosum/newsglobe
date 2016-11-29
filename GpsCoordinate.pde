public class GpsCoordinate {
	private float latitude;
	private float longitude;
  //private float n = 90;
  //private float s = -90;
  //private float e = 180;
  //private float w = -180;
  private float n = 49.8;
  private float s = 24.2;
  private float e = -66.5;
  private float w = -125.5;
	
	
	public GpsCoordinate(float latitude, float longitude) {
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public float getLongitude() {
		return longitude;
	}

	public float getLatitude() {
		return latitude;
	}

  public void setScreenBounds(float no, float so, float ea, float we) {
    n = no;
    s = so;
    e = ea;
    w = we;
  }

  public float getScreenLong() {
    return ((longitude - w) * (width / (e - w)));
  }
  
  public float getScreenLat() {
    return ((n - latitude) * (height / (n - s)));
  }

}