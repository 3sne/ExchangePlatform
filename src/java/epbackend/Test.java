package epbackend;

import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

class Test {

    public static class Data {
        public String max_ad_count;
        public List<Integer> ad_except;
        public Data() {}
    }
    
    public static void main(String[] args) {
        String jString = "{\"max_ad_count\" : \"12\",\"ad_except\": [1,2,3]}";
        Test t = new Test();
        Gson gson = new Gson();
        Data data = gson.fromJson(jString, Data.class);
        System.out.println(data.max_ad_count);
        for (int i = 0; i < data.ad_except.size(); i++) {
            System.out.println(data.ad_except.get(i).toString());
        }
    }

    String maxAdCount = "";
    String adExcept = "";

    // public void processJsonAdReq(String jsonLine) {
        
    //     Gson gson = new Gson();
    //     Type type = new TypeToken<Map<String, String>>(){}.getType();
    //     Map<String, String> trafficInput = new HashMap<>();
    //     trafficInput = gson.fromJson(jsonLine, type);
    //     System.out.println(trafficInput);
    //     System.out.println(gson.toJson(trafficInput));
        
    //     // JsonElement jelement = new JsonParser().parse(jsonLine);
    //     // JsonObject jOb, mac;
    //     // JsonArray ae;

    //     // jOb = jelement.getAsJsonObject();

    //     // mac = jOb.getAsJsonObject("max-ad-count");
    //     // this.maxAdCount = mac.getAsString();

    //     // ae = jOb.getAsJsonArray("ad-except");
    //     // for (int i = 0; i < ae.size(); i++) {
    //     // String temp = ae.get(i).getAsString();
    //     // this.adExcept += temp;
    //     // if (i + 1 != ae.size()) {
    //     // this.adExcept +=",";
    //     // }
    //     // }

    //     // public String parse(String jsonLine) {
    //     // JsonElement jelement = new JsonParser().parse(jsonLine);
    //     // JsonObject jobject = jelement.getAsJsonObject();
    //     // jobject = jobject.getAsJsonObject("data");
    //     // JsonArray jarray = jobject.getAsJsonArray("translations");
    //     // jobject = jarray.get(0).getAsJsonObject();
    //     // String result = jobject.get("translatedText").getAsString();
    //     // return result;
    //     // }
    // }

}