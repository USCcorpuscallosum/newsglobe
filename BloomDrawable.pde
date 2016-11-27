public class BloomDrawable extends Drawable {

  private News news;
  private color col;
  
  public BloomDrawable(News _news, color _col) {
    this.news = _news;
    this.col = _col;
  }

  @Override
  public void draw() {
    float xPixelCoordinate = (float) ((news.getGpsCoordinate().getLongitude() + 180) * (pixelWidth / 360.0));
    float yPixelCoordinate = (float) ((news.getGpsCoordinate().getLatitude() + 90) * (pixelHeight / 180.0));
    float dotDiameter = 5f;
    
    System.out.println("Drawing news with GpsCoordinate + " + news.getGpsCoordinate().getLongitude() + ", " + news.getGpsCoordinate().getLatitude() + " at " + xPixelCoordinate + "; " + yPixelCoordinate);
    fill(col);
    ellipse(xPixelCoordinate, yPixelCoordinate, dotDiameter, dotDiameter);
  }
}