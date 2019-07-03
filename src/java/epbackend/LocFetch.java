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
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author fsociety
 */
@WebServlet(name = "LocFetch", urlPatterns = {"/locfetch"})
public class LocFetch extends HttpServlet {

    class City {
        String cityName;
        String cityId;
    }

    class CityList {
        ArrayList<City> cityList;
        int code;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String ss = request.getParameter("selectedState");
                            System.out.println(ss);

            
            if(ss.isEmpty()) {
                out.println("{\"code\": 201, \"data\": \"Empty state param\"}");
                out.close();
                return;
            }   
           
            Gson g = new Gson();
            Connection con = DBConnector.getCon();
            if (con == null) {
                out.println("{\"code\": 999, \"data\": \"Failed to connect to DB\"}");
                out.close();
                return;
            }
            
            String citySql = "SELECT city_id, city_name from cities where city_state=?";
            PreparedStatement prepCity = con.prepareStatement(citySql);
            prepCity.setString(1, ss);
            ResultSet gotCity;

            gotCity = prepCity.executeQuery();

            CityList cl = new CityList();
            cl.cityList = new ArrayList<City>(); 
            while(gotCity.next()) {
                City c = new City();
                c.cityId = gotCity.getString("city_id");
                c.cityName = gotCity.getString("city_name");
//                System.out.println(gotCity.getString("city_id"));
//                System.out.println(gotCity.getString("city_name"));
                cl.cityList.add(c);
            }

            if (cl.cityList.size() > 0) {
                cl.code = 100;
                System.out.println("[LocFetch] Success");
            } else {
                cl.code = 101;
                System.out.println("[LocFetch] Failure");
            }

            String packedJsonString = g.toJson(cl);
            out.println(packedJsonString);
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
            Logger.getLogger(LocFetch.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(LocFetch.class.getName()).log(Level.SEVERE, null, ex);
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
