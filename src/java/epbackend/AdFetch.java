package epbackend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AdFetch", urlPatterns = { "/adfetch" })
public class AdFetch extends HttpServlet {

    private static final long serialVersionUID = 1L;
    String maxAdCount = "";
    String adExcept = "";
    
    public static class Data {
        public String max_ad_count;
        public List<Integer> ad_except;
    }
    
    public static class Ad {
        String ad_id;
        String ad_poster_id;
        String ad_category_id;
        String ad_title;
        String ad_desc;
        String ad_price;
        String ad_location;
    }
    
    public static class AdJsonHelper {
        ArrayList<Ad> ad_list;
        int code;
    }
    
    public Data processJsonAdReq(String jsonLine) {
        // parse json string to Data object instance
        Gson gson = new Gson();
        Data data = gson.fromJson(jsonLine, Data.class);
        return data;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json; charset=utf-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession();
            Gson g = new Gson();
            
            // Get json string from request
            StringBuilder sb = new StringBuilder();
            String s;
            while ((s = request.getReader().readLine()) != null) {
                sb.append(s);
            }
            
            // setting up members
            Data d = this.processJsonAdReq(sb.toString());
            this.maxAdCount = d.max_ad_count;
            for (int i = 0; i < d.ad_except.size(); i++) {
                this.adExcept += d.ad_except.get(i).toString();
                if (i + 1 != d.ad_except.size()) {
                    this.adExcept += ",";
                }
            }
            
            
            Connection con = DBConnector.getCon();
            if (con == null) {
                out.println("<script type='text/javascript'>alert('Chimcken nugger');</script>");
                out.close();
                return;
            }
            Statement adFetchQuery = con.createStatement();
            ResultSet adResult;

            // preparing the Ad Fetch Query
            if (this.adExcept.isEmpty()) {
                adResult = adFetchQuery
                    .executeQuery("select * from ads limit " + this.maxAdCount);
            }else{
                adResult = adFetchQuery
                    .executeQuery("select * from ads where adid NOT IN(" + this.adExcept + ") limit " + this.maxAdCount);
            }
            
            AdJsonHelper ajh = new AdJsonHelper();
            ajh.ad_list = new ArrayList<Ad>(); 
            while (adResult.next()) {
                Ad exAd = new Ad();
                exAd.ad_id = adResult.getString("adid");
                exAd.ad_poster_id = adResult.getString("uid");
                exAd.ad_category_id = adResult.getString("cid");
                exAd.ad_title = adResult.getString("title");
                exAd.ad_desc = adResult.getString("description");
                exAd.ad_price = adResult.getString("price");
                exAd.ad_location = adResult.getString("city_id");
                ajh.ad_list.add(exAd);
                System.out.println(exAd.ad_id);
            }
            
            if (ajh.ad_list.size() > 0 && ajh.ad_list.size() <= Integer.parseInt(this.maxAdCount)) {
                ajh.code = 100;
            } else {
                ajh.code = 101;
            }
            String packedJsonString = g.toJson(ajh);
            out.println(packedJsonString);
        } finally {
            out.close();
        }
    }

 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Fetches ads from DB";
    }

}
