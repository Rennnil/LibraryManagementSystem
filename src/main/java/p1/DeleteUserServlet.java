package p1;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "DeleteUserServlet", value = "/DeleteUserServlet" )

public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Connection con= DBConnection.getConnection();

            String sql = "DELETE FROM USERS WHERE USER_ID = ?";
            PreparedStatement pr = con.prepareStatement(sql);
            pr.setInt(1, id);

            int deleted = pr.executeUpdate();
            if (deleted > 0) {
                response.sendRedirect(request.getContextPath() + "/Admin/ManageLibrarian.jsp");
            } else {
                out.println("<h3 style='color:red;'>Book not found or already deleted.</h3>");
            }

            pr.close();
            con.close();

        } catch (NumberFormatException e) {
            out.println("<h3 style='color:red;'>Invalid ID format.</h3>");
        } catch (Exception e) {
            e.printStackTrace(out);
        }

    }
}
