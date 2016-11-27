import twitter4j.*;

public class TwitterNewsFeed extends NewsFeed {
 
  ArrayList<News> latest;
  
  Configuration config;
  
  {
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
    
    StatusListener feedUpdater = new StatusListener() {
      @Override
      public void onStatus(Status status) {
        String contents = status.getText();
        GpsCoordinate loc;
        try{
          println(status.getPlace().getName());
          println(status.getPlace().getBoundingBoxCoordinates()[0][0].getLatitude() + ", " + status.getPlace().getBoundingBoxCoordinates()[0][0].getLongitude());
          //print(status.getPlace().getName());
          //loc = place2Gps(status.getPlace());
          //print(contents);
          //print(loc.getLatitude());
          //println(loc.getLongitude());
          //latest.add(new News(contents, loc));
        } catch (NullPointerException e) {
          //print(contents);
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
    
    TwitterStream feed = new TwitterStreamFactory(config).getInstance();
    feed.addListener(feedUpdater);
    feed.filter(keywords);
  }
  
  public ArrayList<News> GetNewNews() {
    return latest;
  }
  
  GpsCoordinate place2Gps(Place place) throws NullPointerException {
    double lat = place.getGeometryCoordinates()[0][0].getLatitude();
    double lon = place.getGeometryCoordinates()[0][0].getLongitude();
    return new GpsCoordinate(lat, lon);
  }
  
}