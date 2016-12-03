public class BloomSparkDrawable extends Drawable {

  final float speedCap = .1;
  final float drag = 1.01;
  final float scaledrag = 1.04;
  final float colorFudge = .1;
  final float scaleSpeedCap = .5;
  
  private News news;
  private color col;
  private int numparts;
  private float[] speeds;
  private float[] locs;
  private float[] diameters;
  private float[] scalespeeds;
  private float ringWeight = 255;
  private float ringSize = 0;
  private float ringScaler = 2;
  private float tint = 100;
  
  private PImage img;
  
  public BloomSparkDrawable(News _news, color _col) {
    this.news = _news;
    colorMode(HSB, 255);
    float h = hue(_col) * (1 + random(-colorFudge, colorFudge));
    float s = saturation(_col);
    float b = brightness(_col);
    col = color(h, s, b);    
    colorMode(RGB, 255);
    img = loadImage("blur.png");
 
    numparts = (int) random(15, 30);
    
    speeds = new float[numparts * 2];
    locs = new float[numparts * 2];
    diameters = new float[numparts];
    scalespeeds = new float[numparts];
    for(int i = 0; i < numparts; i++) {
      speeds[2 * i] = random(-speedCap, speedCap);
      speeds[2 * i + 1] = random(-speedCap, speedCap);
      locs[2 * i] = news.getGpsCoordinate().getScreenLong();
      locs[2 * i + 1] = news.getGpsCoordinate().getScreenLat();
      diameters[i] = 0;
      scalespeeds[i] = random(scaleSpeedCap);
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
      tint(col, tint/=1.00001);
      vertex(locs[2 * i] + d, locs[2 * i + 1] + d, 0, 0);
      vertex(locs[2 * i] + d, locs[2 * i + 1] - d, img.width, 0);
      vertex(locs[2 * i] - d, locs[2 * i + 1] - d, img.width, img.height);
      vertex(locs[2 * i] - d, locs[2 * i + 1] + d, 0, img.height);
      endShape();
    }
    
    stroke(col, ringWeight);
    noFill();
    if(ringWeight > 2) {
      ringWeight /= 1.01;
      ellipse(news.getGpsCoordinate().getScreenLong(), news.getGpsCoordinate().getScreenLat(), ringSize, ringSize);
      ringSize += ringScaler + .25;
      ringScaler/=1.02;
    }
  }
}