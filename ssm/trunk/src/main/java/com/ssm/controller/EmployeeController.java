package com.ssm.controller;

import com.alibaba.fastjson.JSONObject;
import com.ssm.model.Applicant;
import com.ssm.model.Dept;
import com.ssm.model.Pagination;
import com.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    //查询部门信息
    @RequestMapping("/selectDept")
    @ResponseBody
    public Map<String, Object> selectDept(){
        Map<String, Object> map = new HashMap<String, Object>();
        List<Dept> deptList = employeeService.selectDept();
        map.put("deptList", deptList);
        return map;

    }

    //跳转到修改页面(根据主键查询详细信息)
    @RequestMapping("selectApplicantById")
    public ModelAndView selectApplicantById(String id) {
        ModelAndView mv = new ModelAndView("employee/employee_update");
        Applicant applicant = employeeService.selectApplicantById(Integer.parseInt(id));
        List<Dept> deptList = employeeService.selectDept();
        mv.addObject("deptList", deptList);
        mv.addObject("applicant",applicant);

        return mv;
    }



    //新增申请人
    @RequestMapping("add")
    @ResponseBody
    public String add(@RequestBody Applicant applicant, ServletRequest request) {

        try {
            employeeService.add(applicant);
            //System.err.println(applicant);
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
        return "success";
    }


    //查询申请人信息
    @RequestMapping("selectApplicant")
    @ResponseBody
    public Map<String, Object> selectApplicant(@RequestParam String name, @RequestParam String deptId,
                                               @RequestParam String pageNum,@RequestParam String pageSize) {
        Map<String, Object> map = new HashMap<String, Object>();

        Applicant applicant = new Applicant();
        applicant.setName(name);
        if(deptId!=null && deptId!=""){
            applicant.setDepartmentId(Integer.parseInt(deptId));
        }

        StringBuilder str = new StringBuilder();

        str.append("name=").append(name);
        str.append("&deptId=").append(deptId);
        str.append("&pageNum=").append(pageNum);
        str.append("&pageSize=").append(pageSize);

        try {
            Pagination pagination = employeeService.selectApplicant(applicant,pageNum,pageSize);
            String url = "/order/selectOrderByUser";
            pagination.pageView(url, str.toString());
            map.put("pagination", pagination);
            map.put("msg", "success");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg", "failed");
        }
        return map;
    }


    //修改工单
    @RequestMapping("update")
    @ResponseBody
    public String update(@RequestBody JSONObject applicant) {
        try {
            employeeService.update(applicant);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }

    //删除工单
    @RequestMapping("delete")
    @ResponseBody
    public String delete(String id) {

        try {
            employeeService.delete(Integer.parseInt(id));
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }
}
