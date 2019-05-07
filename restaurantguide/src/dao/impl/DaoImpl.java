package dao.impl;

import dao.Dao;
import utils.DBhelper;

import java.sql.ResultSet;
import java.util.List;

public class DaoImpl implements Dao {
    @Override
    public List<Object> query(String sql, Object[] params) {
        DBhelper db = new DBhelper();
        return db.query(sql,params);
    }

    @Override
    public ResultSet queryTypeIsResultSet(String sql, Object[] params) {
        DBhelper db = new DBhelper();
        return db.queryResultSet(sql, params);
    }

    @Override
    public int update(String sql, Object[] params) {
       DBhelper db = new DBhelper();
       return db.update(sql,params);
    }
}
