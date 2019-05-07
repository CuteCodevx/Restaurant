package dao;

import java.sql.ResultSet;
import java.util.List;

public interface Dao {
    List<Object> query(String sql, Object[] params);
    ResultSet queryTypeIsResultSet(String sql, Object[] params);
    int update(String sql, Object[] params);
}
