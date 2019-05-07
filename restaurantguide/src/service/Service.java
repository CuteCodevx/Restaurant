package service;

import bean.RestaurantBean;

import java.sql.ResultSet;
import java.util.List;

public interface Service {
    //get list
    List<Object> getList();
    int insert(Object[] params);
    int modify(Object[] params);
    int delete(Object[] params);
    ResultSet getResultSet(Object[] name);
    List<RestaurantBean> getRestaurant(ResultSet resultList);
}