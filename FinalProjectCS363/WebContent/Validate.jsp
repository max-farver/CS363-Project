<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validation Page</title>
</head>
<body>
	<%
		String question = request.getParameter("question_selector");
		boolean isValid = false;
		switch (question) {
			case "Q1":
				isValid = true;
				break;
			case "Q3":
				isValid = true;
				break;
			case "Q6":
				isValid = true;
				break;
			case "Q9":
				isValid = true;
				break;
			case "Q10":
				isValid = true;
				break;
			case "Q11":
				isValid = true;
				break;
			case "Q15":
				isValid = true;
				break;
			case "Q18":
				isValid = true;
				break;
			case "Q23":
				isValid = true;
				break;
			case "Insert":
				isValid = true;
				break;
			case "Delete":
				isValid = true;
				break;
		}
	%>
</body>
</html>