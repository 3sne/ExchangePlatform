/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package epbackend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
@WebServlet(name = "CreateNewAd", urlPatterns = {"/createNewAd"})
public class CreateNewAd extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            String cuname = session.getAttribute("currentUserName").toString();
            String cuid = session.getAttribute("currentUserId").toString();
            System.out.println(cuname + " " + cuid);
            if (cuname == "" || cuid == "") {
                out.println("{\"code\": 201, \"data\": \"USER NOT LOGGED IN\"}");
            }

            String atitle = request.getParameter("adtitle");
            String adesc = request.getParameter("addesc");
            String aprice = request.getParameter("adprice");
            String acat = request.getParameter("adcat");
            String alocid = request.getParameter("adlocid");
            String aphone = request.getParameter("adphone");
            
            // dothis: input sanitization
            System.out.println(atitle + " \n" + adesc+ " \n" +aprice+ " \n" +acat+ " \n" +alocid + " \n" + aphone);

            Connection con = DBConnector.getCon();
            if (con == null) {
                out.println("{\"code\": 999, \"data\": \"Failed to connect to DB\"}");
                out.close();
                return;
            }
            
            String injAdSql = "INSERT INTO ads (uid, cid, city_id, title, description, price, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement injAd = con.prepareStatement(injAdSql);
            injAd.setString(1, cuid);
            injAd.setString(2, acat);
            injAd.setString(3, alocid);
            injAd.setString(4, atitle);
            injAd.setString(5, adesc);
            injAd.setString(6, aprice);
            injAd.setString(7, aphone);
            int injAdResult = injAd.executeUpdate();
            System.out.println("[injAd] Rows Affected >> " + Integer.toString(injAdResult));

            if (injAdResult == 1) {
                out.println("{\"code\": 100, \"data\": \"Ad creation successful\"}");
            } else { 
                out.println("{\"code\": 998, \"data\": \"Server Error\"}");
            }
            
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
            Logger.getLogger(CreateNewAd.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CreateNewAd.class.getName()).log(Level.SEVERE, null, ex);
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
