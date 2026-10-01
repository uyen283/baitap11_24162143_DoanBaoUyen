package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.entity.User_24162143;
import vn.iotstar.service.IUserService_24162143;
import vn.iotstar.service.impl.UserServiceImpl_24162143;

import java.io.IOException;
import java.util.Random;

@WebServlet(urlPatterns = {"/register", "/verify-otp"})
public class RegisterController_24162143 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService_24162143 userService = new UserServiceImpl_24162143();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/register".equals(path)) {
            User_24162143 u = new User_24162143();
            u.setUsername(req.getParameter("username"));
            u.setPassword(req.getParameter("password"));
            u.setEmail(req.getParameter("email"));
            u.setFullname(req.getParameter("fullname"));
            u.setAdmin(false);
            u.setActive(false);

            String otp = String.format("%06d", new Random().nextInt(999999));
            HttpSession session = req.getSession();
            session.setAttribute("tempUser", u);
            session.setAttribute("otp", otp);

            System.out.println("====== MÃ OTP KÍCH HOẠT LÀ: " + otp + " ======");

            req.getRequestDispatcher("/WEB-INF/views/verify-otp.jsp").forward(req, resp);
        } else if ("/verify-otp".equals(path)) {
            HttpSession session = req.getSession();
            String inputOtp = req.getParameter("otp");
            String sysOtp = (String) session.getAttribute("otp");
            User_24162143 tempUser = (User_24162143) session.getAttribute("tempUser");

            if (sysOtp != null && sysOtp.equals(inputOtp)) {
                tempUser.setActive(true);
                userService.register(tempUser);
                session.removeAttribute("otp");
                session.removeAttribute("tempUser");
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                req.setAttribute("error", "Mã OTP nhập không khớp!");
                req.getRequestDispatcher("/WEB-INF/views/verify-otp.jsp").forward(req, resp);
            }
        }
    }
}