/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.product;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import locnt.utils.DBHelper;

/**
 *
 * @author kusmi
 */
public class ProductDAO implements Serializable {

    public List<ProductDTO> list() throws NamingException, SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        Connection con = null;
        Statement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select name, quantity from Product";
                stm = con.createStatement();
                rs = stm.executeQuery(sql);
                while (rs.next()) {
                    int quantity = rs.getInt("quantity");
                    String name = rs.getString("name");
                    listProduct.add(new ProductDTO(name, quantity));
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
        return listProduct;
    }

}
