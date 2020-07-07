package com.ssm.model;
//申请人
public class Applicant extends Base{
    //人资编码
    private String codeNum;
    //联系电话
    private String phoneNum;
    //部门主键
    private int departmentId;
    //公司名称
    private String company;

    public String getCodeNum() {
        return codeNum;
    }

    public void setCodeNum(String codeNum) {
        this.codeNum = codeNum;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public Applicant(int id, String name, String codeNum, String phoneNum, int departmentId, String company) {
        super(id, name);
        this.codeNum = codeNum;
        this.phoneNum = phoneNum;
        this.departmentId = departmentId;
        this.company = company;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public Applicant() {
    }
}
