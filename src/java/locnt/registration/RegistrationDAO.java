/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.registration;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import locnt.utils.DBHelper;

/**
 *
 * @author kusmi
 */
public class RegistrationDAO implements Serializable {

    public boolean checkLogin(String username, String password)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1. open Connecttion
            con = DBHelper.makeConnection();
            if (con != null) {
                //2.Tao cau truy van
                String sql = "Select username from Registration Where username = ? And password = ?";
                //3. Tao Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                //4. execute Query
                rs = stm.executeQuery();
                //5. process
                if (rs.next()) {
                    return true;
                }

            }//end if con is not null
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }

        return false;
    }

    private List<RegistrationDTO> accountList;

    public List<RegistrationDTO> getAccountList() {
        return accountList;
    }

    public void searchLastname(String searchValue) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. open Connecttion
            con = DBHelper.makeConnection();
            if (con != null) {
                //2.Tao cau truy van
                String sql = "Select username, password, lastname, isAdmin "
                        + "From Registration "
                        + "Where lastname Like ?";
                //3. Tao Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");
                //4. execute Query
                rs = stm.executeQuery();
                //5. process
                while (rs.next()) {
                    String username = rs.getString("username");
                    String password = rs.getString("password");
                    String lastname = rs.getString("lastname");
                    boolean role = rs.getBoolean("isAdmin");

                    RegistrationDTO dto = new RegistrationDTO(username, password, lastname, role);
                    if (this.accountList == null) {
                        this.accountList = new ArrayList<>();
                    }//end if accountList is null

                    this.accountList.add(dto);
                }//end while rs is not null

            }//end if con is not null
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public boolean deleteAccount(String username) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1. open Connecttion
            con = DBHelper.makeConnection();
            if (con != null) {
                //2.Tao cau truy van
                String sql = "Delete from Registration "
                        + "Where username = ?";
                //3. Tao Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                //4. execute Query
                int row = stm.executeUpdate();
                //5. process
                if (row > 0) {
                    return true;
                }
            }//end if con is not null
        } finally {

            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean updateAccount(String username, String password, boolean admin)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stt = null;
        try {
            //open connection
            con = DBHelper.makeConnection();
            if (con != null) {
                //tao cao truy van
                String sql = "Update Registration "
                        + "SET password = ?, isAdmin = ? "
                        + "Where username = ?";
                //tao statement
                stt = con.prepareStatement(sql);
                stt.setString(1, password);
                stt.setBoolean(2, admin);
                stt.setString(3, username);
                //excute
                int r = stt.executeUpdate();
                if (r > 0) {
                    return true;
                }
            }
        } finally {
            if (stt != null) {
                stt.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean createAccount(RegistrationDTO dto) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "INSERT INTO Registration (username, password, lastname, isAdmin) Values(?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.getUsername());
                stm.setString(2, dto.getPassword());
                stm.setString(3, dto.getLastname());
                stm.setBoolean(4, dto.isRole());
                int r = stm.executeUpdate();
                if (r > 0) {
                    return true;
                }
            }

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public String selectFullname(String username) throws SQLException, NamingException {
        String fullname = null;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select lastname from Registration where username = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                rs = stm.executeQuery();
                if (rs.next()) {
                    fullname = rs.getString("lastname");
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return fullname;

    }

}
