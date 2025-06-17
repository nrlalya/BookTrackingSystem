/**
 * Author: S69935 
 * Document: AddBookServlet.java
 */

package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import dao.DBUtil;

public class AddBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection con = DBUtil.initializeDatabase();

            String sql = "INSERT INTO books (title, author, isbn, genre, publication_year, status, rating) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, request.getParameter("title"));
            st.setString(2, request.getParameter("author"));
            st.setString(3, request.getParameter("isbn"));
            st.setString(4, request.getParameter("genre"));
            st.setInt(5, Integer.parseInt(request.getParameter("publication_year")));
            st.setString(6, request.getParameter("status"));
            st.setString(7, request.getParameter("rating"));

            st.executeUpdate();
            st.close();
            con.close();

            response.sendRedirect("listBooks.jsp?added=true");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
