package ua.itea.servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.zip.GZIPOutputStream;

public class StringServlet extends HttpServlet {

    String sentence;
    boolean flag;



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            RequestDispatcher dispatcher = req.getRequestDispatcher("homeworks/homework06/form06.jsp");
            dispatcher.forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!flag){
            sentence=req.getParameter("text");
            StringBuilder stringBuilder=new StringBuilder();
            for (int i = 0; i <=3000 ; i++) {
                stringBuilder.append(sentence);
            }
            sentence=stringBuilder.toString();
            req.getSession().setAttribute("data", sentence);
            flag=true;
            RequestDispatcher dispatcher = req.getRequestDispatcher("homeworks/homework06/result.jsp");
            dispatcher.forward(req, resp);

        }else {
            String data = (String) req.getSession().getAttribute("data");
            PrintWriter printWriter = resp.getWriter();
            resp.setContentType("text/html");
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            GZIPOutputStream gzip = new GZIPOutputStream(out);
            gzip.write(data.getBytes());
            gzip.close();

            printWriter.write("<h1 style='font-size:25px'>"+out.toString("UTF-8")+"</h1>");
//            printWriter.write("<h1 style='font-size:25px'>"+data+"</h1>");
            flag=false;
        }

    }
}
