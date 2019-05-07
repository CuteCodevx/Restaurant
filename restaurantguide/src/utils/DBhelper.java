package utils;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DBhelper {

    private static final String DRIVENAME = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/test?useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "weiqian1234";

    private Connection conn = null;
    private Statement st = null;
    private PreparedStatement ppst = null;
    private ResultSet rs = null;

    /**
     * load driver
     */
    static{
        try {
            Class.forName(DRIVENAME).newInstance();
        } catch (Exception e) {
            System.out.println("load  n："+e.getMessage());
        }
    }


    /**
     * connect database
     * @return
     */
    public Connection getConn(){
        try {
            conn =  DriverManager.getConnection(URL,USER,PASSWORD);
        } catch (SQLException e) {
            System.out.println("connection failed："+e.getMessage());
        }
        return conn;
    }


    /**
     * get result(no params)
     * @param sql
     * @return
     */
    private ResultSet getRs(String sql){
        conn = this.getConn();
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
        } catch (SQLException e) {
            System.out.println("something wrong: "+e.getMessage());
        }
        return rs;
    }


    /**
     * get all results
     * @param sql
     * @param params
     * @return
     */
    private ResultSet getRs(String sql,Object[] params){
        conn = this.getConn();
        try {
            ppst = conn.prepareStatement(sql);
            if(params!=null){
                for(int i = 0;i<params.length;i++){
                    ppst.setObject(i+1, params[i]);
                }
            }
            rs = ppst.executeQuery();
        } catch (SQLException e) {
            System.out.println("wrong:"+e.getMessage());
        }

        return rs;
    }

    public ResultSet queryResultSet(String sql, Object[] params){
        ResultSet rs = null;
        if(params!=null){
            rs = getRs(sql, params);
        }else{
            rs = getRs(sql);
        }
        return rs;
    }

    /**
     * query
     * @param sql
     * @param params
     * @return
     */
    public List<Object> query(String sql, Object[] params){

        List<Object> list = new ArrayList<Object>();
        ResultSet rs = null;
        if(params!=null){
            rs = getRs(sql, params);
        }else{
            rs = getRs(sql);
        }
        ResultSetMetaData rsmd = null;
        int columnCount = 0;

        try {
            rsmd = rs.getMetaData();
            columnCount = rsmd.getColumnCount();
            while(rs.next()){
                Map<String, Object> map = new HashMap<String, Object>();
                for(int i = 1;i<=columnCount;i++){
                    map.put(rsmd.getColumnLabel(i), rs.getObject(i));
                }
                list.add(map);
            }
        } catch (SQLException e) {
            System.out.println("wrong:"+e.getMessage());
        } finally {
            closeConn();
        }
        return list;
    }


    /**
     * update(no params
     * @param sql
     */
    public int update(String sql){
        int affectedLine = 0; //the number of lines of need updated
        conn = this.getConn();
        try {
            st = conn.createStatement();
            affectedLine = st.executeUpdate(sql);
        } catch (SQLException e) {
            System.out.println("update failed:"+e.getMessage());
        } finally {
            closeConn();
        }
        return affectedLine;
    }


    /**
     * update
     * @param sql
     * @param params
     * @return
     */
    public int update(String sql,Object[] params){
        int affectedLine = 0; //the number of lines of need updated
        conn = this.getConn();
        try {
            ppst = conn.prepareStatement(sql);
            if(params!=null){
                for(int i = 0;i<params.length;i++){
                    ppst.setObject(i+1, params[i]);
                }
            }
            affectedLine = ppst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("update failed"+e.getMessage());
        } finally {
            closeConn();
        }
        return affectedLine;
    }


    private void closeConn(){
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }

        if(st!=null){
            try {
                st.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }

        if(ppst!=null){
            try {
                ppst.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }

        if(conn!=null){
            try {
                conn.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }
    }

}