
public class NewsMapperMain {

	public static void main(String[] args) throws InterruptedException {
		NewsManager newsManager = new NewsManager();
		NewsToMapConverter newsToMapConverter = new NewsToMapConverter();
		
		while(true)
		{
			NewsMap newsMap = newsToMapConverter.Convert(newsManager.GetNews());
			Thread.sleep(1000);
		}
	}

}
