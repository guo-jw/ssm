package com.ssm.test;

import java.sql.Connection;

public class Test2 {


    public static void main(String[] args){
        Test1 t = new Test1();
        Connection connection = t.getConnection();

        int a = 3;
        System.out.println(a);

    }
}
