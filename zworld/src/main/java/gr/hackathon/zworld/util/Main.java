/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gr.hackathon.zworld.util;

import gr.hackathon.zworld.model.User;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Acer
 */
public class Main {

    public static void main(String [] args) {
        try {
            User user = ZworldUtils.getUserById(1);
            System.out.print(user.getEmail());

        } catch (Exception ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
