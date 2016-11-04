import processing.core.PApplet;
import processing.serial.*;


public class NewsMapperMain extends PApplet {

	public static void main(String[] args) {
		NewsManager newsManager = new NewsManager();
		NewsToMapConverter newsToMapConverter = new NewsToMapConverter();
		

        PApplet.main("NewsMapperMain");
		while(true)
		{
			NewsMap newsMap = newsToMapConverter.Convert(newsManager.GetNews());
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
				System.exit(0);
			}
		}
	}
	
    public void settings(){
        size(300,300);
    }

    public void setup(){
        fill(120,50,240);
    }

    public void draw(){
        ellipse(width/2,height/2,second(),second());
    }

}
