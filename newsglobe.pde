//All the items that get drawn on the map.
private ArrayList<Drawable> drawables = new ArrayList<Drawable>();
TwitterNewsFeed lfeed;
TwitterNewsFeed hfeed;
PImage bg;

void setup() {
  size(2048, 1024);
  lfeed = new TwitterNewsFeed("love");
  hfeed = new TwitterNewsFeed("hate");
  
  bg = loadImage("map/world_map.png");
}

void draw() {
  background(color(10, 10, 10));
  
  //Get news from twitter stream maintainer.
  ArrayList<News> lnewNews = lfeed.getNewNews();
  ArrayList<News> hnewNews = hfeed.getNewNews();

  if(lnewNews.size() > 0) {
    for(News news : lnewNews) {
      println(news.getNewsText());
      //println(news.getGpsCoordinate().getLatitude());
      drawables.add(new BloomDrawable(news, color(0, 0, 255)));
    }
  }
  
  if(hnewNews.size() > 0) {
    for(News news : hnewNews) {
      println(news.getNewsText());
      //println(news.getGpsCoordinate().getLatitude());
      drawables.add(new BloomDrawable(news, color(255, 0, 0)));
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