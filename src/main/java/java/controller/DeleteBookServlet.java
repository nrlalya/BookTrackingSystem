/**
 * Author: S69935 
 * Document: DeleteBookServlet.java
 */

package java.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import dao.DBUtil;

public class DeleteBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Connection con = DBUtil.initializeDatabase();

            PreparedStatement ps = con.prepareStatement("DELETE FROM books WHERE id=?");
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();

            ps.close();
            con.close();

            if (rowsAffected > 0) {
                response.sendRedirect("listBooks.jsp?success=true");
            } else {
                response.sendRedirect("listBooks.jsp?success=false");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("listBooks.jsp?success=false");
        }
    }

}
