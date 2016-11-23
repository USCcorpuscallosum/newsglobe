
import processing.core.PApplet;

public class PointDrawable extends Drawable {

	private News news;
	private PApplet mainScreen;
	
	public PointDrawable(News news, PApplet mainScreen) {
		this.news = news;
		this.mainScreen = mainScreen;
	}

	@Override
	public void Draw() {
		float xPixelCoordinate = (float) ((news.getGpsCoordinate().getLongitude() + 180) * (mainScreen.pixelWidth / 360.0));
		float yPixelCoordinate = (float) ((news.getGpsCoordinate().getLatitude() + 90) * (mainScreen.pixelHeight / 180.0));
        float dotDiameter = 10f;
		
        System.out.println("Drawing news with GpsCoordinate + " + news.getGpsCoordinate().getLongitude() + ", " + news.getGpsCoordinate().getLatitude() + " at " + xPixelCoordinate + "; " + yPixelCoordinate);
		mainScreen.ellipse(xPixelCoordinate, yPixelCoordinate, dotDiameter, dotDiameter);
	}
}
