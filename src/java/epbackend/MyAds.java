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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "MyAds", urlPatterns = {"/myAds"})
public class MyAds extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            PrintWriter out = response.getWriter();
            response.setContentType("application/json;charset=UTF-8");
        
        try{
            HttpSession session = request.getSession();    
            String cuname, cuid;
            if (session.getAttribute("currentUserName") != null && session.getAttribute("currentUserId") != null) {
                    cuname = session.getAttribute("currentUserName").toString();
                    cuid = session.getAttribute("currentUserId").toString();
////                request.getRequestDispatcher("myad.jsp").forward(request, response);
            } else { // boyo not login
                out.println("{\"code\": 201, \"data\": \"USER NOT LOGGED IN\"}");
                out.close();
                return;
            }
            
            Connection con = DBConnector.getCon();
            if (con == null) {
                out.println("{\"code\": 999, \"data\": \"Failed to connect to DB\"}");
                out.close();
                return;
            }
            
            Gson g = new Gson();
            // select a.adid, a.uid, a.cid, a.city_id, c.city_name, c.city_state, a.title, a.description, a.price, date(a.timestamp), adst.status as tarikh from ads as a inner join cities as c inner join adstatus as adst on c.city_id=a.city_id and a.adid=adst.adid where a.uid=26 
            String myAdSql = "select a.adid, a.uid, a.cid, a.city_id, c.city_name, c.city_state, a.title, a.description, a.price, date(a.timestamp) as tarikh, adst.status from ads as a inner join cities as c inner join adstatus as adst on c.city_id=a.city_id and a.adid=adst.adid where a.uid=?";
            PreparedStatement prepMyAds = con.prepareStatement(myAdSql);
            prepMyAds.setString(1, cuid);
            ResultSet fetchedAdTuples = prepMyAds.executeQuery();
            
            
            AdFetch.AdJsonHelper ajh = new AdFetch.AdJsonHelper();
            ajh.ad_list = new ArrayList<AdFetch.Ad>(); 
            while (fetchedAdTuples.next()) {
                AdFetch.Ad exAd = new AdFetch.Ad();
                exAd.ad_id = fetchedAdTuples.getString("a.adid");
                exAd.ad_poster_id = fetchedAdTuples.getString("a.uid");
                exAd.ad_category_id = fetchedAdTuples.getString("a.cid");
                exAd.ad_title = fetchedAdTuples.getString("a.title");
                exAd.ad_price = fetchedAdTuples.getString("a.price");
                exAd.ad_desc = fetchedAdTuples.getString("a.description");
                exAd.ad_date = fetchedAdTuples.getString("tarikh");
                exAd.ad_location_id = fetchedAdTuples.getString("a.city_id");
                exAd.ad_location_city = fetchedAdTuples.getString("c.city_name");
                exAd.ad_location_state = fetchedAdTuples.getString("c.city_state");
                exAd.ad_status = fetchedAdTuples.getString("adst.status");
                ajh.ad_list.add(exAd);
                System.out.println(exAd.ad_id);
            }
            
            if (ajh.ad_list.size() > 0) {
                ajh.code = 100;
            } else {
                ajh.code = 101;
            }
            String packedJsonString = g.toJson(ajh);
            out.println(packedJsonString);
            
        } catch (SQLException ex) {
            Logger.getLogger(MyAds.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
