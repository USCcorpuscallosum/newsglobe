
public class NewsMap {
	private int[][] mapValues;
	
	public NewsMap(int width, int height) {
		this.mapValues = new int[width][height];
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
