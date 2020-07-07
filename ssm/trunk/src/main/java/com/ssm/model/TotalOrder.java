package com.ssm.model;

public class TotalOrder implements Cloneable{
    private static TotalOrder tOrder = new TotalOrder();

    public static TotalOrder getInstanceBase(){
        try {
            return (TotalOrder)tOrder.clone();
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
        return new TotalOrder();
    }

    public TotalOrder() {
    }

    private int id;
    private String className;
    private int number;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
}
