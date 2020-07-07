package com.ssm.model;

public class OrderModel extends Base{

    private static OrderModel model = new OrderModel();

    public static OrderModel getInstanceBase(){
        try {
            return (OrderModel)model.clone();
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
        return new OrderModel();
    }

    //编号
    private String orderNum;
    //申请人id
    private String applicantId;
    //咨询标题
    private String title;
    //咨询详述
    private String detail;
    //咨询一级分类
    private String classA;
    //咨询二级分类
    private String classB;
    //资讯来源
    private String source;
    //答复内容
    private String content;
    //是否现场处理(0:否;1:是)
    private String isLive;
    //现场处理人id
    private String handleId;
    //现场处理结果
    private String handleResult;
    //运维处理状态(0:未处理;1:已处理)
    private String status;
    //工单生成时间
    private String endTime;
    //工单受理结束时间
    private String startTime;
    //管理员检查处理状态(0:未处理;1:已处理)
    private String status2;
    private String userId;
    private String phoneNum;

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public String getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(String applicantId) {
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

    public String getClassA() {
        return classA;
    }

    public void setClassA(String classA) {
        this.classA = classA;
    }

    public String getClassB() {
        return classB;
    }

    public void setClassB(String classB) {
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

    public String getIsLive() {
        return isLive;
    }

    public void setIsLive(String isLive) {
        this.isLive = isLive;
    }

    public String getHandleId() {
        return handleId;
    }

    public void setHandleId(String handleId) {
        this.handleId = handleId;
    }

    public String getHandleResult() {
        return handleResult;
    }

    public void setHandleResult(String handleResult) {
        this.handleResult = handleResult;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getStatus2() {
        return status2;
    }

    public void setStatus2(String status2) {
        this.status2 = status2;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public OrderModel() {
    }


}
