import processing.sound.*;

//All the items that get drawn on the map.
private ArrayList<Drawable> drawables = new ArrayList<Drawable>();
String[] bterms = {"LOVE", "NATURAL", "RICH", "SAFE", "PEACE", "ART", "MAN", "HOT", "DREAM", "LIFE"};
String[] oterms = {"HATE", "FAKE", "POOR", "AFRAID", "WAR", "TECHNOLOGY", "WOMAN", "COLD", "REAL", "DEATH"};
int termIndex = 0;
TwitterNewsFeed ofeed;
TwitterNewsFeed bfeed;
PImage bg;
PFont myFont;
SoundFile backgroundSound;

PImage fadeAid;
int fadeOpac;
float textFall;
int lastSwitch = 0;

color bcol = color(200, 234, 246);
color ocol = color(251, 208, 75);

void setup() {
  fullScreen(P3D);
  
  bfeed = new TwitterNewsFeed(bterms[termIndex]);
  ofeed = new TwitterNewsFeed(oterms[termIndex]);
  
  bg = loadImage("map.png");
  
  backgroundSound = new SoundFile(this, "The Stars Are Falling (ambient guitar soundscapeStrymon Big SkyGodin LG).mp3");
  backgroundSound.amp(0.5);
  backgroundSound.loop();
  
  myFont = createFont("CODE Bold.otf", 140);
  textFont(myFont);
}

void draw() {
  noStroke();
  beginShape();
  tint(255);
  texture(bg);
  vertex(0, 0, 0, 0);
  vertex(width, 0, bg.width, 0);
  vertex(width, height, bg.width, bg.height);
  vertex(0, height, 0, bg.height);
  endShape();
  
  //Pick new terms to look at.
  if((millis() / 1000) - lastSwitch > 60) {
    lastSwitch = millis() / 1000;
    
    //The following saves an image for the crossfade.
    drawDrawables();
    
    fill(bcol);
    textAlign(LEFT, BOTTOM);
    text(bterms[termIndex], 20, height - 20 - textFall);
    fill(ocol);
    textAlign(RIGHT, BOTTOM);
    text(oterms[termIndex], width - 20, height - 20 - textFall);
    
    save("tmp.tif");
    
    //Switch over to the new terms.
    termIndex = (termIndex + 1) % bterms.length;
    bfeed.kill();
    ofeed.kill();
    
    fadeAid = loadImage("tmp.tif");
    fadeOpac = 255;
    textFall = 150;
    
    drawables = new ArrayList<Drawable>();
    
    bfeed = new TwitterNewsFeed(bterms[termIndex]);
    ofeed = new TwitterNewsFeed(oterms[termIndex]);
  }
  
  //Get news from twitter stream maintainer.
  ArrayList<News> lnewNews = bfeed.getNewNews();
  ArrayList<News> hnewNews = ofeed.getNewNews();

  if(lnewNews.size() > 0) {
    for(News news : lnewNews) {
      println(news.getNewsText());
      drawables.add(new BloomSparkDrawable(news, bcol));
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
      drawables.add(new BloomSparkDrawable(news, ocol));
      //play a sound.
      int random = (int) random(1, 9);
      SoundFile signalSound = new SoundFile(this, "celesta/c00" + random + ".ogg");
      signalSound.amp(0.1);
      signalSound.play();
    }
  }  

  drawDrawables();
  
  //Draw the label text.
  fill(bcol);
  textAlign(LEFT, BOTTOM);
  text(bterms[termIndex], 20, height - 20 - textFall);
  fill(ocol);
  textAlign(RIGHT, BOTTOM);
  text(oterms[termIndex], width - 20, height - 20 - textFall);
  textFall /= 1.01;
  
  //Manage the crossfades.
  if(fadeOpac > 2 && fadeAid != null) {
    noStroke();
    beginShape();
    texture(fadeAid);
    tint(255, fadeOpac);
    vertex(0, 0, 0, 0);
    vertex(width, 0, width, 0);
    vertex(width, height, width, height);
    vertex(0, height, 0, height);
    endShape();
    fadeOpac -= 2;
  }
}

void drawDrawables() {
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