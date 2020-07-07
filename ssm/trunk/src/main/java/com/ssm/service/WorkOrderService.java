package com.ssm.service;

import com.alibaba.fastjson.JSONObject;
import com.ssm.model.*;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.util.List;

public interface WorkOrderService {
    //新增工单
    void add(OrderConsultUser orderConsultUser);
    //修改工单
    void update(JSONObject orderConsultUser);
    //跳转到修改页面(根据主键查询详细信息)
    Order selectById(int id);
    //删除工单
    void delete(int id);
    //查询工单
    Pagination selectOrderByUser(Order order,String pageNum,String pageSize);
    //查询总条数
    //Integer selectCount(Order order);
    //查询一级分类
    List<Consult> selectClassA();
    //查询二级分类
    List<Consult> selectClassB(String id);
    //查询申请人信息
    List<ApplicantModel> selectApplicant();
    //根据电话模糊查询申请人信息
    List<ApplicantModel> selectApplicantByP(String phoneNum);
    //查询现场处理人信息
    List<Applicant> selectApplicantL();
    //根据id查询申请人信息
    Applicant selectApplicantById(int id);
    //根据id查询分类
    Consult selectClassById(int id);
    //关闭工单
    void closeAll(List<String> arr,int id);
    //统计工单数量
    List<TotalOrder> selectOrderTotalNum(Order order);
}
