package p1;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        String role = null;
        if (session != null) {
            // Get the role before invalidating
            role = (String) session.getAttribute("role");
            session.invalidate();
        }

        String contextPath = request.getContextPath();

        if ("student".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/User/index.jsp");
        } else {
            response.sendRedirect(contextPath + "/Login.jsp");
        }

    }
}
