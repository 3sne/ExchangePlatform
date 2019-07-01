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

/**
 *
 * @author fsociety
 */
@WebServlet(name = "Ad", urlPatterns = {"/ad"})
public class Ad extends HttpServlet {   
    
    class PostingZoomExport {
        String ad_id;
        String ad_poster_id;
        String ad_category_id;
        String ad_title;
        String ad_desc;
        String ad_price;
        String ad_location;
        String ad_poster_uname;
        boolean true_content;
    }
    
    class PostingZoomExportHelper {
        int code;
        PostingZoomExport mPze;
    
        PostingZoomExportHelper(int code, PostingZoomExport mPze) {
            this.code = code;
            this.mPze = mPze;
        }
        
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("application/json; charset=UTF-8");
        Gson g = new Gson();
        
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            String req_ad_id = request.getParameter("adid");
            
            Connection con = DBConnector.getCon();
            if (con == null) {
                System.out.println("something went wrong");
                out.println("something went wrong");
                out.close();
                return;
            }
            
            Statement adFetchQuery = con.createStatement();
            ResultSet adResult;
            System.out.println(req_ad_id);
            adResult = adFetchQuery.executeQuery("select * from ads,user where ads.adid=" + req_ad_id + " and ads.uid=user.uid");
            
            PostingZoomExport pze = new PostingZoomExport();
            if(adResult.next()){
                pze.ad_id = adResult.getString("adid");
                pze.ad_poster_id = adResult.getString("uid");
                pze.ad_poster_uname = adResult.getString("uname");
                pze.ad_category_id = adResult.getString("cid");
                pze.ad_title = adResult.getString("title");
                pze.ad_desc = adResult.getString("description");
                pze.ad_price = adResult.getString("price");
                pze.ad_location = adResult.getString("city_id");
                pze.true_content = true;
            } else {
                pze.true_content = false;
                System.out.println("[Ad] Missing Ad");
            }
            
            PostingZoomExportHelper pzeh;
            if (pze.true_content) {
                pzeh = new PostingZoomExportHelper(100, pze);
            } else {
                pzeh = new PostingZoomExportHelper(101, null);
            }
            
            String packedJsonString = g.toJson(pzeh);
            out.println(packedJsonString);
                    
//            String packedJsonString = g.toJson();
//            out.println(packedJsonString);
            
        } catch(SQLException e){
            System.out.println("====SQL GONE WRONG====");
            System.out.println(e);
        } finally {
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Ad.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Ad.class.getName()).log(Level.SEVERE, null, ex);
        }
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
