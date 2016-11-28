import processing.sound.*;

//All the items that get drawn on the map.
private ArrayList<Drawable> drawables = new ArrayList<Drawable>();
TwitterNewsFeed lfeed;
TwitterNewsFeed hfeed;
PImage bg;
SoundFile backgroundSound;

void setup() {
  size(2000, 1000, P3D);
  lfeed = new TwitterNewsFeed("love");
  hfeed = new TwitterNewsFeed("hate");
  
  bg = loadImage("map.png");
  
  backgroundSound = new SoundFile(this, "The Stars Are Falling (ambient guitar soundscapeStrymon Big SkyGodin LG).mp3");
  backgroundSound.amp(0.5);
  backgroundSound.loop();
}

void draw() {
  background(bg);
  
  //Get news from twitter stream maintainer.
  ArrayList<News> lnewNews = lfeed.getNewNews();
  ArrayList<News> hnewNews = hfeed.getNewNews();

  if(lnewNews.size() > 0) {
    for(News news : lnewNews) {
      println(news.getNewsText());
      drawables.add(new BloomDrawable(news, color(200, 234, 246)));
      //play a sound
      int random = (int) random(1, 9);
      SoundFile signalSound = new SoundFile(this, "celesta/c00" + random + ".ogg");
      signalSound.amp(0.1);
      signalSound.play();
    }
  }
  
  if(hnewNews.size() > 0) {
    for(News news : hnewNews) {
      println(news.getNewsText());
      drawables.add(new BloomDrawable(news, color(251, 208, 95)));
      //play a sound.
      int random = (int) random(1, 9);
      SoundFile signalSound = new SoundFile(this, "celesta/c00" + random + ".ogg");
      signalSound.amp(0.1);
      signalSound.play();
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