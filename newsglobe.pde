//All the items that get drawn on the map.
private ArrayList<Drawable> drawables = new ArrayList<Drawable>();
TwitterNewsFeed feed;
PImage bg;

void setup() {
  size(2048, 1024);
  feed = new TwitterNewsFeed("trump");
  
  bg = loadImage("map/world_map.png");
}

void draw() {
  background(bg);
  
  //Get news from twitter stream maintainer.
  ArrayList<News> newNews = feed.getNewNews();

  if(newNews.size() > 0) {
    for(News news : newNews) {
      println(news.getNewsText());
      //println(news.getGpsCoordinate().getLatitude());
      drawables.add(new PointDrawable(news, color(255, 0, 0)));
    }
  }  

  for(Drawable drawable : drawables)
  {
    try{
      drawable.draw();
    } catch (Exception e) {
      print("1st tier");
      e.printStackTrace();
    }
  }
}