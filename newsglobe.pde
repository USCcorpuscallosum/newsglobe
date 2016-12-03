import processing.sound.*;

//All the items that get drawn on the map.
private ArrayList<Drawable> drawables = new ArrayList<Drawable>();
String[] bterms = {"LOVE", "RICH", "SAFE", "PEACE", "ART", "MAN", "HOT", "DREAM", "LIFE", "JUSTICE", "DAY", "CALM"};
String[] oterms = {"HATE", "POOR", "AFRAID", "WAR", "TECHNOLOGY", "WOMAN", "COLD", "REAL", "DEATH", "CRIME", "NIGHT", "STRESSED"};
String[] btermsExp, otermsExp;
int termIndex = 0;
TwitterNewsFeed ofeed;
TwitterNewsFeed bfeed;
PImage bg;
PFont myFont;

boolean world = false;

//Sounds
SoundFile backgroundSound;
SoundFile[] switchSound;
SoundFile[] signalSound;

PImage fadeAid;
int fadeOpac;
float textFall;
int lastSwitch = 0;

color bcol = color(200, 234, 246);
color ocol = color(251, 208, 75);

int oldHeight;

void setup() {
  fullScreen(P3D, 1);
  //size(100, 100, P3D);
  oldHeight = height;
  height = width / 2;
  
  //Find synonyms
  btermsExp = expandTerms(bterms);
  otermsExp = expandTerms(oterms);
  
  for(String s : otermsExp){
    println(s);
  }
  
  bfeed = new TwitterNewsFeed(btermsExp[termIndex]);
  ofeed = new TwitterNewsFeed(otermsExp[termIndex]);
  
  //Setup background.
  if(world) {
    bg = loadImage("map.png");
  } else {
    bg = loadImage("map_us.png");
  }
  
  //Load sounds.
  backgroundSound = new SoundFile(this, "The Stars Are Falling (ambient guitar soundscapeStrymon Big SkyGodin LG).mp3");
  backgroundSound.amp(0.5);
  backgroundSound.loop();
  
  switchSound = new SoundFile[3];
  for(int i = 0; i < switchSound.length; i++) {
    switchSound[i] = new SoundFile(this, "swells/swell" + i + ".ogg");
    switchSound[i].amp(0.2);
  }
  
  signalSound = new SoundFile[8];
  for(int i = 0; i < signalSound.length; i++) {
    signalSound[i] = new SoundFile(this, "celesta/c00" + i + ".ogg");
    signalSound[i].amp(0.1);
  }
  
  myFont = createFont("CODE Bold.otf", 140);
  textFont(myFont);
}

void draw() {
  translate(0, (oldHeight - height) / 2);
  //pushMatrix();
  //translate(-width * 3/ 7, -height / 1.5);
  //scale(4);
  background(0);
  noStroke();
  beginShape();
  tint(255);
  texture(bg);
  vertex(0, 0, 0, 0);
  vertex(width, 0, bg.width, 0);
  vertex(width, height, bg.width, bg.height);
  vertex(0, height, 0, bg.height);
  endShape();
  
  if(world) {
    //transform so icons are drawn in right location.
    pushMatrix();
  }
  
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
    
    bfeed = new TwitterNewsFeed(btermsExp[termIndex]);
    ofeed = new TwitterNewsFeed(otermsExp[termIndex]);
    
    int random = (int) random(1, 3);
    switchSound[random].play();
  }
  
  //Get news from twitter stream maintainer.
  ArrayList<News> lnewNews = bfeed.getNewNews();
  ArrayList<News> hnewNews = ofeed.getNewNews();

  if(lnewNews.size() > 0) {
    for(News news : lnewNews) {
      println(news.getNewsText());
      drawables.add(new BloomSparkDrawable(news, bcol));
      //play a sound
      int random = (int) random(1, 8);
      signalSound[random].play();
    }
  }
  
  if(hnewNews.size() > 0) {
    for(News news : hnewNews) {
      println(news.getNewsText());
      drawables.add(new BloomSparkDrawable(news, ocol));
      //play a sound.
      int random = (int) random(1, 8);
      signalSound[random].play();
    }
  }  

  drawDrawables();
  
  //popMatrix();
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
    translate(0, -(oldHeight - height) / 2);
    noStroke();
    beginShape();
    texture(fadeAid);
    tint(255, fadeOpac);
    vertex(0, 0, 0, 0);
    vertex(width, 0, width, 0);
    vertex(width, oldHeight, width, oldHeight);
    vertex(0, oldHeight, 0, oldHeight);
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

String[] expandTerms(String [] toExpand) {
 String [] out = new String[toExpand.length];
 
 for(int i = 0; i < toExpand.length; i++){
   out[i] = LocalThesaurus.getSyns(toExpand[i]); 
 }
 
 return out;
}