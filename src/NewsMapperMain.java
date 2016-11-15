import java.util.ArrayList;

import processing.core.PApplet;
import processing.serial.*;


public class NewsMapperMain extends PApplet {

	public static void main(String[] args) {
		NewsManager newsManager = new NewsManager();

        PApplet.main("NewsMapperMain");
		while(true)
		{
			/* Get the collection of all things you want to draw. */
			ArrayList<Drawable> drawables = new ArrayList<Drawable>();

			// TODO: Instantiate the NewsToDrawable-subclass (which depends on how you want the visualizations to look like!).
			NewsToDrawable converter = null;
			
			for(News news: newsManager.GetNews())
			{
				drawables.add(converter.ConvertToDrawable(news));
			}
			
			/* Now, draw everything. */
			for(Drawable drawable: drawables)
			{
				drawable.Draw();
			}
			
			// TODO: Can replace this by something more intelligent - or remove it entirely, which results in maximal framerate, but 100% CPU load.
			try {
				Thread.sleep(10);
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
