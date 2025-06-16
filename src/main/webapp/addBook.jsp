<%-- 
    Author     : S69935
    Document   : addBook.jsp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="logo.jsp"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/addBookStyle.css">
        <script src="../js/validate.js"></script>
        <title>Add New Book</title>
    </head>
    <body>
        <h2>Add New Book</h2>
        <div class="container">
            <form method="post" action="AddBookServlet" onsubmit="return validateForm()">
                <div class="row">
                    <div class="formName"><label for="title">Title</label></div>
                    <div class="inputName"><input type="text" name="title" required></div>
                </div>

                <div class="row">
                    <div class="formName"><label for="author">Author</label></div>
                    <div class="inputName"><input type="text" name="author" required></div>
                </div>

                <div class="row">
                    <div class="formName"><label for="genre">Genre</label></div>
                    <div class="inputName">
                        <select name="genre" id="genre" required>
                            <option value="" disabled selected>Please select a genre</option>
                            <option value="Modern Fiction">Modern Fiction</option>
                            <option value="Malay Literature">Malay Literature</option>
                            <option value="Islamic">Islamic</option>
                            <option value="Motivation">Motivation</option>
                            <option value="Fantasy">Fantasy</option>
                            <option value="History">History</option>
                            <option value="Biography">Biography</option>
                            <option value="Romance">Romance</option>
                            <option value="Psychology">Psychology</option>
                            <option value="Teen Novel">Teen Novel</option>
                            <option value="Short Story">Short Story</option>
                            <option value="Poetry">Poetry</option>
                            <option value="Science & Technology">Science & Technology</option>
                            <option value="Economics & Business">Economics & Business</option>
                            <option value="Health">Health</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="formName"><label for="isbn">ISBN</label></div>
                    <div class="inputName"><input type="text" name="isbn" required></div>
                </div>

                <div class="row">
                    <div class="formName"><label for="year">Publication Year</label></div>
                    <div class="inputName"><input type="number" name="publication_year" required></div>
                </div>

                <div class="row">
                    <div class="formName"><label for="year">Rating</label></div>
                    <div class="inputName"><input type="number" name="rating" step="0.1" min="0" max="5" required></div>
                </div>

                <div class="row">
                    <div class="formName"><label for="status">Status</label></div>
                    <div class="inputName">
                        <select id="status" name="status">
                            <option value="" disabled selected>Please select a status</option>
                            <option value="available">Available</option>
                            <option value="checkedOut">Checked Out</option>
                        </select>
                    </div>
                </div>

                <br>
                <div class="row">
                    <input type="button" value="Back" onclick="window.location.href = 'listBooks.jsp'">
                    <input type="submit" value="Add Book">
                </div>
            </form>
        </div>
    </body>
</html>
