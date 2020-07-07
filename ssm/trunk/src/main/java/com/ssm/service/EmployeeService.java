package com.ssm.service;

import com.alibaba.fastjson.JSONObject;
import com.ssm.model.Applicant;
import com.ssm.model.Dept;
import com.ssm.model.Pagination;

import java.util.List;

public interface EmployeeService {

    //查询部门信息
    List<Dept> selectDept();
    //新增员工
    void add(Applicant applicant);
    //修改员工
    void update(JSONObject applicant);
    //跳转到修改页面(根据主键查询详细信息)
    Applicant selectById(int id);
    //删除员工
    void delete(int id);

    //查询员工
    Pagination selectApplicant(Applicant applicant, String pageNum, String pageSize);
    //根据id查询申请人信息
    Applicant selectApplicantById(int id);
}
