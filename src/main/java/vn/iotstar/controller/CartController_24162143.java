package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.dao.IVideoDao_24162143;
import vn.iotstar.dao.impl.VideoDaoImpl_24162143;
import vn.iotstar.entity.CartItem;
import vn.iotstar.entity.Video_24162143;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet({"/cart", "/cart/add", "/cart/update", "/cart/remove"})
public class CartController_24162143 extends HttpServlet {
    private IVideoDao_24162143 videoDao = new VideoDaoImpl_24162143();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        
        if (uri.contains("/cart/add")) {
            addToCart(req, resp);
        } else if (uri.contains("/cart/remove")) {
            removeFromCart(req, resp);
        } else {
            calculateTotalAndShipping(req);
            req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/cart/update")) {
            updateCart(req, resp);
        }
    }

    private void calculateTotalAndShipping(HttpServletRequest req) {
        HttpSession session = req.getSession();
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        double subtotal = 0;
        if (cart != null) {
            for (CartItem item : cart.values()) {
                subtotal += item.getTotalPrice();
            }
        }
        // Phí ship mặc định 30,000đ (Freeship cho đơn hàng từ 200,000đ trở lên)
        double shippingFee = (subtotal >= 200000 || subtotal == 0) ? 0 : 30000;
        double grandTotal = subtotal + shippingFee;

        session.setAttribute("subtotal", subtotal);
        session.setAttribute("shippingFee", shippingFee);
        session.setAttribute("grandTotal", grandTotal);
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String videoId = req.getParameter("id");
        Video_24162143 video = videoDao.findById(videoId);

        if (video != null) {
            HttpSession session = req.getSession();
            Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
            }

            if (cart.containsKey(videoId)) {
                CartItem item = cart.get(videoId);
                int newQty = item.getQuantity() + 1;
                if (newQty <= 99) item.setQuantity(newQty);
            } else {
                double itemPrice = (video.getPrice() != null) ? video.getPrice() : 50000.0;
                cart.put(videoId, new CartItem(video, 1, itemPrice));
            }
            session.setAttribute("cart", cart);
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void updateCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String videoId = req.getParameter("id");
        int quantity = 1;
        try {
            quantity = Integer.parseInt(req.getParameter("quantity"));
        } catch (Exception ignored) {}

        if (quantity < 1) quantity = 1;
        if (quantity > 99) quantity = 99;

        HttpSession session = req.getSession();
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        if (cart != null && cart.containsKey(videoId)) {
            cart.get(videoId).setQuantity(quantity);
            session.setAttribute("cart", cart);
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void removeFromCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String videoId = req.getParameter("id");
        HttpSession session = req.getSession();
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        if (cart != null) {
            cart.remove(videoId);
            session.setAttribute("cart", cart);
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}