package com.ssm.model;

import java.sql.Timestamp;
import java.util.ArrayList;

public class Order extends Base implements Cloneable{

    private static Order order = new Order();

    public static Order getInstanceBase(){
        try {
            return (Order)order.clone();
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
        return new Order();
    }

    //编号
    private String orderNum;
    //申请人id
    private Integer applicantId;
    //咨询标题
    private String title;
    //咨询详述
    private String detail;
    //咨询一级分类
    private Integer classA;
    //咨询二级分类
    private Integer classB;
    //资讯来源
    private String source;
    //答复内容
    private String content;
    //是否现场处理(0:否;1:是)
    private Integer isLive;
    //现场处理人id
    private Integer handleId;
    //现场处理结果
    private String handleResult;
    //运维处理状态(0:未处理;1:已处理)
    private Integer status;
    //工单生成时间
    private Timestamp endTime;
    //工单受理结束时间
    private Timestamp startTime;
    //管理员检查处理状态(0:未处理;1:已处理)
    private Integer status2;
    private Integer userId;
    private ArrayList<Integer> userIds;
    //人资编码
    private String codeNum;
    //联系电话
    private String phoneNum;
    //部门主键
    private String departmentName;
    //公司名称
    private String company;
    //申请人名称
    private String applicantName;

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

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

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public Order() {
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public Integer getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(Integer applicantId) {
        this.applicantId = applicantId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public Integer getClassA() {
        return classA;
    }

    public void setClassA(Integer classA) {
        this.classA = classA;
    }

    public Integer getClassB() {
        return classB;
    }

    public void setClassB(Integer classB) {
        this.classB = classB;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getIsLive() {
        return isLive;
    }

    public void setIsLive(Integer isLive) {
        this.isLive = isLive;
    }

    public Integer getHandleId() {
        return handleId;
    }

    public void setHandleId(Integer handleId) {
        this.handleId = handleId;
    }

    public String getHandleResult() {
        return handleResult;
    }

    public void setHandleResult(String handleResult) {
        this.handleResult = handleResult;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Integer getStatus2() {
        return status2;
    }

    public void setStatus2(Integer status2) {
        this.status2 = status2;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public ArrayList<Integer> getUserIds() {
        return userIds;
    }

    public void setUserIds(ArrayList<Integer> userIds) {
        this.userIds = userIds;
    }
}
