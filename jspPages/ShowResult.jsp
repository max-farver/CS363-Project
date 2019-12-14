<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<head>
<meta name="author" content="Maxwell Farver | Tim Potter | Brett Bethke">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
	td, th {
		border: 1px solid black;
	}
</style>
<title>Food Web App for Demo</title>
</head>

<body>
	<!-- include all the database connection configurations -->
	<%@ include file="./DBInfo.jsp"%>
	<%
		// get parameters for login
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		// get parameters and question number for queries
		String question = request.getParameter("question_selector");
		String param1 = request.getParameter("user_input_1");
		String param2 = request.getParameter("user_input_2");
		String param3 = request.getParameter("user_input_3");
		String param4 = request.getParameter("user_input_4");
		String param5 = request.getParameter("user_input_5");
		String param6 = request.getParameter("user_input_6");
		String param7 = request.getParameter("user_input_7");
		
		boolean update = false;
		String[] stateList;
		String[] hashtagList;
		String[] monthList;
		
		String privilege="";
		
		Connection conn=null;
		PreparedStatement stmt = null;
		CallableStatement callStmt = null;
		ResultSet rs=null;
		String query = "";
		boolean isQuery = false;

		// initialize connection
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
		
		query = "SELECT privilege FROM appuser where name = ? and pwd = sha1(?);";
		
		stmt = conn.prepareStatement(query);
		stmt.setString(1, username);
		stmt.setString(2, password);
		
		rs = stmt.executeQuery();
		if (rs.next()) {
			
			privilege = rs.getString("Privilege");
			System.out.println(privilege);
		}
		rs.close();
		stmt.close();
		stmt = null;
		rs = null;
		
		// used for validation
		boolean allow = true;
		
		// only execute chosen question, case corresponds to question number
		// each on first checks privilege and sets 'allow' accordingly
		switch (question) {
			case "Q1":
				if (privilege.equals("all") || privilege == "readonly"){
					callStmt = conn.prepareCall("{call Q1(?, ?, ?)}");
					callStmt.setInt(1, Integer.parseInt(param1));
					callStmt.setInt(2, Integer.parseInt(param2));
					callStmt.setInt(3, Integer.parseInt(param3));
					rs = callStmt.executeQuery();				
					break;
				} else {
					allow = false;
					out.println("Invalid login");
					break;
				}
			case "Q3":
				if (privilege.equals("all") || privilege.equals("readonly")){
					callStmt = conn.prepareCall("{call Q3(?, ?)}");
					callStmt.setInt(1, Integer.parseInt(param1));
					callStmt.setInt(2, Integer.parseInt(param2));
					rs = callStmt.executeQuery();
					
					break;
				} else {
					allow = false;
					out.println("Invalid login");
					break;
				}
			case "Q6":
				if (privilege.equals("all") || privilege.equals("readonly")){
					isQuery = true;
					hashtagList = param2.split(" ");
					query = "select distinct u.screen_name, u.ofstate " +
							"from user u inner join tweets on tweets.posting_user = u.screen_name " +
							"inner join tagged on tagged.tid = tweets.tid " +
							"where tagged.hashtagname like ? ";
					
					for (int i = 1; i < hashtagList.length; i++) {
						query = query + "or tagged.hashtagname like ?";
					}
				
					
							
					query = query + "order by u.numFollowers desc " +
							"limit ?;";
							
					stmt = conn.prepareStatement(query); 
					for (int i = 0; i < hashtagList.length; i++) {
						stmt.setString(i+1,"%" + hashtagList[i] + "%");
						
					}
					
					
					stmt.setInt(hashtagList.length + 1, Integer.parseInt(param1));
					
					rs = stmt.executeQuery(); 
					
					break;
				} else {
					allow = false;
					out.println("Invalid login");
					break;
				}
			case "Q9":
				if (privilege.equals("all") || privilege.equals("readonly")){
					String secondParam9 = param2.split(" ")[0];
					callStmt = conn.prepareCall("call Q9(?,?)");
					callStmt.setInt(1, Integer.parseInt(param1));
					callStmt.setString(2, secondParam9);
					rs = callStmt.executeQuery();
					break;
				} else {
					allow = false;
					out.println("Invalid login");
					break;
				}
			case "Q10":
				if (privilege.equals("all") || privilege.equals("readonly")){
					isQuery = true;
					stateList = param1.split(" ");
					query = "select distinct tag.hashtagname, u.ofstate " +
							"from tagged tag, user u, tweets t " +
							"where tag.tid = t.tid and t.posting_user = u.screen_name and t.theMonth = ? and t.theYear = ? and " +
							"(u.ofstate like ?";
					
					for (int i = 1; i < stateList.length; i++) {
						query = query + "or u.ofstate like ?";
					}
				
					
							
					query = query + ");";
							
					stmt = conn.prepareStatement(query); 
					for (int i = 0; i < stateList.length; i++) {
						stmt.setString(i+3,"%" + stateList[i] + "%");
						
					}
					
					
					stmt.setInt(1, Integer.parseInt(param2));
					stmt.setInt(2, Integer.parseInt(param3));
					
					rs = stmt.executeQuery(); 
					
					break;
				} else {
					allow = false;
					out.println("Invalid login");
					break;
				}
			case "Q11":
				if (privilege.equals("all") || privilege.equals("readonly")){
					String secondParam11 = param2.split(" ")[0];
					String fifthParam11 = param2.split(" ")[0];
					callStmt = conn.prepareCall("{call Q11(?,?,?,?,?)}");
					callStmt.setInt(1, Integer.parseInt(param1));
					callStmt.setString(2, secondParam11);
					callStmt.setInt(3, Integer.parseInt(param3));
					callStmt.setInt(4, Integer.parseInt(param4));
					callStmt.setString(5, fifthParam11);
					rs = callStmt.executeQuery();
					break;
				} else {
					allow = false;
					out.println("Invalid login");
					break;
				}
			case "Q15":
				if (privilege.equals("all") || privilege.equals("readonly")){
					String firstParam15 = param1.split(" ")[0];
					callStmt = conn.prepareCall("{call Q15(?,?,?)}");
					callStmt.setString(1, firstParam15);
					callStmt.setInt(2, Integer.parseInt(param2));
					callStmt.setInt(3, Integer.parseInt(param3));
					rs = callStmt.executeQuery();
					break;
				} else {
					allow = false;
					out.println("Invalid login");
					break;
				}
			case "Q18":
				if (privilege.equals("all") || privilege.equals("readonly")){
					String secondParam18 = param2.split(" ")[0];
					callStmt = conn.prepareCall("{call Q18(?, ?, ?, ?)}");
					callStmt.setInt(1, Integer.parseInt(param1));
					callStmt.setString(2, secondParam18);
					callStmt.setInt(3, Integer.parseInt(param3));
					callStmt.setInt(4, Integer.parseInt(param4));
					rs = callStmt.executeQuery();
					break;
				} else {
					allow = false;
					out.println("Invalid login");
					break;
				}
			case "Q23":
				if (privilege.equals("all") || privilege.equals("readonly")){
					isQuery = true;
					monthList = param3.split(" ");
					query = "select tag.hashtagname, count(t.tid) as num_uses, t.theMonth " +
							"from tagged tag inner join tweets t on tag.tid = t.tid " +
							"inner join user u on t.posting_user = u.screen_name " +
							"where u.sub_category like ? and t.theYear = ? " +
							"and (t.theMonth = ? ";
					
					for (int i = 1; i < monthList.length; i++) {
						query = query + "or t.theMonth = ? ";
					}
							
					query = query + ") " +
							"group by tag.hashtagname " +
							"order by num_uses desc limit ?;";
							
					stmt = conn.prepareStatement(query); 
					for (int i = 0; i < monthList.length; i++) {
						stmt.setInt(i+3,Integer.parseInt(monthList[i]));
						
					}
					
					
					stmt.setInt(monthList.length + 3, Integer.parseInt(param1));
					stmt.setString(1, "%" + param2 + "%");
					stmt.setInt(2, Integer.parseInt(param4));
					
					rs = stmt.executeQuery(); 
					
					break;
				} else {
					allow = false;
					out.println("Invalid login");
					break;
				}
				
			// start of queries where only people with 'all' for their privilege level can execute
			case "Insert":
				if (privilege.equals("all")) {
					update = true;
					String firstParamIns = param1.split(" ")[0];
					String secondParamIns = param2.split(" ")[0];
					String thirdParamIns = param3.split(" ")[0];
					String fourthParamIns = param4.split(" ")[0];
					String fifthParamIns = param5.split(" ")[0];
					
					
					
					callStmt = conn.prepareCall("{call ins(?,?,?,?,?,?,?)}");
					
					callStmt.setString(1, firstParamIns);
					callStmt.setString(2, secondParamIns);
					callStmt.setString(3, thirdParamIns);
					callStmt.setString(4, fourthParamIns);
					callStmt.setString(5, fifthParamIns);
					callStmt.setInt(6, Integer.parseInt(param6));
					callStmt.setInt(7, Integer.parseInt(param7));
					callStmt.executeQuery();
					break;
				} else {
					allow = false;
					out.println("Invalid login or not high enough privilege");
					break;
				}
			case "Delete":
				if (privilege.equals("all")) {
					update = true;
					callStmt = conn.prepareCall("{call del(?)}");
					callStmt.setString(1, param1);
					callStmt.executeQuery();
					break;
				} else {
					allow = false;
					out.println("Invalid login or not high enough privilege");
					break;
				}
		}
		
		// show results if query was run
		if (allow) {
			// if query has return, print it, else state that it was run
			if (!update) {
				ResultSetMetaData metadata = rs.getMetaData();
			    int columnCount = metadata.getColumnCount();   
			    String colNames[] = new String[columnCount];
			    for (int i = 1; i <= columnCount; i++) {
			        colNames[i-1] = metadata.getColumnName(i);
			    }
				
				out.println("<table><tr>");
				for (int i = 0; i < colNames.length; i++) {
					out.println("<th>" + colNames[i] + "</th>");
				}
				out.println("</tr>");
				while (rs.next()) {
					out.println("<tr>");
					
					for (int i = 0; i < colNames.length; i++) {
						out.println("<td>" + rs.getString(colNames[i]) + "</td>");
					}
					
					out.println("</tr>");
				}
				out.println("</table>"); 
				rs.close();
			} else {
				out.println("Query Executed");
			}
			// only close what's needed
			if (isQuery) {
				stmt.close();
			} else {
				callStmt.close();
			}
			conn.close();
		}
	%>
	<br />
	<form action="Entry.jsp">
		<input type="submit" value="BACK" />
	</form>
</body>
</html>