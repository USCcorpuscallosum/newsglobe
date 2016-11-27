import java.util.ArrayList;

public class NewsManager  {
	private ArrayList<NewsFeed> newsFeeds;

	public NewsManager() {
		newsFeeds = new ArrayList<NewsFeed>();
		
		// Insert news feed into the collection of news feeds here.
	}

	public ArrayList<News> GetNews() {
		ArrayList<News> news = new ArrayList<News>();
		for(NewsFeed newsFeed : newsFeeds)
		{
			news.addAll(newsFeed.getNewNews());
		}
		
		return news;
	}	
	
}