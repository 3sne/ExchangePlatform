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
@WebServlet(name = "SignUp", urlPatterns = { "/signup" })
public class SignUp extends HttpServlet {

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
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String uname = request.getParameter("uname");
            System.out.println("[SignUp] "+ email + password + uname);

            // Input Validation Routine

            Connection con = DBConnector.getCon();
            if (con == null) {
                out.println("{\"code\": 999, \"data\": \"Failed to connect to DB\"}");
                out.close();
                return;
            }


            // Dupe uname check
            String isDuplicateSql = "select uname from user where uname=?";
            PreparedStatement isDuplicate = con.prepareStatement(isDuplicateSql);
            isDuplicate.setString(1, uname);
            ResultSet isDuplicateResult = isDuplicate.executeQuery();
            if (isDuplicateResult.next()) {
                out.println("{\"code\": 202, \"data\": \"Username occupied\"}");
                out.close();
                return;
            }
            
            // Dupe email check
            String isDupeEmailSql = "select email from user where email=?";
            PreparedStatement prepDupeEmail = con.prepareStatement(isDupeEmailSql);
            prepDupeEmail.setString(1, email);
            ResultSet prepDupeEmailResult = prepDupeEmail.executeQuery();
            if (prepDupeEmailResult.next()) {
                out.println("{\"code\": 203, \"data\": \"email occupied\"}");
                out.close();
                return;
            }

            // sign them up
            String signUpSql = "INSERT INTO user (email, uname, pword) VALUES (?, ?, ?)";
            PreparedStatement signUp = con.prepareStatement(signUpSql);
            signUp.setString(1, email);
            signUp.setString(2, uname);
            signUp.setString(3, password);
            int SignUpResult = signUp.executeUpdate();
            System.out.println("[SignUp] Rows Affected >> " + Integer.toString(SignUpResult));

            if (SignUpResult == 1) {
                
                
                String loginSql = "SELECT uid from user where email=? and pword=?";
                PreparedStatement prepLoginStmt = con.prepareStatement(loginSql);
                prepLoginStmt.setString(1, email);
                prepLoginStmt.setString(2, password);
                ResultSet resultLoginSuccess = prepLoginStmt.executeQuery();
                String uid;
                
                if (resultLoginSuccess.next()) {
                    uid = resultLoginSuccess.getString("uid");
                    HttpSession session = request.getSession();
                    session.setAttribute("currentUserName", uname);
                    session.setAttribute("currentUserId", uid);
                    session.setAttribute("currentUserEmail", email);
                    out.println("{\"code\": 100, \"data\": \"Sign up successful\", \"username\": \"" + uname+ "\"}");
                } else {
                    out.println("{\"code\": 997, \"data\": \"Server Error 1\"}");
                }
            } else { 
                out.println("{\"code\": 998, \"data\": \"Server Error 2\"}");
            }

            

        } catch (SQLException e) {
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
