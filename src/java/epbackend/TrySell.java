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
@WebServlet(name = "TrySell", urlPatterns = {"/TrySell"})
public class TrySell extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();

            String tryEmail = request.getParameter("tryEmail");
            System.out.println(tryEmail);
            
            if (tryEmail.isEmpty()){
                out.println("{\"code\": 102, \"data\": \"No e-mail value received\"}");
                out.close();
                return;
            }
            
            Connection con = DBConnector.getCon();
            if (con == null) {
                out.println("{\"code\": 999, \"data\": \"Failed to connect to DB\"}");
                out.close();
                return;
            }
            
            String tryEmailSql = "select uid,uname,email from user where email=?";
            PreparedStatement prepSearchThisEmail = con.prepareStatement(tryEmailSql);
            prepSearchThisEmail.setString(1, tryEmail);
            ResultSet gotEmail = prepSearchThisEmail.executeQuery();

            if (gotEmail.next()) { // user exists but not logged in.
                String rUser = gotEmail.getString("uname");
                String rEmail = gotEmail.getString("email");
                String rUid = gotEmail.getString("uid");
                System.out.println("TRY SELL >> " + rEmail);
                out.println("{" +
                            "\"code\": 100," +
                            "\"data\": \"success\"," +
                            "\"username\": \"" + rUser + "\"," +
                            "\"email\": \"" + rEmail + "\"," +
                            "\"uid\": \"" + rUid + "\"" +
                            "}");
            } else { // new user, take him through signup routine
                out.println("{\"code\": 101, \"data\": \"new-user\"}");
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
            Logger.getLogger(TrySell.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(TrySell.class.getName()).log(Level.SEVERE, null, ex);
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
