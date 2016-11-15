import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;  
import java.io.BufferedReader;  

public class NewsMap {
	public int[][] mapValues;
	
	public NewsMap(int width, int height) {
		this.mapValues = new int[width][height];
		readMap();	
	}
	
	public void readMap()
	{
		//read data from the file into mapValues
		String pathName = "world_map.txt";
		File fileName = new File(pathName);
		InputStreamReader reader = new InputStreamReader(  
                    new FileInputStream(fileName));
		BufferedReader br = new BufferedReader(reader);
		
		int i = 0, j;
		String line = "";
		while((line = br.readLine()) != null)
		{
			String[] tmp = line.split(" ");
			j = -1;
			for(String str : tmp)
				mapValues[i][++j] = str == "0"? 0 : 1;
			i++;	
		}
	}

	public int SetCell(int x, int y, int value)
	{
		return mapValues[x][y] = value;
	}

	public int GetCell(int x, int y)
	{
		return mapValues[x][y];
	}
}
