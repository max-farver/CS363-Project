<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Food Web App for Demo</title>
</head>
<body>
	<!-- any error is redirected to ShowError.jsp -->
	<%@ page errorPage="ShowError.jsp"%>
	<!-- include all the database connection configurations -->
	<%@ include file="./DBInfo.jsp"%>
	
	<%!
		public boolean isValidK(String k) {
			boolean temp = true;
			if (Math.abs(Integer.parseInt(k)) > 100) {
				temp = false;
			}
			return temp;
		}
		/*public boolean isValidMonth(String month) {
			boolean temp = true;
			if (Integer.parseInt(month) > 12 || Integer.parseInt(month) < 1) {
				temp = false;
			}
			return temp;
		}
		
		public boolean isValidYear(String year) {
			boolean temp = true;
			if (Integer.parseInt(year) > 2019 || Integer.parseInt(year) < 1990) {
				temp = false;
			}
			return temp;
		}
		
		public boolean isValidSubCategory(String cat) {
			boolean temp = true;
			if (!cat.equals("GOP") || !cat.equals("democrat") || !cat.equals("na")) {
				temp = false;
			}
			return temp;
		}
		
		public boolean isValidCategory(){
			
		}
		
		public boolean isValidState(String state) {
			boolean temp = true;
			//TODO
			return temp;
		} 
		
		public boolean isValidStateList(String[] stateList) {
			boolean temp = true;
			//TODO
			return temp;
		}*/
		
		
	%>
	<%
		
		String question = request.getParameter("question_selector");
		String param1 = request.getParameter("user_input_1");
		String param2 = request.getParameter("user_input_2");
		String param3 = request.getParameter("user_input_3");
		String param4 = request.getParameter("user_input_4");
		String param5 = request.getParameter("user_input_5");
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
		
		switch (question) {
			case "Q1":
				//call 1
				break;
			case "Q3":
				//call 3
				break;
			case "Q6":
				//call 6
				break;
			case "Q9":
				//call 9
				break;
			case "Q10":
				//call 10()
				break;
			case "Q11":
				//call 11()
				break;
			case "Q15":
				// call 15()
				break;
			case "Q18":
				// call 18()
				break;
			case "Q23":
				//call Q23()
				break;
			case "Insert":
				// call insert()
				break;
			case "Delete":
				// call delete()
				break;
		}
		
		// HERE ##########################################

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
				
		String sqlQuery = "select f.FNAME from food f where f.FID = ?";
		
		stmt = conn.prepareStatement(sqlQuery);
		
		// request.getParameter() always return string type or null if not exists
		
		stmt.setInt(1,Integer.parseInt(request.getParameter("question_selector")));
		
		rs = stmt.executeQuery();
		while (rs.next()) {
			out.println("<h3>Here's the recipe of " + rs.getString("FNAME") + ":</h3>");
		}
		out.println("<br/>");
		
		sqlQuery = "select i.INAME, r.AMOUNT from food f inner join recipe r on r.FID = f.FID inner join ingredient i on i.IID = r.IID where f.FID = ?";
		
		stmt = conn.prepareStatement(sqlQuery);
		stmt.clearParameters();
		
		
		stmt.setString(1, request.getParameter("food_selector"));
		
		rs = stmt.executeQuery();
		out.println("<table><tr><th>Ingredient</th><th>Amount</th></tr>");
		while (rs.next()) {
			out.println("<tr>");
			out.println("<td>" + rs.getString("INAME") + "</td>");
			out.println("<td>" + rs.getString("AMOUNT") + "</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		
		// TO HERE #############################
		// needs to be in the switch
		
		rs.close();
		stmt.close();
		conn.close();
	%>
	<br />
	<form action="Index.jsp">
		<input type="submit" value="BACK" />
	</form>
</body>
</html>