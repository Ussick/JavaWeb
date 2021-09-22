<%

String rows = request.getParameter("rows");
String columns = request.getParameter("columns");

int r = Integer.parseInt(rows);
int c = Integer.parseInt(columns);
if (r<1 || c<1){
	
	out.write("rows and columns less then 1");
	out.write("<tr> <tr/>");
	out.write("<a href=tableform.jsp>Click here</a>");
}
else{
	int n = 0;

out.write("<table border=1>");
for (int i=1; i<=r; i++){
	out.write("<tr>");
	for (int j=1; j<=c; j++){
		n++;
		if (n%2==0){
			out.write("<td bgcolor=#ffff00>");
		} else {
			out.write("<td>");
		}
		out.write(String.valueOf(n));
		out.write("</td>");
	}
	out.write("</tr>");
}
out.write("</table>");
}

%>