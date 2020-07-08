/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.orderdetail;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.NamingException;
import locnt.utils.DBHelper;

/**
 *
 * @author kusmi
 */
public class OrderDetailDAO implements Serializable {
    public boolean insertOrderDetail(int cartID, String username) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO OrderDetail (Cartid, username) Values (?, ?)";
                stm = con.prepareStatement(sql);
                stm.setInt(1, cartID);
                stm.setString(2, username);
                int r = stm.executeUpdate();
                if (r > 0) {
                    return true;
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public int getId() throws NamingException, SQLException {
        Connection con = null;
        Statement stm = null;
        ResultSet rs = null;
        int index = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select Cartid from OrderDetail where Cartid = (select max(Cartid) from OrderDetail)";
                stm = con.createStatement();
                rs = stm.executeQuery(sql);
                while (rs.next()) {
                    index = rs.getInt("Cartid");
                    return index;
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
        return 0;
    }
}
