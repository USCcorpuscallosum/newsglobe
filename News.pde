public class News {

	public String newsText;
	
	public GpsCoordinate gpsCoordinate;

	public News(String newsText, GpsCoordinate gpsCoordinate) {
		this.newsText = newsText;
		this.gpsCoordinate = gpsCoordinate;
	}

	public String getNewsText() {
		return newsText;
	}

	public GpsCoordinate getGpsCoordinate() {
		return gpsCoordinate;
	}
}