package ua.itea.filters;

import javax.servlet.*;
import java.io.IOException;


public class StringFilter implements Filter {

    String name;
    int i;

    public void init(FilterConfig config) {
        i++;
        name = config.getInitParameter("name");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        System.out.println("Filter is working " + name + " " +i);
        System.out.println(servletRequest.getAttribute("data"));//нет возможности вызвать на уровне сессии
        if (servletRequest.getAttribute("data")!=null){
            System.out.println("!!!!!!!!!!!!!!");
            servletRequest.setAttribute("data", "mmmmmmm");
        }

        filterChain.doFilter(servletRequest, servletResponse);
    }
}
