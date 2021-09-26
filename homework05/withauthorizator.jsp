<%@ page import="ua.itea.daoImpl.Authorizator" %>
<%! private int countLogins = 0; %>
<%! private long timeOfLock = 0; %>
<%@ page import="java.util.Objects"%>
<%@ page import="java.lang.String"%>
<a href="withauthorizator.jsp">Authorization</a> | <a href="form03.jsp">Registration</a>
<%
    if (request.getParameter("logout") != null) {
		countLogins = 0;
        session.setAttribute("authorized", null);
    }
    String loginFromSession = (String) session.getAttribute("authorized");
	
    boolean showForm = true;

        String login = request.getParameter("login");
        String password = request.getParameter("password");
	
		if ((login==null && password==null)){
		}else{
			        Authorizator auth = new Authorizator();
        String userName = auth.isAuthorized(login, password);
        if ((userName != null) ) {
            showForm = false;
            session.setAttribute("authorized", userName);
            loginFromSession = userName;
            out.write("<center><font color='green'>Access granded</font>");
			out.write("<h1></h1>");
        }else {
				showForm=true;
            countLogins++;
			out.write("in block4 " + countLogins);
            if (countLogins == 3) {
                timeOfLock = System.currentTimeMillis();
                showForm = false;
            }
            out.write("<center><font color=\"red\">Access denied. countLogins: " + countLogins + "</text>");
        }
		}

    
	    if (timeOfLock > 0) {
        showForm = false;
        long rez = ((timeOfLock + 10000) - System.currentTimeMillis())/1000;
        out.write("<center><font color=\"red\">You locked for " + rez + " seconds.</text>");
        if (rez < 0) {
            timeOfLock = 0;
            countLogins = 0;
            showForm = true;
        }
    }
    if (showForm) {
%>
<center>
<table>
<form action="withauthorizator.jsp" method="post">
    <tr><td>Login:</td><td><input type="text" name="login"/></td></tr>
    <tr><td>Password:</td><td><input type="password" name="password"/></td></tr>
    <tr><td> </td><td><input type="submit" value="SEND"/></td></tr>
</form>
</table>
</center>
<%
    } else {
		if (loginFromSession !=null){
			 timeOfLock = 0;
			out.write("Hello, " + loginFromSession + " <a href='?logout'>logout</a>");	
    }
	}
%>

