/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package epbackend;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author fsociety
 */
@WebServlet(name = "Search", urlPatterns = { "/search" })
public class Search extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            HttpSession session = request.getSession();

            String q = request.getParameter("q");
            q = q.trim();
            session.setAttribute("searchQuery", q);
            System.out.println("[SEARCH] query >> " + q);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/search.jsp");
            dispatcher.forward(request, response);

        } finally {
            out.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            Gson g = new Gson();
            String query = request.getParameter("q");
            query = "%" + query.toLowerCase() + "%";
//            query = query.replace("!", "!!").replace("%", "!%").replace("_", "!_").replace("[", "![");

            Connection con = DBConnector.getCon();
            if (con == null) {
                out.println("{\"code\": 999, \"data\": \"Failed to connect to DB\"}");
                out.close();
                return;
            }

            String searchSql = "select a.adid, a.uid, a.cid, a.city_id, c.city_name, c.city_state, a.title, a.price, date(a.timestamp) as tarikh from ads as a INNER JOIN cities as c on c.city_id=a.city_id where lower(title) like ? or lower(description) like ? or lower(city_name) like ? or lower(city_state) like ? ESCAPE '!'";
            PreparedStatement prepSearch = con.prepareStatement(searchSql);
            prepSearch.setString(1, query);
            prepSearch.setString(2, query);
            prepSearch.setString(3, query);
            prepSearch.setString(4, query);
            System.out.println(prepSearch);
            ResultSet rs = prepSearch.executeQuery();

            AdFetch.AdJsonHelper ajh = new AdFetch.AdJsonHelper();
            ajh.ad_list = new ArrayList<AdFetch.Ad>();
            while (rs.next()) {
                AdFetch.Ad exAd = new AdFetch.Ad();
                exAd.ad_id = rs.getString("a.adid");
                exAd.ad_poster_id = rs.getString("a.uid");
                exAd.ad_category_id = rs.getString("a.cid");
                exAd.ad_title = rs.getString("a.title");
                exAd.ad_price = rs.getString("a.price");
                exAd.ad_date = rs.getString("tarikh");
                exAd.ad_location_id = rs.getString("a.city_id");
                exAd.ad_location_city = rs.getString("c.city_name");
                exAd.ad_location_state = rs.getString("c.city_state");
                ajh.ad_list.add(exAd);
            }

            if (ajh.ad_list.size() > 0) {
                ajh.code = 100;
            } else {
                ajh.code = 101;
            }

            String packedJsonString = g.toJson(ajh);
            out.println(packedJsonString);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            out.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
