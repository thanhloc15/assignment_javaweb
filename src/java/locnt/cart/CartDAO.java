/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.cart;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.NamingException;
import locnt.utils.DBHelper;

/**
 *
 * @author kusmi
 */
public class CartDAO implements Serializable {
    public boolean insertCart(String productname, int quantity, int idCart)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBHelper.makeConnection();

            if (con != null) {
                String sql = "INSERT INTO Cart (productName, Quantity, CartID) Values(?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, productname);
                stm.setInt(2, quantity);
                stm.setInt(3, idCart);
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
}
