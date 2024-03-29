package epbackend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AdFetch", urlPatterns = { "/adfetch" })
public class AdFetch extends HttpServlet {

    private static final long serialVersionUID = 1L;
    String maxAdCount = "";
    ArrayList<Integer> adExcId = new ArrayList<Integer>();

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
        String ad_date;
        String ad_location_id;
        String ad_location_city;
        String ad_location_state;
        String ad_status;
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

    public static String convert(String sql, final int params) {
        final StringBuilder sb = new StringBuilder(new String(new char[params]).replace("\0", "?,"));
        sb.setLength(Math.max(sb.length() - 1, 0));
        if (sb.length() > 1) {
            sql = sql.replace("(?)", "(" + sb + ")");
        }
        return sql;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        response.setContentType("application/json; charset=utf-8");
        PrintWriter out = response.getWriter();

        try {
            Gson g = new Gson();

            // Get json string from request
            StringBuilder sb = new StringBuilder();
            String s;
            while ((s = request.getReader().readLine()) != null) {
                sb.append(s);
            }

            Data d = this.processJsonAdReq(sb.toString());
            this.adExcId.clear();
            this.maxAdCount = d.max_ad_count;
            for (int i = 0; i < d.ad_except.size(); i++) {
                int temp = d.ad_except.get(i);
                this.adExcId.add(temp);
            }

            System.out.println("Exception LIST");
            System.out.println("==============");
            for (int i = 0; i < this.adExcId.size(); i++) {
                System.out.println(this.adExcId.get(i));
            }

            Connection con = DBConnector.getCon();
            if (con == null) {
                out.println("{\"code\": 999, \"data\": \"Failed to connect to DB\"}");
                out.close();
                return;
            }

            ResultSet adResult;
            String adFetchSql;
            PreparedStatement prepAdFetch;

            // preparing the Ad Fetch Query
            if (this.adExcId.isEmpty()) {
                adFetchSql = "select a.adid, a.uid, a.cid, a.city_id, c.city_name, c.city_state, a.title, a.price, date(a.timestamp) as tarikh from ads as a inner join cities as c on c.city_id=a.city_id inner join adstatus as adst on a.adid=adst.adid WHERE adst.status=1 ORDER BY a.timestamp DESC limit ?";
                prepAdFetch = con.prepareStatement(adFetchSql);
                prepAdFetch.setInt(1, Integer.parseInt(this.maxAdCount));
                adResult = prepAdFetch.executeQuery();
            } else {
                adFetchSql = "select a.adid, a.uid, a.cid, a.city_id, c.city_name, c.city_state, a.title, a.price, date(a.timestamp) as tarikh from ads as a inner join cities as c on c.city_id=a.city_id inner join adstatus as adst on a.adid=adst.adid where adst.status=1 AND a.adid NOT IN(?) ORDER BY a.timestamp DESC limit ?";
                adFetchSql = convert(adFetchSql, this.adExcId.size());
                prepAdFetch = con.prepareStatement(adFetchSql);
                /*  
                    *******************
                    Fantastic way to do IN(?) queries. Using java.sql.Array in createArrayOf method. However, my JDBC Driver version don't support it :(
                    Integer[] excArrTemp = this.adExcId.toArray(new
                    Integer[this.adExcId.size()]);
                    java.sql.Array excArr = con.createArrayOf("INTEGER", excArrTemp); 
                    *******************
                */
                for (int i = 1; i <= this.adExcId.size(); i++) {
                    prepAdFetch.setInt(i, this.adExcId.get(i - 1));
                }
                prepAdFetch.setInt(this.adExcId.size() + 1, Integer.parseInt(this.maxAdCount));
                // System.out.println("QUERY >> " + prepAdFetch); // _DEBUG
                adResult = prepAdFetch.executeQuery();
            }

            AdJsonHelper ajh = new AdJsonHelper();
            ajh.ad_list = new ArrayList<Ad>();
            while (adResult.next()) {
                Ad exAd = new Ad();
                exAd.ad_id = adResult.getString("a.adid");
                exAd.ad_poster_id = adResult.getString("a.uid");
                exAd.ad_category_id = adResult.getString("a.cid");
                exAd.ad_title = adResult.getString("a.title");
                exAd.ad_price = adResult.getString("a.price");
                exAd.ad_date = adResult.getString("tarikh");
                exAd.ad_location_id = adResult.getString("a.city_id");
                exAd.ad_location_city = adResult.getString("c.city_name");
                exAd.ad_location_state = adResult.getString("c.city_state");
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
