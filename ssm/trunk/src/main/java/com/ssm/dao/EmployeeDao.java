package com.ssm.dao;

import com.ssm.model.Applicant;
import com.ssm.model.Dept;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmployeeDao {

    //查询部门信息
    List<Dept> selectDept();
    //新增工单
    void add(Applicant applicant);
    //修改工单
    void update(Applicant applicant);
    //跳转到修改页面(根据主键查询详细信息)
    Applicant selectById(int id);
    //删除工单
    void delete(int id);
    //查询申请人信息
    List<Applicant> selectApplicant(@Param("applicant")Applicant applicant,@Param("start") Integer start, @Param("size")Integer pageSize);
    //查询总条数
    Integer selectCount(Applicant applicant);
    //根据id查询申请人信息
    Applicant selectApplicantById(int id);
}
