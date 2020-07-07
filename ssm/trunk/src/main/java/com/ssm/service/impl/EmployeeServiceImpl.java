package com.ssm.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.ssm.dao.EmployeeDao;
import com.ssm.model.Applicant;
import com.ssm.model.ApplicantModel;
import com.ssm.model.Dept;
import com.ssm.model.Pagination;
import com.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeDao employeeDao;

    @Override
    public List<Dept> selectDept() {
        return employeeDao.selectDept();
    }
    @Transactional
    @Override
    public void add(Applicant applicant) {
        employeeDao.add(applicant);
    }

    private Applicant reverseJSON(JSONObject applicant){
        Applicant applicant1 = new Applicant();
        if(applicant.getString("id")!=null && applicant.getString("id")!=""){
            applicant1.setId(Integer.parseInt(applicant.getString("id")));
        }
        applicant1.setName(applicant.getString("name"));
        if(applicant.getString("departmentId")!=null && applicant.getString("departmentId")!=""){
            applicant1.setDepartmentId(Integer.parseInt(applicant.getString("departmentId")));
        }
        applicant1.setCodeNum(applicant.getString("codeNum"));
        applicant1.setCompany(applicant.getString("company"));
        applicant1.setPhoneNum(applicant.getString("phoneNum"));
        return applicant1;
    }
    @Transactional
    @Override
    public void update(JSONObject applicant) {
        Applicant applicant1 = reverseJSON(applicant);
        employeeDao.update(applicant1);
    }

    @Override
    public Applicant selectById(int id) {
        return employeeDao.selectById(id);
    }
    @Transactional
    @Override
    public void delete(int id) {
        employeeDao.delete(id);
    }

    @Override
    public Pagination selectApplicant(Applicant applicant, String pageNum, String pageSize) {

        Integer pageNo = Integer.parseInt("1");
        if(pageNum!=null&&!("").equals(pageNum)){
            pageNo = Integer.parseInt(pageNum);
        }
        Integer pageSize1 = Integer.parseInt(pageSize);
        Integer pageNo1 = Pagination.cpn(pageNo);
        Integer start = (pageNo1-1)*pageSize1;
        Integer count = employeeDao.selectCount(applicant);


        List<Applicant> applicants = employeeDao.selectApplicant(applicant,start,pageSize1);
        List<Dept> deptList = employeeDao.selectDept();
        List<ApplicantModel> list = new ArrayList<>();
        for (int i = 0; i < applicants.size(); i++) {
            ApplicantModel applicantModel = new ApplicantModel();
            applicantModel.setNumber(String.valueOf(i+1));
            applicantModel.setId(applicants.get(i).getId());
            applicantModel.setName(applicants.get(i).getName());
            applicantModel.setCodeNum(applicants.get(i).getCodeNum());
            applicantModel.setCompany(applicants.get(i).getCompany());
            applicantModel.setPhoneNum(applicants.get(i).getPhoneNum());
            for (Dept  dept : deptList) {
                if(applicants.get(i).getDepartmentId()==dept.getId()){
                    applicantModel.setDepartmentName(dept.getDeptName());
                    break;
                }else{
                    applicantModel.setDepartmentName("");
                }
            }
            list.add(applicantModel);
        }

        Pagination pagination = new Pagination(pageNo1, pageSize1, count, list);
        return pagination;
    }



    @Override
    public Applicant selectApplicantById(int id) {
        return employeeDao.selectApplicantById(id);
    }





}
