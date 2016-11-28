public class BloomDrawable extends Drawable {

  final float drag = 1.02;
  final float scaledrag = 1.1;
  
  private News news;
  private color col;
  private int numparts;
  private float[] speeds;
  private float[] locs;
  private float[] diameters;
  private float[] scalespeeds;
  
  PImage img;
  
  public BloomDrawable(News _news, color _col) {
    this.news = _news;
    this.col = _col;
    
    img = loadImage("blur.png");
    
    numparts = (int) random(4, 8);
    
    speeds = new float[numparts * 2];
    locs = new float[numparts * 2];
    diameters = new float[numparts];
    scalespeeds = new float[numparts];
    for(int i = 0; i < numparts; i++) {
      speeds[2 * i] = random(-.1, .1);
      speeds[2 * i + 1] = random(-.1, .1);
      locs[2 * i] = long2screen(news.getGpsCoordinate().getLongitude()) + random(0);
      locs[2 * i + 1] = lat2screen(news.getGpsCoordinate().getLatitude()) + random(0);
      diameters[i] = 0;
      scalespeeds[i] = random(1);
    }
  }

  @Override
  public void draw() {
    noStroke();

    for(int i = 0; i < numparts; i++) {
      locs[2 * i] += speeds[2 * i];
      locs[2 * i + 1] += speeds[2 * i + 1];
      speeds[2 * i] /= drag;
      speeds[2 * i + 1] /= drag;
      
      diameters[i] += scalespeeds[i];
      scalespeeds[i] /= scaledrag;
      
      float d = diameters[i];
      
      //ellipse(locs[2 * i], locs[2 * i + 1], diameters[i], diameters[i]);
      //println(locs[2 * i] + " " + locs[2 * i + 1]);
      beginShape();
      texture(img);
      tint(col);
      vertex(locs[2 * i] + d, locs[2 * i + 1] + d, 0, 0);
      vertex(locs[2 * i] + d, locs[2 * i + 1] - d, img.width, 0);
      vertex(locs[2 * i] - d, locs[2 * i + 1] - d, img.width, img.height);
      vertex(locs[2 * i] - d, locs[2 * i + 1] + d, 0, img.height);
      endShape();
    }
  }
  
  private float long2screen(float longe) {
    return ((longe + 180) * (width / 360.0));
  }
  
  private float lat2screen(float lat) {
    return ((-lat + 90) * (height / 180.0));
  }
  
}