package com.ssm.model;

//咨询分类
public class Consult extends Base{
    //级别
    private String consultLevel;
    //父id
    private int parentId;
    //状态
    private int status;

    public Consult(int id, String name, String consultLevel, int parentId, int status) {
        super(id, name);
        this.consultLevel = consultLevel;
        this.parentId = parentId;
        this.status = status;
    }

    public Consult() {
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
