/**
 * Author: S69935 
 * Document: SearchBookServlet.java
 */

package controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import dao.DBUtil;

@WebServlet("/controller/SearchBookServlet")
public class SearchBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        String year = request.getParameter("year");
        String isbn = request.getParameter("isbn");

        try {
            Connection con = DBUtil.initializeDatabase();
            String query = "SELECT * FROM books WHERE 1=1";
            if (title != null && !title.isEmpty()) {
                query += " AND title LIKE '%" + title + "%'";
            }
            if (author != null && !author.isEmpty()) {
                query += " AND author LIKE '%" + author + "%'";
            }
            if (genre != null && !genre.isEmpty()) {
                query += " AND genre LIKE '%" + genre + "%'";
            }
            if (year != null && !year.isEmpty()) {
                query += " AND publication_year = " + Integer.parseInt(year);
            }
            if (isbn != null && !isbn.isEmpty()) {
                query += " AND isbn LIKE '%" + isbn + "%'";
            }

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            out.println("<html><head>");
            out.println("<link rel='stylesheet' href='../css/searchStyle.css'>");
            out.println("<link rel='icon' type='image/png' href='" + request.getContextPath() + "/image/logo.png'>");
            out.println("</head><body>");

            out.println("<table border='1'><tr><th>No</th><th>Title</th><th>Author</th><th>Genre</th><th>Publication Year</th><th>ISBN</th><th>Status</th></tr>");

            boolean hasData = false;
            int counter = 1;  
            while (rs.next()) {
                hasData = true;
                out.println("<tr>");
                out.println("<td>" + counter + "</td>");  
                out.println("<td>" + rs.getString("title") + "</td>");
                out.println("<td>" + rs.getString("author") + "</td>");
                out.println("<td>" + rs.getString("genre") + "</td>");
                out.println("<td>" + rs.getInt("publication_year") + "</td>");
                out.println("<td>" + rs.getString("isbn") + "</td>");
                out.println("<td>" + rs.getString("status") + "</td>");
                out.println("</tr>");
                counter++;  
            }

            if (!hasData) {
                out.println("<tr><td colspan='7' style='text-align:center;'>No data found</td></tr>");
            }

            out.println("</table>");
            out.println("</body></html>");

            con.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }

        out.println("<br><div class='row'><a href='" + request.getContextPath() + "/listBooks.jsp'><input type='button' value='Back'></a></div>");
    }
}
