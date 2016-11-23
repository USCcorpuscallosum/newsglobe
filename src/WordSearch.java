import java.io.BufferedReader; 
import java.net.HttpURLConnection; 
import java.net.URL; 
import java.net.URLEncoder; 
import org.json.simple.*; 
import java.util.*;// json package, download at http://code.google.com/p/json-simple/ 
import org.*;

class WordSearch { 
 final String endpoint = "http://words.bighugelabs.com/api/2/"; 
 private String[] str_syn;
 private String[] str_ant;
  public void Search(String word) { 
	str_syn = str_ant = null;
    try { 
      URL serverAddress = new URL(endpoint+ "72e2a0e30e6dbcc23d747ab37b54c933" +"/" + word +"/json"); 
      HttpURLConnection connection = (HttpURLConnection)serverAddress.openConnection(); 
      connection.connect(); 
      int rc = connection.getResponseCode(); 
      if (rc == 200) { 
        String line = null; 
        BufferedReader br = new BufferedReader(new java.io.InputStreamReader(connection.getInputStream())); 
        StringBuilder sb = new StringBuilder(); 
        while ((line = br.readLine()) != null) 
          sb.append(line + '\n'); 
	 

        JSONObject obj = (JSONObject) JSONValue.parse(sb.toString()); 
       
        JSONObject array = (JSONObject)obj.get("adjective"); 
  	if(array != null)
{
	List<String> tmp = new ArrayList<String>();
 
	int syn_size, sim_size, rel_size, i;
	syn_size = sim_size = rel_size = 0;

        JSONArray syn = (JSONArray)array.get("syn");
	 if(syn !=null)
	{
	 syn_size = syn.size();
	for( i = 0; i< syn_size;i++)
		tmp.add(syn.get(i).toString());
	}

        JSONArray sim = (JSONArray)array.get("sim"); 
	if(sim !=null)
	{
	 sim_size = sim.size();
	for( i = 0; i< sim_size;i++)
		tmp.add(sim.get(i).toString());
	} 
  	JSONArray rel = (JSONArray)array.get("rel"); 
	if(rel !=null)
	{
	 rel_size = rel.size();
	for( i = 0; i< rel_size;i++)
		tmp.add(rel.get(i).toString());
	} 
	
	

	

         
	str_syn = new String[syn_size + sim_size + rel_size];
	str_syn = tmp.toArray(str_syn);

	JSONArray ant = (JSONArray)array.get("ant"); 
       if(ant != null)
	{
	int ant_size = ant.size();
       	tmp.clear();
	for(i = 0; i< ant_size;i++)
		tmp.add(ant.get(i).toString());
	str_ant = new String[ant_size];
	str_ant = tmp.toArray(str_ant);
	}
}
      } else System.out.println("HTTP error:"+rc); 
      connection.disconnect(); 
    } catch (java.net.MalformedURLException e) { 
      e.printStackTrace(); 
    } catch (java.net.ProtocolException e) { 
      e.printStackTrace(); 
    } catch (java.io.IOException e) { 
      e.printStackTrace(); 
    } 
  } 

 public String[] GetSyn()
 {
	return str_syn;
 }

 public String[] GetAnt()
 {
	return str_ant;
 }
} 
