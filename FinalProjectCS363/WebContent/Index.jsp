<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Group 5 CS363 Project</title>
</head>
<body>
	<h2>Enter your options</h2>
	<h3>For each question, the input format is specified as such:</h3>
	<p><strong>Q1: param1 | param2 | param3 | param4 | param5</strong></p>
	<p>For any list to be inputed, please separate list items with a space</p>
	<p>Any param boxes with data entered that is not required (e.g., if a query requires 2 params and 4 are entered), the unused paramas will be ignored</p>
	<ul>
		<li>Q1:  k-tweets    | month          | year</li>
		<li>Q3:  k-hashtags  | year</li>
		<li>Q6:  k-users     | hashtagList</li>
		<li>Q9:  k-users     | category</li>
		<li>Q10: stateList   | month          | year</li>
		<li>Q11: k-tweets    | state          | month     | year   | hashtag</li>
		<li>Q15: subCategory | month          | year</li>
		<li>Q18: k-users     | subCategory    | month     | year</li>
		<li>Q23: k-hashtags  | sub-category   | monthList | year</li>
		<li>Insert: </li>
		<li>Delete: </li>
	</ul>
	<form method="post" action="Validate.jsp">
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
				<option value="Insert">Insert</option>
				<option value="Delete">Delete</option>
		</select>
		<input type="text" name="user_input_1" placeholder="Param 1">
		<input type="text" name="user_input_2" placeholder="Param 2">
		<input type="text" name="user_input_3" placeholder="Param 3">
		<input type="text" name="user_input_4" placeholder="Param 4">
		<input type="text" name="user_input_5" placeholder="Param 5">
		<br>
		<input type="submit" value="GO">
	</form>
</body>
</html>