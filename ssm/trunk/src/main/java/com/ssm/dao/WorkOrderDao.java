package com.ssm.dao;

import com.ssm.model.Applicant;
import com.ssm.model.Consult;
import com.ssm.model.Order;
import com.ssm.model.TotalOrder;
import org.apache.ibatis.annotations.Param;

import java.sql.Timestamp;
import java.util.List;

public interface WorkOrderDao {
    //新增工单
    void add(Order order);
    //修改工单
    void update(Order order);
    //跳转到修改页面(根据主键查询详细信息)
    Order selectById(int id);
    //删除工单
    void delete(Order order);
    //查询工单selectBrandsHavePage
    List<Order> selectOrderByUser(@Param("order") Order order,@Param("start") Integer pageStart,@Param("size") Integer pageSize);
    //查询总条数
    Integer selectCount(@Param("order")Order order);
    //查询一级分类
    List<Consult> selectClassA();
    //查询二级分类
    List<Consult> selectClassB(String id);
    //查询申请人信息
    List<Applicant> selectApplicant();
    //根据电话模糊查询申请人信息
    List<Applicant> selectApplicantByP(@Param("phoneNum") String phoneNum);
    //查询现场处理人信息
    List<Applicant> selectApplicantL();
    //根据id查询申请人信息
    Applicant selectApplicantById(int id);
    //根据id查询分类
    Consult selectClassById(int id);
    //关闭工单
    void closeAll(@Param("list")List<String> arr, @Param("endTime")Timestamp endTime,@Param("handleId")int id);
    //统计工单数量
    List<TotalOrder> selectOrderTotalNumA(@Param("order")Order order);
    List<TotalOrder> selectOrderTotalNumB(@Param("order")Order order);
}
