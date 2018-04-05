/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sintacticAnalizer;

import java.io.File;

/**
 *
 * @author diego
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String path = "/home/diego/NetBeansProjects/AnalizadorPHP/AnalizadorPHP/src/sintacticAnalizer/Lexer.flex";
        //"C:/Users/diego/Documents/NetBeansProjects/AnalizadorPHP/AnalizadorPHP/src/sintacticAnalizer/Lexer.flex";
        generarLexer(path);
    }
    public static void generarLexer(String path){
        File file=new File(path);
        jflex.Main.generate(file);
    }
}
