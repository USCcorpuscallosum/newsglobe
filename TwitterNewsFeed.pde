import twitter4j.*;

public class TwitterNewsFeed extends NewsFeed {
 
  ArrayList<News> latest;
  TwitterStream feed;
  
  private float n = 49.8;
  private float s = 25;
  private float e = -66.5;
  private float w = -125.5;
  
  Configuration config;
  
  {
    //At runtime initialization, add the consumer keys and tokens to twitter4j. Only runs once.
    ConfigurationBuilder build = new ConfigurationBuilder();
    build.setOAuthConsumerKey("IIkKrnUmyYhoXmWZibMah068M");
    build.setOAuthConsumerSecret("5CTmBJ8dMBelClERjlMMi6Ly5gJ6YrYdOS7srNIQwxceLlGWOM");
    build.setOAuthAccessToken("629643072-bJgaYaazlSlLbnWPg12Plhq9kg8IjfiVJOkPPNBD");
    build.setOAuthAccessTokenSecret("zI2cXksjvXl4yqmJtMaIS1vwt1lWdunXF6BOBPtLPk7JE");
    config = build.build();
  }
  
  TwitterNewsFeed(String keywords) {
    //Perform a search on the twitter API to fetch the last few related search terms.
    //Open a connection to the twitter Streaming API based on the keywords above.
    
    latest = new ArrayList<News>();
    
    StatusListener feedUpdater = new StatusListener() {
      @Override
      public void onStatus(Status status) {
        try{
          //Get the text of the tweets, can print a sample for debug or whatever.
          String contents = status.getText();
          //Fetch the geolocation of the tweets. Will be used to mark the dynamic map.
          float lat = (float) status.getPlace().getBoundingBoxCoordinates()[0][0].getLatitude();
          float lon = (float) status.getPlace().getBoundingBoxCoordinates()[0][0].getLongitude();
          GpsCoordinate loc = new GpsCoordinate(lat, lon);
          //Add the news item to the queue of unread tweets.
          if(lon < e && lon > w && lat < n && lat > s) {
            synchronized(latest) {
              latest.add(new News(contents, loc));
            }
          }
        } catch (NullPointerException e) {
          //Do nothing.
        }
      }
  
      @Override
      public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
          System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
      }
  
      @Override
      public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
          System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
      }
  
      @Override
      public void onScrubGeo(long userId, long upToStatusId) {
          System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
      }
  
      @Override
      public void onStallWarning(StallWarning warning) {
          System.out.println("Got stall warning:" + warning);
      }
  
      @Override
      public void onException(Exception ex) {
          ex.printStackTrace();
      }
    };
    
    feed = new TwitterStreamFactory(config).getInstance();
    feed.addListener(feedUpdater);
    feed.filter(keywords);
  }
  
  public ArrayList<News> getNewNews() {
    synchronized(latest) {
      if(latest.size() > 0){
        ArrayList<News> toReturn = (ArrayList<News>) latest.clone();
        latest = new ArrayList<News>();
        return toReturn;
      } else {
        return new ArrayList<News>(); 
      }
    }
  }
  
  void kill() {
    feed.cleanUp();
    feed.shutdown();
  }
  
}