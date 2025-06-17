<%-- 
    Author     : S69935
    Document   : report.jsp
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, dao.DBUtil" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="logo.jsp"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/reportStyle.css">
        <title>Report Book</title>
    </head>
    <body>
        <h2>Report Book</h2>
        <form action="report.jsp" method="get" class="report-form-horizontal">
            <label for="reportType">Choose report type:</label>
            <select id="reportType" name="type" required>
                <option value="" disabled selected>Select report type</option>
                <option value="genre" <%= "genre".equals(request.getParameter("type")) ? "selected" : ""%>>By Genre</option>
                <option value="author" <%= "author".equals(request.getParameter("type")) ? "selected" : ""%>>By Author</option>
                <option value="year" <%= "year".equals(request.getParameter("type")) ? "selected" : ""%>>By Publication Year</option>
            </select>
            <button type="submit" class="btn submit-btn">Generate Report</button>
        </form>

        <%
            String type = request.getParameter("type");
            if (type != null && !type.isEmpty()) {
                String groupByField = "";
                String title = "";

                switch (type) {
                    case "genre":
                        groupByField = "genre";
                        title = "Report: Number of Books by Genre";
                        break;
                    case "author":
                        groupByField = "author";
                        title = "Report: Number of Books by Author";
                        break;
                    case "year":
                        groupByField = "publication_year";
                        title = "Report: Number of Books by Publication Year";
                        break;
                    default:
                        out.println("<p>Invalid report type.</p>");
                        groupByField = null;
                        break;
                }

                if (groupByField != null) {
                    try {
                        Connection con = DBUtil.initializeDatabase();
                        String query = "SELECT " + groupByField + " AS label, COUNT(*) AS total FROM books GROUP BY " + groupByField + " ORDER BY UPPER(label) ASC";
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(query);

                        // Tentukan header kolom
                        String headerName = "";
                        if ("genre".equals(groupByField)) {
                            headerName = "Genre";
                        } else if ("author".equals(groupByField)) {
                            headerName = "Author";
                        } else if ("publication_year".equals(groupByField)) {
                            headerName = "Publication Year";
                        } else {
                            headerName = groupByField;
                        }

                        out.println("<h3>" + title + "</h3>");
                        out.println("<table border='1'>");
                        out.println("<tr><th>" + headerName + "</th><th>Total Books</th></tr>");

                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("label") + "</td>");
                            out.println("<td>" + rs.getInt("total") + "</td>");
                            out.println("</tr>");
                        }

                        out.println("</table>");

                        con.close();
                    } catch (Exception e) {
                        out.println("<p>Error generating report: " + e.getMessage() + "</p>");
                    }
                }
            }
        %>

        <br>
        <div class="button-float-group">
            <a href="listBooks.jsp" class="btn back">Back</a>
        </div>

    </body>
</html>
