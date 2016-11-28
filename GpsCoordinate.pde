public class GpsCoordinate {
	private float latitude;
	private float longitude;
	
	
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

}