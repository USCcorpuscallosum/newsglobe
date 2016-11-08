import java.util.ArrayList;

public class NewsToMapConverter {
	private NewsMap newsMap;
	private ArrayList<int> tweetsLocations;
	public NewsToMapConverter()//static
	{
		this.newsMap = new NewsMap(144,288);
		tweetsLocations.clear();
	}
	public NewsMap Convert(ArrayList<News> news)//dynamic
	{   
		//NewsMap newsMap = new NewsMap(144, 288);
		
		// TODO: Write code that populates the news map with the news.
		
		// clear previous output 
		int number = tweetsLocations.size()/ 2;
		int i;
		int x , y;
		for(i = 0; i < number; )
		{
			x = tweetsLocations.get(i++);
			y = tweetsLocations.get(i++);
			newsMap.mapValues[x][y] = newsMap.mapValues[x][y] - 2;
		}
		tweetsLocations.clear();
		
		// update map
		News aNew;
		number = news.size();
		for(i = 0;i < number;i++)
		{
			aNew = news.get(i);
			//coordinate change
			x = (90 - aNew.gpsCoordinate.latitude) * 144 / 180;
			y = (180 + aNew.gpsCoordinate.longitude) * 288 / 360;
			newsMap.mapValues[x][y] = newsMap.mapValues[x][y] + 2;
			///////////////////
			tweetsLocations.add(x);
			tweetsLocations.add(y);
		}
		return newsMap;
	}
}
