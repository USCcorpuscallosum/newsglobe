import java.util.ArrayList;

public class NewsManager  {
	private ArrayList<NewsFeed> _newsFeeds;

	public NewsManager() {
		_newsFeeds = new ArrayList<NewsFeed>();
		
		// Insert news feed into the collection of news feeds here.
	}

	public ArrayList<News> GetNews() {
		ArrayList<News> news = new ArrayList<News>();
		for(NewsFeed newsFeed : _newsFeeds)
		{
			news.addAll(newsFeed.GetNewNews());
		}
		
		return news;
	}	
	
}
