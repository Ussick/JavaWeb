<%@ page import="ua.itea.DbExecutor"%>
<a href="withauthorizator.jsp">Authorization</a> | <a href="form03.jsp">Registration</a>
<center>
<table>
<form action="form03.jsp" method="post">
    <tr><td>Login(Your Email):</td><td><input type="email" name="login" value="<%=(request.getParameter("login") != null)?request.getParameter("login"):""%>"/></td></tr>
	<tr><td>Name:</td><td><input type="text" name="name" value="<%=(request.getParameter("name") != null)?request.getParameter("name"):""%>"/></td></tr>
    <tr><td>Password:</td><td><input type="password" name="password" value="<%=(request.getParameter("password") != null)?request.getParameter("password"):""%>"/></td></tr>
    <tr><td>Repeat password:</td><td><input type="password" name="passwordRepeat" value="<%=(request.getParameter("passwordRepeat") != null)?request.getParameter("passwordRepeat"):""%>"/></td></tr>
    <tr><td>Gender:</td><td>M<input type="radio" name="gender" value="M" <%=("M".equals(request.getParameter("gender")))? "checked='true'":""%>/>F<input type="radio" name="gender" value="F" <%=("F".equals(request.getParameter("gender")))? "checked='true'":""%>/></td></tr>
    <tr><td>Region:</td><td><select name="region">
        <option value="DNR" <%=("DNR".equals(request.getParameter("region")))?" selected='true'":""%>>ДНР</option>
        <option value="LNR" <%=("LNR".equals(request.getParameter("region")))?" selected='true'":""%>>ЛНР</option>
        <option value="Crimea" <%=("Crimea".equals(request.getParameter("region")))?" selected='true'":""%>>Крым</option>
    </select></td></tr>
	<tr><td>Comment:</td><td><textarea rows=10 cols=20 name="comment"><%=(request.getParameter("comment") != null)?request.getParameter("comment"):""%></textarea></td></tr>
    <tr><td>I agree to install an Amigo Browser:</td><td><input type="checkbox" name="browser" checked="true"/></td></tr>
    <tr><td> </td><td><input type="submit" value="SEND"/></td></tr>
</form>
</table>
</center>
<%@ page import="java.util.Objects"%>
<%@ page import="java.util.regex.Pattern"%>
<%! private boolean notcalculate = true; %>
<%
    boolean isError = false;
	String regLog = "^([a-zA-Z0-9_]{2,}[\\.])*[a-zA-Z0-9_]{2,}[@][a-zA-Z]{2,}[\\.a-zA-Z]{3,}$";
	String reg1 = "^[\\w\\W]{8,}$";
    String reg2 = "^[\\w\\W]*[A-ZА-Я]+[\\w\\W]*$";
    String reg3 = "^[\\w\\W]*[0-9]+[\\w\\W]*$";
    String errorText = "<ul>";
    String login = request.getParameter("login");
	String name = request.getParameter("name");
    String password = request.getParameter("password");
    String passwordRepeat = request.getParameter("passwordRepeat");
    String gender = request.getParameter("gender");
    String region = request.getParameter("region");
    String comment = request.getParameter("comment");
    String browser = request.getParameter("browser");

	if (notcalculate){
		notcalculate = false;
	}
	else{
		if (login == null || login.isEmpty()) {
        isError = true;
        errorText += "<li>Login is empty!</li>";
		}else{
			if (Pattern.matches(regLog, login)){}
				else{
						isError = true;
						errorText += "<li>Login is not valid!</li>";
					}
			}
			
		if (name == null || name.isEmpty()) {
        isError = true;
        errorText += "<li>Name is empty!</li>";
		}	
			
	
	if (password == null || password.isEmpty()) {
        isError = true;
        errorText += "<li>Password is empty!</li>";
    }else{
		if (Objects.equals(password, passwordRepeat)){
			if (Pattern.matches(reg1, password)&&Pattern.matches(reg2, password)&&Pattern.matches(reg3, password)){}
				else{
					isError = true;
					errorText += "<li>Password have to be more then 8 symbols with minimum 1 capital letter and 1 number !</li>";
				}	
		}
		else{
			isError = true;
			errorText += "<li>Password and Repeatpassword are not equal!</li>";
		}
	}
	
	if (gender == null || gender.isEmpty()) {
        isError = true;
        errorText += "<li>Choose your gender!</li>";
    }
	
	if (comment == null || comment.isEmpty()) {
        isError = true;
        errorText += "<li>Fill in your comment!</li>";
    }
	
	if (browser == null || browser.isEmpty()) {
        isError = true;
        errorText += "<li>Amigo Browser has to be chosen!</li>";
    }
	
	
    errorText += "</ul>";
    if (!isError) {
		
		%>
		<script type="text/javascript">
            document.body.innerHTML = '';
        </script>
		<a href="withauthorizator.jsp">Authorization</a> | <a href="form03.jsp">Registration</a>
		<%
		notcalculate = true;
        DbExecutor de = new DbExecutor();
        de.addUser(login, name, password, gender, region, comment);
        out.write("<h1 style='font-size:25px' align='center'>"+"Registration succeeded!"+"<h1>");
		
    } else {%>
	
	
	<h1 style="float: left; margin-left: 950px; margin-top: -250px; font-size:15px; font-weight: normal">
	<%out.write(""+errorText);%>
	</h1>
		
    <%}%>
		
	<%}%>
	
	