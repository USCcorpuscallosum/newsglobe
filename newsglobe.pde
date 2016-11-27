private ArrayList<Drawable> drawables = new ArrayList<Drawable>();
NewsManager newsManager = new NewsManager();

void setup() {
  size(1024, 768);
  drawables.add(new PointDrawable(new News("Test", new GpsCoordinate(-80, 100)), this));
  TwitterNewsFeed test = new TwitterNewsFeed("trump");
}

void draw() {
  background(20);
  
  //Get news from twitter stream maintainer.

  for(Drawable drawable : drawables)
  {
    drawable.draw();
  }
}