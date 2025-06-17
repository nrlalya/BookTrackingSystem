/**
 * Author: S69935 
 * Document: EditdBookServlet.java
 */

package java.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import dao.DBUtil;
import javax.servlet.annotation.WebServlet;

@WebServlet("/controller/EditBookServlet")
public class EditBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection con = DBUtil.initializeDatabase();

            String sql = "UPDATE books SET title=?, author=?, isbn=?, genre=?, publication_year=?, status=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("title"));
            ps.setString(2, request.getParameter("author"));
            ps.setString(3, request.getParameter("isbn"));
            ps.setString(4, request.getParameter("genre"));
            ps.setInt(5, Integer.parseInt(request.getParameter("publication_year")));
            ps.setString(6, request.getParameter("status"));
            int id = Integer.parseInt(request.getParameter("id"));
            ps.setInt(7, id);

            ps.executeUpdate();
            ps.close();
            con.close();

            response.sendRedirect(request.getContextPath() + "/editBook.jsp?id=" + request.getParameter("id") + "&success=true");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
