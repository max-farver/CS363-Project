<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<title>Food Web App for Demo</title>
</head>
<body>
	<h3>Select the food to view its recipe:</h3>
	<%@ include file="./DBInfo.jsp"%>
	<%-- <%
		Connection conn =null;
		Statement stmt =null;
		ResultSet rs =null;

		// Java way for handling an error using try catch
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			stmt = conn.createStatement();
			// show example how to use Statement object for static SQL statements
			String sqlQuery = "SELECT f.FID, f.FNAME FROM food f";
			rs = stmt.executeQuery(sqlQuery);
	%> --%>
			<!-- the form method can be get or post
				but post does not let anyone see the parameter values that are passed between pages
				Use post for sensitive information
			-->
			<form method="post" action="ShowResult.jsp">
			<select name="question_selector">
				<option value="Q1">Q1</option>
				<option value="Q3">Q3</option>
				<option value="Q6">Q6</option>
				<option value="Q9">Q9</option>
				<option value="Q10">Q10</option>
				<option value="Q11">Q11</option>
				<option value="Q15">Q15</option>
				<option value="Q18">Q18</option>
				<option value="Q23">Q23</option>
			</select>
			<p></p>
			<input type="submit" value="GO">
			</form>
	<%-- <%
			
		} catch (SQLException e) {
			out.println("An exception occurred: " + e.getMessage());
		} finally {
			if (rs!= null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn != null) conn.close();
		}
	%> --%>
</body>
</html>