//import twitter4j.FilterQuery;
//import twitter4j.Status;
//import twitter4j.StatusDeletionNotice;
//import twitter4j.StatusListener;
//import twitter4j.StallWarning;
//import twitter4j.TwitterException;
//import twitter4j.TwitterStream;
//import twitter4j.TwitterStreamFactory;
//import java.io.*;

//public class Stream {
//    public static void main(String[] args) throws TwitterException,IOException  {
//    TwitterStream twitterStream = new TwitterStreamFactory().getInstance();
//	File file1 = new File("tweets.txt");
//	FileWriter file = new FileWriter(file1);

//    StatusListener listener = new StatusListener() {

//        public void onStatus(Status status) {
//			if(status.getGeoLocation() != null)
//            {
//				System.out.println("@" + status.getUser().getScreenName() + " - " + status.getText() + " - " + status.getGeoLocation());
//				try {
//					file.write("@" + status.getUser().getScreenName() + " - " + status.getText() + " - " + status.getGeoLocation() + "\n");
//					file.flush();
//					}
//				catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//				}
//			}
//        }

//        public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
//            //System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
//        }

//        public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
//            //System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
//        }

//        public void onScrubGeo(long userId, long upToStatusId) {
//            //System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
//        }

//		public void onStallWarning(StallWarning warning) {
//            //System.out.println("Got stall warning:" + warning);
//        }
			
//        public void onException(Exception ex) {
//            //ex.printStackTrace();
//        }
//    };

//    FilterQuery fq = new FilterQuery();
//    String keywords[] = {"France", "Germany"};

//    fq.track(keywords);

//    twitterStream.addListener(listener);
//    twitterStream.filter(fq);      
//}
//}