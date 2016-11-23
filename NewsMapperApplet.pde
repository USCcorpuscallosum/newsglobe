import java.util.ArrayList;

import processing.core.PApplet;

public class NewsMapperApplet extends PApplet {

	private ArrayList<Drawable> drawables = new ArrayList<Drawable>();
	NewsManager newsManager = new NewsManager();
	
	
	public void run() {

	}
	
    public void settings(){
        size(500,300);
    }

    public void setup(){
        fill(120,50,240);
    }
    
    public void updateDrawables()
    {	
		drawables.clear();
		for(News news: newsManager.GetNews())
		{
			drawables.add(new PointDrawable(news, this));
		}
		
    }

    public void draw(){
		
    	// updateDrawables();
		// DEBUGGING
		drawables.add(new PointDrawable(new News("Test", new GpsCoordinate(-80, 100)), this));	
		
		for(Drawable drawable : drawables)
		{
			drawable.Draw();
		}
    }

}
