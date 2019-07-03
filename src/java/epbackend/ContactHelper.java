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
@WebServlet(name = "ContactHelper", urlPatterns = { "/contactHelper" })
public class ContactHelper extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            String cuname, cuid;
            if (session.getAttribute("currentUserName") != null) {
                cuname = session.getAttribute("currentUserName").toString();
                cuid = session.getAttribute("currentUserId").toString();
            } else { // boyo not login
                out.println("{\"code\": 201, \"data\": \"USER NOT LOGGED IN\"}");
                out.close();
                return;
            }

            System.out.println("[ContactHelper] GOT > " + cuname + " " + cuid);//
            String concernedAdId = request.getParameter("forAdId");
            String requestedBy = request.getParameter("forUserBrowsing");

            Connection con = DBConnector.getCon();
            if (con == null) {
                out.println("{\"code\": 999, \"data\": \"Failed to connect to DB\"}");
                out.close();
                return;
            }

            String contactGetSql = "SELECT phone as contactNumber from ads where adid=?";
            PreparedStatement prepCG = con.prepareStatement(contactGetSql);
            prepCG.setString(1, concernedAdId);
            ResultSet gotContact = prepCG.executeQuery();

            if (gotContact.next()) {
                String contactNumber = gotContact.getString("contactNumber");
                out.println("{\"code\": 100, \"data\": \"YASS\", \"contactNumber\": \""+ contactNumber+ "\"}");
            } else {
                out.println("{\"code\": 101, \"data\": \"No contact found, something is not right :L\"}");
            }

        } catch (SQLException e) {
            System.out.println("[ContactHelper] oopsie :(");
            out.println("{\"code\": 999, \"data\": \"DB Barfed\"}");
            e.printStackTrace();
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
