import java.io.FileReader;
import java.util.regex.*;

public static class LocalThesaurus {
  
  static final String englThes;

  static {
    StringBuilder stringBuilder = new StringBuilder();
    try{
      String line;
      String ls = System.getProperty("line.separator");
      BufferedReader reader = new BufferedReader(new FileReader("/Users/trevornielsen/Desktop/newsglobe/data/mobythes.aur"));
      
      try { 
        while((line = reader.readLine()) != null) {
            stringBuilder.append(line);
            stringBuilder.append(ls);
        }
    
      } finally {
          reader.close();
      }
    } catch (IOException e) {
      println("Thesaurus is missing. Falling into basic mode.");
    }
    englThes = stringBuilder.toString();
  }
  
  public static String getSyns(String origin) {
    Pattern p = Pattern.compile("(^afraid,.+$)");
    p = Pattern.compile("\n(" + origin.toLowerCase() + ",.*)");
    Matcher m = p.matcher(englThes);
    if(m.find()) {
      return m.group();
    } else {
      println("messed up");
      return origin;
    }
  }
  
}