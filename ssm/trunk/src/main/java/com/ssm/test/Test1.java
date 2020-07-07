/*package com.ssm.test;

import com.ssm.model.User;
import com.ssm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;


//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration("classpath:spring-mybatis.xml")
public class Test1 extends BaseTest{

    @Autowired
    private UserService service;

    @org.junit.Test
    public void testQueryAll() throws Exception {
        String username="admin";
        Map map = new HashMap();
        map.put("username","admin");
        map.put("password","admin");
        service.login(map);
       User u = service.findByUsername("1");
//        User u1 = service.getById(1);
        System.out.println("@@@@@@@@@@@@@"+u);
    }*/


package com.ssm.test;
import java.sql.*;

public class Test1 {

        // 设置3个变量存放数据库地址、用户名和密码
        // "jdbc驱动:连接的数据库类型://IP地址:端口/数据库名称
        private static final String URL = "jdbc:nds://172.22.3.2:18600/v_18600_jhptDB_wx?appname=app_jhptDB_wx";
        private static final String USERNAME = "jysoft";
        private static final String PASSWORD = "Glzz@123";

        private static Connection conn =null;

        static{
            try {
                // 1、加载驱动程序
                Class.forName("sgcc.nds.jdbc.driver.NdsDriver");
                // 2、获得数据库连接
                conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
               /* PreparedStatement ps = conn.prepareStatement("select 1 from DUAl");
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    int id = rs.getInt("id");
                    System.err.println(id);
                }*/

                System.err.println("---------------");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        public static Connection getConnection(){
            return conn;
        }

    }


//}
