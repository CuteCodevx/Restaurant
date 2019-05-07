package testfiler;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class loginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("initial!!!!!");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest hrequest = (HttpServletRequest)servletRequest;
        HttpServletResponse hresponse = (HttpServletResponse)servletResponse;
        String usernameFromPlatform;
        Cookie[] cookies = hrequest.getCookies();
        for(Cookie cookie:cookies){
            //System.out.println("cookie is ::"+cookie);
            if ("userName".equals(cookie.getName())){
                usernameFromPlatform = cookie.getValue();
                System.out.println("cookie is ::"+usernameFromPlatform);
                hrequest.getSession().setAttribute("userName",usernameFromPlatform);
                //go

                String nameFromPlatform = (String)hrequest.getSession().getAttribute("userName");

                if(nameFromPlatform!=null){
                    filterChain.doFilter(servletRequest,servletResponse);
                }else{
                   hresponse.sendRedirect("login");
                }


            }
        }
//
    }

    @Override
    public void destroy() {
        System.out.println("destory!!!!!");
    }
}
