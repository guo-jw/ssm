package com.ssm.model;

import java.io.Serializable;

public class Base implements Serializable {
    private int id;
    private String name;

    public Base(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public Base() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
