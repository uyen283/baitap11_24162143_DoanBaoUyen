package vn.iotstar.controller;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.entity.*;
import vn.iotstar.utils.JpaConfig_24162143;

import java.io.IOException;
import java.util.*;

@WebServlet("/checkout")
public class CheckoutController_24162143 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User_24162143 user = (User_24162143) session.getAttribute("account");

        if (user == null) {
            session.setAttribute("redirectUrl", req.getContextPath() + "/checkout");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String note = req.getParameter("note");

        Double grandTotal = (Double) session.getAttribute("grandTotal");
        if (grandTotal == null) grandTotal = 0.0;

        EntityManager em = JpaConfig_24162143.getEntityManager();
        try {
            em.getTransaction().begin();

            Order_24162143 order = new Order_24162143();
            order.setAddress(address);
            order.setPhone(phone);
            order.setNote(note);
            order.setPaymentMethod("COD");
            order.setStatus("PENDING");
            order.setCreateDate(new Date());
            order.setUser(user);

            List<OrderDetail_24162143> details = new ArrayList<>();
            for (CartItem item : cart.values()) {
                OrderDetail_24162143 detail = new OrderDetail_24162143();
                detail.setOrder(order);
                detail.setVideo(item.getVideo());
                detail.setQuantity(item.getQuantity());
                detail.setPrice(item.getPrice());
                details.add(detail);
            }

            order.setTotalAmount(grandTotal); // Tổng tiền đã cộng phí ship
            order.setOrderDetails(details);

            em.persist(order);
            em.getTransaction().commit();

            session.removeAttribute("cart");
            session.removeAttribute("subtotal");
            session.removeAttribute("shippingFee");
            session.removeAttribute("grandTotal");

            req.setAttribute("orderId", order.getOrderId());
            req.getRequestDispatcher("/WEB-INF/views/checkout-success.jsp").forward(req, resp);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/cart");
        } finally {
            em.close();
        }
    }
}