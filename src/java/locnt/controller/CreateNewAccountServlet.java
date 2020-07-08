/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import locnt.registration.RegistrationDAO;
import locnt.registration.RegistrationDTO;
import locnt.registration.RegistrationInserError;

/**
 *
 * @author kusmi
 */
@WebServlet(name = "CreateNewAccountServlet", urlPatterns = {"/CreateNewAccountServlet"})
public class CreateNewAccountServlet extends HttpServlet {
    
    private final String Insert_Error_Page = "createNewAccount.jsp";
    private final String Login_Page = "login.html";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String username = request.getParameter("txtUsername");
        String password = request.getParameter("txtPassword");
        String confirm = request.getParameter("txtConfirm");
        String fullname = request.getParameter("txtFullname");
        
        String url = Insert_Error_Page;
        RegistrationInserError errors = new RegistrationInserError();
        boolean bErr = false;
        try {
            //1. check validation of user's errors
            if (username.trim().length() < 6 || username.trim().length() > 30) {
                bErr = true;
                errors.setUsernameLengthErr("username length requires 6 - 20 chars");
            }
            
            if (password.trim().length() < 6 || password.trim().length() > 20) {
                bErr = true;
                errors.setPasswordLengthErr("password length requires 6 - 30 chars");
            } else if (!confirm.equals(password.trim())) {
                bErr = true;
                errors.setConfirmNotMatch("confirm must match password");
            }
            if (fullname.trim().length() < 2 || fullname.trim().length() > 50) {
                bErr = true;
                errors.setFullNameLengthErr("full name length requires 2 - 50 chars");
            }
            //2.process
            if (bErr) {
                //cached error to forward to show page
                request.setAttribute("INSERTERR", errors);
            } else {
                //call DAO
                RegistrationDTO dto = new RegistrationDTO(username, password, fullname, false);
                RegistrationDAO dao = new RegistrationDAO();
                boolean result = dao.createAccount(dto);
                if (result) {
                    url = Login_Page;
                }
            }
            
        } catch (NamingException ex) {
            log("CreateNewAccountServlet _ Naming " + ex.getMessage());
        } catch (SQLException ex) {
            String msg = ex.getMessage();
            log("CreateNewAccountServlet _ SQL " + ex.getMessage());
            if (msg.contains("duplicate")) {
                errors.setUsernameIsExisted(username + " is Existed in System");
                request.setAttribute("INSERTERR", errors);
            }
        } finally {
//            response.sendRedirect(url);
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
