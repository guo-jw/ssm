package com.ssm.model;

public class OrderConsultUser extends Order{

    private static OrderConsultUser consultUser = new OrderConsultUser();
    public static OrderConsultUser getInstanceBase(){
        try {
            return (OrderConsultUser)consultUser.clone();
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
        return new OrderConsultUser();
    }

    //分类主键
    private int consultId;
    //级别
    private String consultLevel;
    //父id
    private int parentId;
    //用户主键
    //private int  userId;
    //用户角色
    private int role;
    //用户名称
    private String username;

    public int getConsultId() {
        return consultId;
    }

    public void setConsultId(int consultId) {
        this.consultId = consultId;
    }

    public String getConsultLevel() {
        return consultLevel;
    }

    public void setConsultLevel(String consultLevel) {
        this.consultLevel = consultLevel;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public OrderConsultUser() {
    }


}
