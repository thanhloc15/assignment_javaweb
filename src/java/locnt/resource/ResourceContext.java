/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnt.resource;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.ResourceBundle;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author kusmi
 */
public class ResourceContext implements ServletContextListener {
    private final String FILE = "locnt.resource.Mapping";
    HashMap<String, String> list;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext sc = sce.getServletContext();
        
        ResourceBundle bundle = ResourceBundle.getBundle(FILE);
        Enumeration<String> key = bundle.getKeys();
        while (key.hasMoreElements()) {
            if (list == null) {
                list = new HashMap<>();
            }
            String keyMap = key.nextElement();
            String value = bundle.getString(keyMap);
            list.put(keyMap, value);
        }
        sc.setAttribute("LABELRESOURCE", list);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
