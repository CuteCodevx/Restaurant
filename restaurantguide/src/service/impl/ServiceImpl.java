package service.impl;

import bean.CommentBean;
import bean.MenuBean;
import bean.ReservationBean;
import bean.RestaurantBean;
import dao.Dao;
import dao.impl.DaoImpl;
import service.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ServiceImpl implements Service {
    private String tableName;
    Dao testDao;

    public ServiceImpl(String name){
        this.tableName = name;
        testDao = new DaoImpl();
    }

    @Override
    public List<Object> getList() {
        String sql = "select * from "+tableName+"";
        return testDao.query(sql,null);
    }
    public ResultSet getResultSet(Object[] params){
        String sql="";
        if(params!=null){
            if(tableName.equals("restaurant")){
                if (params.length == 4){
                    sql = "select * from "+tableName+" WHERE name like ? or cuisine like ?  or details like ? or specialDiets like ? ORDER BY id";
                }else if (params.length == 2){
                    sql = "select * from "+tableName+" WHERE name like ? or cuisine like ? ";
                }else{
                    sql = "select * from "+tableName+" WHERE name like ?";
                }
            }else if(tableName.equals("comment")){
                sql = "select * from "+tableName+" WHERE resName like ? or realName like ?";
            }else if(tableName.equals("reservation")){
                sql = "select * from "+tableName+" WHERE realName like ?";
            }else if(tableName.equals("menu")){
                if(params.length == 2){
                    sql = "select * from "+tableName+" WHERE resName like ? and category like ? ORDER BY category" ;
                }else{
                    sql = "select * from "+tableName+" WHERE dishName like ? or category like ? or description like ? ORDER BY category";
                }

            }
            return testDao.queryTypeIsResultSet(sql,params);
        }else{
            if(tableName.equals("restaurant")){
                sql = "select * from "+tableName+" ORDER BY point desc";
            }else{
                sql = "select * from "+tableName+"";
            }

            return testDao.queryTypeIsResultSet(sql,null);
        }
    }
    public List getRestaurant(ResultSet resultList){
        //ResultSet resultList = getResultSet();
        List beans = new ArrayList<>();
        try{
            if(resultList!= null){
                while(resultList.next()) {
                    if(tableName.equals("restaurant")){
                        RestaurantBean restaurant = new RestaurantBean();
                        restaurant.setId(resultList.getInt("id"));
                        restaurant.setName(resultList.getString("name"));
                        restaurant.setPoint(resultList.getString("point"));
                        restaurant.setTel(resultList.getString("tel"));
                        restaurant.setAddress(resultList.getString("address"));
                        restaurant.setPostcode(resultList.getString("postcode"));
                        restaurant.setOpenTime(resultList.getString("openTime"));
                        restaurant.setCloseTime(resultList.getString("closeTime"));
                        restaurant.setCuisine(resultList.getString("cuisine"));
                        restaurant.setDetails(resultList.getString("details"));
                        restaurant.setSpecialDiets(resultList.getString("specialDiets"));
                        restaurant.setPriceRange(resultList.getString("priceRange"));
                        beans.add(restaurant);
                    }else if (tableName.equals("comment")){
                        CommentBean comment = new CommentBean();
                        comment.setContent(resultList.getString("content"));
                        comment.setDate(resultList.getString("date"));
                        comment.setResName(resultList.getString("resName"));
                        comment.setUsername(resultList.getString("username"));
                        comment.setGivePoint(resultList.getString("point"));
                        comment.setRealName(resultList.getString("realName"));
                        beans.add(comment);
                    }else if(tableName.equals("reservation")){
                        ReservationBean reserve = new ReservationBean();
                        reserve.setDate(resultList.getString("date"));
                        reserve.setResName(resultList.getString("resName"));
                        reserve.setGuestName(resultList.getString("guestName"));
                        reserve.setMessage(resultList.getString("message"));
                        reserve.setPeopleNum(resultList.getString("peopleNum"));
                        reserve.setRealName(resultList.getString("realName"));
                        beans.add(reserve);
                    }else if(tableName.equals("menu")){
                        MenuBean menu = new MenuBean();
                        menu.setPrice(resultList.getString("price"));
                        menu.setResName(resultList.getString("resName"));
                        menu.setCategory(resultList.getString("category"));
                        menu.setDishName(resultList.getString("dishName"));
                        menu.setDescription(resultList.getString("description"));
                        beans.add(menu);
                    }
                }
                return beans;
            }
        }catch (SQLException e) {
                e.printStackTrace();
        }
        return null;
    }
    @Override
    public int insert(Object[] params) {
        String sql="";
        if(tableName.equals("restaurant")){
            sql = "insert into "+tableName+"(name) values(?)";
        }else if(tableName.equals("comment")){
            sql = "insert into "+tableName+"(username, content, resName, date, point, realName) values(?,?,?,?,?,?)";

        }else if(tableName.equals("reservation")){
            sql = "insert into "+tableName+"(guestName, peopleNum, message, date, resName, realName) values(?,?,?,?,?,?)";
        }
        return testDao.update(sql,params);
    }

    @Override
    public int modify(Object[] params) {
        String sql = "update "+tableName+" set point = ? where name like ?";
        return testDao.update(sql,params);
    }

    @Override
    public int delete(Object[] params) {
        String sql = "delete from "+tableName+" where id = ?";
        return testDao.update(sql,params);
    }
}
