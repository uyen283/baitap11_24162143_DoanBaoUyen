package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.entity.User_24162143;
import vn.iotstar.service.IUserService_24162143;
import vn.iotstar.service.impl.UserServiceImpl_24162143;

import java.io.IOException;

@WebServlet(urlPatterns = {"", "/", "/login", "/logout"})
public class LoginController_24162143 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService_24162143 userService = new UserServiceImpl_24162143();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("logout")) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String u = req.getParameter("username");
        String p = req.getParameter("password");

        User_24162143 user = userService.login(u, p);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("account", user);

            // Kiểm tra xem trước đó người dùng có đang cố truy cập trang cần đăng nhập (như /my-orders hay /checkout) không
            String redirectUrl = (String) session.getAttribute("redirectUrl");
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                session.removeAttribute("redirectUrl"); // Xóa cache URL sau khi dùng xong
                resp.sendRedirect(redirectUrl);         // Chuyển hướng quay lại đúng trang người dùng muốn vào
            } else {
                // Đăng nhập bình thường: Phân quyền Admin / User
                if (Boolean.TRUE.equals(user.getAdmin())) {
                    resp.sendRedirect(req.getContextPath() + "/admin/videos");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/home");
                }
            }
        } else {
            req.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng!");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        }
    }
}