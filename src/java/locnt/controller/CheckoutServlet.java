/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import locnt.cart.CartDAO;
import locnt.cart.CartObject;
import locnt.orderdetail.OrderDetailDAO;
import locnt.product.ProductDAO;

/**
 *
 * @author kusmi
 */
public class CheckoutServlet extends HttpServlet {

    private final String SUPER_MARKET_PAGE = "addItemToCart";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = SUPER_MARKET_PAGE;
        try {
            //1. user goes to cart's place
            HttpSession session = request.getSession();
            //2. lấy giỏ
            CartObject cart = (CartObject) session.getAttribute("CART");
            Map<String, Integer> items = cart.getItems();
            int id = 0;
            for (String itemKey : items.keySet()) {
                if (cart != null) {
                    
                    OrderDetailDAO dao = new OrderDetailDAO();
                    CartDAO daoCart = new CartDAO();
                    if (String.valueOf(dao.getId()) == null) {
                        id = 0;
                    } else {
                        id = dao.getId() + 1;
                    }
                    String username = (String) session.getAttribute("USERNAME");
                    boolean rs = dao.insertOrderDetail(id, username );
                    boolean result = daoCart.insertCart(itemKey, items.get(itemKey), id);
                    if (result == true && rs == true) {
                        session.removeAttribute("CART");
                    }//end if remove attribute
                }//end if cart
            }
        } catch (NamingException ex) {
            log("CheckoutServlet _ Naming " + ex.getMessage());
        } catch (SQLException ex) {
            log("CheckoutServlet _ SQL " + ex.getMessage());
        } finally {
            response.sendRedirect(url);
            out.close();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
