public class GpsCoordinate {
	private double latitude;
	private double longitude;
	
	
	public GpsCoordinate(double latitude, double longitude) {
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public double getLatitude() {
		return latitude;
	}

}