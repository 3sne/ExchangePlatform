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
@WebServlet(name = "AdEdit", urlPatterns = { "/adEdit" })
public class AdEdit extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            String cuname, cuid;
            if (session.getAttribute("currentUserName") != null && session.getAttribute("currentUserId") != null) {
                cuname = session.getAttribute("currentUserName").toString();
                cuid = session.getAttribute("currentUserId").toString();
            } else { // boyo not login
                out.println("{\"code\": 201, \"data\": \"USER NOT LOGGED IN\"}");
                out.close();
                return;
            }
            String action = request.getParameter("sig");
            String posting_id = request.getParameter("postingId");
            String posting_cat = request.getParameter("postingCat");
            String poster_id = request.getParameter("posterId");

            System.out.println(cuid + "VS" + poster_id);

            if (!cuid.equals(poster_id)) {
                out.println("{\"code\": 202, \"data\": \"CAN'T VERIFY CURRENT USER\"}");
                out.close();
                return;
            }

            Connection con = DBConnector.getCon();
            if (con == null) {
                out.println("{\"code\": 999, \"data\" \"Failed to connect to DB\"}");
                out.close();
                return;
            }

            int ra;
            if (action.equals("MAS")) { // Mark as Sold

                String delSql = "UPDATE adstatus SET status=? WHERE adid=?";
                PreparedStatement prepDel = con.prepareStatement(delSql);
                prepDel.setInt(1, 0);
                prepDel.setString(2, posting_id);
                ra = prepDel.executeUpdate();
                System.out.println("[MAS] Rows Affected >> " + Integer.toString(ra));

            } else if (action.equals("DEL")) { // Delete Posting

                String delSql = "DELETE FROM ads WHERE adid=? and uid=?";
                PreparedStatement prepDel = con.prepareStatement(delSql);
                prepDel.setString(1, posting_id);
                prepDel.setString(2, poster_id);
                ra = prepDel.executeUpdate();
                System.out.println("[DEL] Rows Affected >> " + Integer.toString(ra));

            } else {
                out.println("{\"code\": 203, \"data\": \"REQUEST INTENT UNCLEAR\"}");
                out.close();
                return;
            }

            if (ra == 1) {
                out.println("{\"code\": 100, \"data\": \"Operation Complete\"}");
            } else if (ra > 1) {
                out.println("{\"code\": 101, \"data\": \"MULTIPLE ENTRIES DELETED, NOT GOOD\"}");
            } else {
                out.println("{\"code\": 102, \"data\": \"Operation unsuccessful.\"}");
            }

        } catch (SQLException e) {
            System.out.println("====SQL ERROR====");
            out.println("{\"code\": 998, \"data\": \"DB barfed\"}");
            e.printStackTrace();
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
