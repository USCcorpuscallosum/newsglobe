//All the items that get drawn on the map.
private ArrayList<Drawable> drawables = new ArrayList<Drawable>();
TwitterNewsFeed lfeed;
TwitterNewsFeed hfeed;
PImage bg;

void setup() {
  size(2000, 1000, P3D);
  lfeed = new TwitterNewsFeed("love");
  hfeed = new TwitterNewsFeed("hate");
  
  bg = loadImage("map.png");
}

void draw() {
  background(bg);
  
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