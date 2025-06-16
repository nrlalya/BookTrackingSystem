<%-- 
    Author     : S69935
    Document   : editBook.jsp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.dao.DBUtil" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="logo.jsp"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Book</title>
        <link rel="stylesheet" href="css/editBookStyle.css">
        <script src="js/validate.js"></script>
    </head>
    <body>
        <%
            String success = request.getParameter("success");
            if ("true".equals(success)) {
        %>
        
        <div class="alert success">
            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
            <strong>Book updated successfully!</strong> 
        </div>
        
        <%
        } else if ("false".equals(success)) {
        %>
        
        <div class="alert fail">
            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
            <strong>Failed to update book. Please try again.</strong> 
        </div>
        
        <%
            }
        %>

        <%
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Connection con = DBUtil.initializeDatabase();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM books WHERE id=?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
        %>

        <h2>Edit Book</h2>
        <div class="container">
            <form method="post" action="controller/EditBookServlet" onsubmit="return validateForm()">
                <input type="hidden" name="id" value="<%= rs.getInt("id")%>">

                <div class="row">
                    <div class="formName"><label for="title">Title</label></div>
                    <div class="inputName"><input type="text" name="title" value="<%= rs.getString("title")%>" required></div>
                </div>

                <div class="row">
                    <div class="formName"><label for="author">Author</label></div>
                    <div class="inputName"><input type="text" name="author" value="<%= rs.getString("author")%>" required></div>
                </div>

                <div class="row">
                    <div class="formName"><label for="isbn">ISBN</label></div>
                    <div class="inputName"><input type="text" name="isbn" value="<%= rs.getString("isbn")%>" required></div>
                </div>

                <div class="row">
                    <div class="formName"><label for="genre">Genre</label></div>
                    <div class="inputName">
                        <select name="genre" id="genre" required>
                            <option value="" disabled <%= rs.getString("genre") == null ? "selected" : ""%>>Please select a genre</option>
                            <option value="Modern Fiction" <%= rs.getString("genre").equals("Modern Fiction") ? "selected" : ""%>>Modern Fiction</option>
                            <option value="Malay Literature" <%= rs.getString("genre").equals("Malay Literature") ? "selected" : ""%>>Malay Literature</option>
                            <option value="Islamic" <%= rs.getString("genre").equals("Islamic") ? "selected" : ""%>>Islamic</option>
                            <option value="Motivation" <%= rs.getString("genre").equals("Motivation") ? "selected" : ""%>>Motivation</option>
                            <option value="Fantasy" <%= rs.getString("genre").equals("Fantasy") ? "selected" : ""%>>Fantasy</option>
                            <option value="History" <%= rs.getString("genre").equals("History") ? "selected" : ""%>>History</option>
                            <option value="Biography" <%= rs.getString("genre").equals("Biography") ? "selected" : ""%>>Biography</option>
                            <option value="Romance" <%= rs.getString("genre").equals("Romance") ? "selected" : ""%>>Romance</option>
                            <option value="Psychology" <%= rs.getString("genre").equals("Psychology") ? "selected" : ""%>>Psychology</option>
                            <option value="Teen Novel" <%= rs.getString("genre").equals("Teen Novel") ? "selected" : ""%>>Teen Novel</option>
                            <option value="Short Story" <%= rs.getString("genre").equals("Short Story") ? "selected" : ""%>>Short Story</option>
                            <option value="Poetry" <%= rs.getString("genre").equals("Poetry") ? "selected" : ""%>>Poetry</option>
                            <option value="Science & Technology" <%= rs.getString("genre").equals("Science & Technology") ? "selected" : ""%>>Science & Technology</option>
                            <option value="Economics & Business" <%= rs.getString("genre").equals("Economics & Business") ? "selected" : ""%>>Economics & Business</option>
                            <option value="Health" <%= rs.getString("genre").equals("Health") ? "selected" : ""%>>Health</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="formName"><label for="year">Year</label></div>
                    <div class="inputName"><input type="number" name="publication_year" value="<%= rs.getInt("publication_year")%>" required></div>
                </div>

                <div class="row">
                    <div class="formName"><label for="status">Status</label></div>
                    <div class="inputName">
                        <select id="status" name="status" required>
                            <option value="" disabled <%= rs.getString("status") == null ? "selected" : ""%>>Please select a status</option>
                            <option value="Available" <%= rs.getString("status").equals("Available") ? "selected" : ""%>>Available</option>
                            <option value="Checked Out" <%= rs.getString("status").equals("Checked Out") ? "selected" : ""%>>Checked Out</option>
                        </select>
                    </div>
                </div>

                <br>

                <div class="row">
                    <input type="button" value="Back" onclick="window.location.href = 'listBooks.jsp'">
                    <input type="submit" value="Update Book">
                </div>
            </form>

            <%
                    } else {
                        out.println("<p>Book not found in the database.</p>");
                    }
                    con.close();
                } else {
                    out.println("<p>ID parameter not provided. Please access this page through the book list.</p>");
                }
            %>
        </div>

        <script>
            setTimeout(function () {
                var alert = document.querySelector('.alert');
                if (alert)
                    alert.style.display = 'none';
            }, 4000);
        </script>
    </body>
</html>
