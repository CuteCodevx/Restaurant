package bean;

public class RestaurantBean {
    private String name;
    private String point;
    private String address;
    private String tel;
    private String openTime;
    private String closeTime;
    private String cuisine;
    private String postcode;
    private String details;
    private String specialDiets;
    private String priceRange;
    private int id;



    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getPoint() {
        return point;
    }
    public void setPoint(String point) {
        this.point = point;
    }

    public String getAddress() {
        return address;
    }
    public void setAddress(String add) {
        this.address = add;
    }


    public String getOpenTime() {
        return openTime;
    }
    public void setOpenTime(String time) {
        this.openTime = time;
    }

    public String getCloseTime() {
        return closeTime;
    }
    public void setCloseTime(String time) {
        this.closeTime = time;
    }
    public String getPostcode() {
        return postcode;
    }
    public void setPostcode(String ranking) {
        this.postcode = ranking;
    }

    public String getCuisine() {
        return cuisine;
    }
    public void setCuisine(String cuisine) {
        this.cuisine = cuisine;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getSpecialDiets() {
        return specialDiets;
    }

    public void setSpecialDiets(String specialDiets) {
        this.specialDiets = specialDiets;
    }

    public String getPriceRange() {
        return priceRange;
    }

    public void setPriceRange(String priceRange) {
        this.priceRange = priceRange;
    }


    public void setId(int id) {
        this.id = id;
    }
    public int getId(){
        return id;
    }

}
