<%-- 
    Author     : S69935
    Document   : listBooks.jsp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, dao.DBUtil" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="logo.jsp"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/listBookStyle.css">
        <title>List Book</title>
    </head>
    <body>
        <script>
            window.onload = function () {
                setTimeout(function () {
                    var alertBox = document.querySelector('.alert');
                    if (alertBox) {
                        alertBox.style.display = 'none';

                        if (window.history.replaceState) {
                            var cleanUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
                            window.history.replaceState({}, document.title, cleanUrl);
                        }
                    }
                }, 4000);
            };
        </script>

        <%
            String success = request.getParameter("success");
            if ("true".equals(success)) {
        %>
        
        <div class="alert success">
            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
            <strong>Delete successfully!</strong> 
        </div>
        
        <%
        } else if ("false".equals(success)) {
        %>
        
        <div class="alert fail">
            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
            <strong>Failed to delete book. Please try again.</strong> 
        </div>
        
        <%
            }
        %>

        <%
            String added = request.getParameter("added");
            if ("true".equals(added)) {
        %>
        
        <div class="alert success">
            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
            <strong>Add Book Successfully!</strong> 
        </div>
        
        <%
            }
        %>

        <h2>List Book</h2>

        <!-- Searching -->
        <div class="searching">
            <form method="get" action="controller/SearchBookServlet" >
                <input placeholder="Title" type="text" name="title" value="<%= request.getParameter("title") != null ? request.getParameter("title") : ""%>" >
                <input placeholder="Author" type="text" name="author" value="<%= request.getParameter("author") != null ? request.getParameter("author") : ""%>">

                <select name="genre" >
                    <option value="" disabled <%= (request.getParameter("genre") == null || request.getParameter("genre").isEmpty()) ? "selected" : ""%>>Genre</option>
                    <option value="Modern Fiction" <%= "Modern Fiction".equals(request.getParameter("genre")) ? "selected" : ""%>>Modern Fiction</option>
                    <option value="Malay Literature" <%= "Malay Literature".equals(request.getParameter("genre")) ? "selected" : ""%>>Malay Literature</option>
                    <option value="Islamic" <%= "Islamic".equals(request.getParameter("genre")) ? "selected" : ""%>>Islamic</option>
                    <option value="Motivation" <%= "Motivation".equals(request.getParameter("genre")) ? "selected" : ""%>>Motivation</option>
                    <option value="Fantasy" <%= "Fantasy".equals(request.getParameter("genre")) ? "selected" : ""%>>Fantasy</option>
                    <option value="History" <%= "History".equals(request.getParameter("genre")) ? "selected" : ""%>>History</option>
                    <option value="Biography" <%= "Biography".equals(request.getParameter("genre")) ? "selected" : ""%>>Biography</option>
                    <option value="Romance" <%= "Romance".equals(request.getParameter("genre")) ? "selected" : ""%>>Romance</option>
                    <option value="Psychology" <%= "Psychology".equals(request.getParameter("genre")) ? "selected" : ""%>>Psychology</option>
                    <option value="Teen Novel" <%= "Teen Novel".equals(request.getParameter("genre")) ? "selected" : ""%>>Teen Novel</option>
                    <option value="Short Story" <%= "Short Story".equals(request.getParameter("genre")) ? "selected" : ""%>>Short Story</option>
                    <option value="Poetry" <%= "Poetry".equals(request.getParameter("genre")) ? "selected" : ""%>>Poetry</option>
                    <option value="Science & Technology" <%= "Science & Technology".equals(request.getParameter("genre")) ? "selected" : ""%>>Science & Technology</option>
                    <option value="Economics & Business" <%= "Economics & Business".equals(request.getParameter("genre")) ? "selected" : ""%>>Economics & Business</option>
                    <option value="Health" <%= "Health".equals(request.getParameter("genre")) ? "selected" : ""%>>Health</option>
                </select>

                <input placeholder="Year" type="number" name="year" value="<%= request.getParameter("year") != null ? request.getParameter("year") : ""%>">
                <input type="submit" value="Search">
            </form>
        </div>

        <table border="1">
            <tr>
                <th>No</th>
                <th>Title</th>
                <th>Author</th>
                <th>Genre</th>
                <th>Publication Year</th>
                <th>Action</th>

            </tr>
            
            <%
                Connection con = DBUtil.initializeDatabase();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM books");
                int no = 1;  // Start numbering from 1
                while (rs.next()) {
            %>
            
            <tr>
                <td><%= no%></td> <!-- List of number display -->
                <td><%= rs.getString("title")%></td>
                <td><%= rs.getString("author")%></td>
                <td><%= rs.getString("genre")%></td>
                <td><%= rs.getInt("publication_year")%></td>
                <td>
                    <a href="editBook.jsp?id=<%= rs.getInt("id")%>">Edit</a> |
                    <a href="#" class="delete-link" onclick="confirmDelete('DeleteBookServlet?id=<%= rs.getInt("id")%>')">Delete</a>
                </td>
            </tr>
            
            <%
                    no++;  // Add number
                }
                con.close();
            %>
        </table>

        <br>
        <div class="button-float-group">
            <a href="addBook.jsp" class="btn">Add New Book</a>
            <a href="report.jsp" class="btn">Report Book</a>
            <a href="index.html" class="btn back">Back</a>
        </div>

        <!-- Alert Box Message - Delete -->
        <div id="confirmModal" class="modal">
            <div class="modal-content">
                <p id="confirmMessage">Are you sure you want to delete this book?</p>
                <div class="modal-buttons">
                    <button onclick="proceedDelete()" class="btn-confirm">Yes</button>
                    <button onclick="closeModal()" class="btn-cancel">No</button>
                </div>
            </div>
        </div>

        <script>
            let deleteUrl = "";

            function confirmDelete(url) {
                deleteUrl = url;
                document.getElementById('confirmModal').style.display = 'block';
            }

            function closeModal() {
                document.getElementById('confirmModal').style.display = 'none';
                deleteUrl = "";
            }

            function proceedDelete() {
                window.location.href = deleteUrl;
            }
        </script>

        <script>
            setTimeout(function () {
                var alert = document.querySelector('.alert');
                if (alert)
                    alert.style.display = 'none';
            }, 4000);
        </script>
    </body>
</html>
