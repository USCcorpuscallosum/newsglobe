//All the items that get drawn on the map.
private ArrayList<Drawable> drawables = new ArrayList<Drawable>();
//Not sure what this is for.
NewsManager newsManager = new NewsManager();
TwitterNewsFeed feed;

void setup() {
  size(1024, 768);
  feed = new TwitterNewsFeed("love");
}

void draw() {
  background(20);
  
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