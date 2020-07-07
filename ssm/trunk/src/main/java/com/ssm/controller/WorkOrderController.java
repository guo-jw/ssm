package com.ssm.controller;

import com.alibaba.fastjson.JSONObject;
import com.ssm.model.*;
import com.ssm.service.EmployeeService;
import com.ssm.service.UserService;
import com.ssm.service.WorkOrderService;
import com.ssm.util.ApplicantUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/order")
public class WorkOrderController {
    @Autowired
    private WorkOrderService workOrderService;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private UserService userService;

    private ApplicantModel reverseModel(Applicant applicant){
        List<Dept> deptList = employeeService.selectDept();
        ApplicantModel applicantModel = ApplicantUtil.reverseApplicant(applicant, deptList);
        return applicantModel;
    }


    //统计工单数量
    @RequestMapping("selectOrderTotalNum")
    @ResponseBody
    public Map<String, Object> selectOrderTotalNum(@RequestParam String startTime ,@RequestParam String start2Time){
        Order order = new Order();
        if (startTime!=null&&!("").equals(startTime)){
            startTime = startTime + " 00:00:00";
            order.setStartTime(Timestamp.valueOf(startTime));
        }
        if (start2Time!=null&&!("").equals(start2Time)){
            start2Time = start2Time + " 23:59:59";
            order.setEndTime(Timestamp.valueOf(start2Time));
        }
        List<TotalOrder> total = workOrderService.selectOrderTotalNum(order);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", total);
        return map;
    }

    //批量关闭工单
    @RequestMapping("closeAll")
    @ResponseBody
    public String closeAll(@RequestBody List<String> arr,HttpSession session){
        User user2 = (User)session.getAttribute("user");
        int id = user2.getId();
        try {
            workOrderService.closeAll(arr,id);
            //System.err.println(arr);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }

    //跳转到修改页面(根据主键查询详细信息) https://desktop-k4ijvo3:8443/svn/offcial/ssm/trunk  https://DESKTOP-R9MAU70/svn/workorder/
    @RequestMapping("selectById")
    public ModelAndView selectById(String id,String tag) {
        ModelAndView mv = new ModelAndView();
        //查询工单信息
        Order order = workOrderService.selectById(Integer.parseInt(id));
        List<User> users = userService.selectByRole();
        //查询类别一
        List<Consult> consults2 = selectClassA();
        //查询类别二
        List<Consult> consults1 = selectClassB1(String.valueOf(order.getClassA()));
        mv.addObject("order",order);
        mv.addObject("classAs",consults2);
        mv.addObject("classBs",consults1);
        mv.addObject("applicants1",users);
        if(tag.equals("1")){
            mv.setViewName("workorder/workorder_update");
        }else {
            mv.setViewName("workorder/workorder_detail");
        }
        return mv;
    }

    public List<Consult> selectClassA(){
        List<Consult> consultAs = workOrderService.selectClassA();
        return consultAs;
    }
    public List<Consult> selectClassB1(String id){
        List<Consult> consultBs = workOrderService.selectClassB(id);
        return consultBs;
    }



    //查询工单
    @RequestMapping("selectOrderByUser")
    @ResponseBody
    public Map<String, Object> select(@RequestParam String status,@RequestParam String source,@RequestParam String classA,@RequestParam String classB,
                                      @RequestParam String title ,@RequestParam String detail ,@RequestParam String phoneNum ,
                                      @RequestParam String isLive ,@RequestParam String startTime , @RequestParam String userName,
                                      @RequestParam String start2Time ,@RequestParam String pageNum,@RequestParam String pageSize,HttpSession session) {

        User user2 = (User)session.getAttribute("user");

        //根据联系方式查询
        Map<String, Object> map = new HashMap<String, Object>();
        Order order = new Order();

        //查询受理人主键ID
        if(userName!=null && !("").equals(userName)){

            User byUsername = userService.findByName(userName);
            if(byUsername!=null){

                order.setUserId(byUsername.getId());

            }else {
                order.setUserId(0);
            }
        }

        if (status!=null&&!("").equals(status)){
            order.setStatus(Integer.parseInt(status));
        }
        if (source!=null&&!("").equals(source)){
            order.setSource(source);
        }
        if (classA!=null&&!("").equals(classA)){
            order.setClassA(Integer.parseInt(classA));
        }

        if (classB!=null&&!("").equals(classB)){
            order.setClassB(Integer.parseInt(classB));
        }

        if (title!=null&&!("").equals(title)){
            order.setTitle(title);
        }
        if (isLive!=null&&!("").equals(isLive)){

            order.setIsLive(Integer.parseInt(isLive));
        }
        if (startTime!=null&&!("").equals(startTime)){
            startTime = startTime + " 00:00:00";
            //Timestamp ts = new Timestamp(startTime);
            order.setStartTime(Timestamp.valueOf(startTime));
        }
        if (start2Time!=null&&!("").equals(start2Time)){
            start2Time = start2Time + " 23:59:59";
            //Timestamp ts = new Timestamp(startTime);
            order.setEndTime(Timestamp.valueOf(start2Time));
        }

        if (detail!=null&&!("").equals(detail)){
            order.setDetail(detail);
        }

        if (phoneNum!=null&&!("").equals(phoneNum)){
            order.setPhoneNum(phoneNum);
        }

        if(user2.getRole()!=1&&user2.getRole()!=2){
            //order.setHandleId(user2.getId());
            order.setIsLive(1);
        }

        //以上是查询条件
        Pagination pagination = workOrderService.selectOrderByUser(order,pageNum,pageSize);

        StringBuilder str = new StringBuilder();
        str.append("status=").append(status);
        str.append("&source=").append(source);
        str.append("&classA=").append(classA);
        str.append("&classB=").append(classB);
        str.append("&title=").append(title);
        str.append("&detail=").append(detail);
        str.append("&phoneNum=").append(phoneNum);
        str.append("&isLive=").append(isLive);
        str.append("&startTime=").append(startTime);
        str.append("&userName=").append(userName);
        str.append("&start2Time=").append(start2Time);
        str.append("&pageNum=").append(pageNum);
        str.append("&pageSize=").append(pageSize);

        String url = "/order/selectOrderByUser";
        pagination.pageView(url, str.toString());


        map.put("pagination", pagination);
        map.put("user", user2);
        return map;
    }


    //新增工单
    @RequestMapping("add")
    @ResponseBody
    public String add(@RequestBody JSONObject  orderConsultUser, ServletRequest request) {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        try {
            OrderConsultUser consultUser = new OrderConsultUser();
            consultUser.setUserId(user.getId());
            consultUser.setTitle(orderConsultUser.getString("title"));
            if(orderConsultUser.getString("classA")!=null && !("").equals(orderConsultUser.getString("classA"))){
                consultUser.setClassA(Integer.parseInt(orderConsultUser.getString("classA")));
            }
            if(orderConsultUser.getString("classB")!=null && !("").equals(orderConsultUser.getString("classB"))){
                consultUser.setClassB(Integer.parseInt(orderConsultUser.getString("classB")));
            }
            if(orderConsultUser.getString("applicantId")!=null && !("").equals(orderConsultUser.getString("applicantId"))){
                consultUser.setApplicantId(Integer.parseInt(orderConsultUser.getString("applicantId")));
            }
            consultUser.setSource(orderConsultUser.getString("source"));
            consultUser.setContent(orderConsultUser.getString("content"));
            consultUser.setDetail(orderConsultUser.getString("detail"));
            if(orderConsultUser.getString("isLive")!=null && !("").equals(orderConsultUser.getString("isLive"))){
                consultUser.setIsLive(Integer.parseInt(orderConsultUser.getString("isLive")));
            }
            if(orderConsultUser.getString("handleId")!=null && !("").equals(orderConsultUser.getString("handleId"))){
                consultUser.setHandleId(Integer.parseInt(orderConsultUser.getString("handleId")));
            }

            consultUser.setCodeNum(orderConsultUser.getString("codeNum"));
            consultUser.setPhoneNum(orderConsultUser.getString("phoneNum"));
            consultUser.setDepartmentName(orderConsultUser.getString("departmentName"));
            consultUser.setCompany(orderConsultUser.getString("company"));
            consultUser.setApplicantName(orderConsultUser.getString("applicant"));

            workOrderService.add(consultUser);
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
        return "success";
    }

    //查询咨询一级分类
    @RequestMapping("selectClassA")
    @ResponseBody
    public Map<String, Object> selectClass() {
        Map<String, Object> map = new HashMap<String, Object>();
        List<Consult> consultAs = workOrderService.selectClassA();
        map.put("classAList", consultAs);
        return map;
    }

    //查询咨询二级分类
    @RequestMapping("selectClassB")
    @ResponseBody
    public Map<String, Object> selectClassB(@RequestParam String id) {
        Map<String, Object> mapB = new HashMap<String, Object>();
        List<Consult> consultBs = workOrderService.selectClassB(id);
        mapB.put("classBList", consultBs);
        return mapB;
    }

    //查询申请人信息
    @RequestMapping("selectApplicant")
    @ResponseBody
    public Map<String, Object> selectApplicant() {
        Map<String, Object> map = new HashMap<String, Object>();
        List<ApplicantModel> applicants = workOrderService.selectApplicant();
        map.put("applicants", applicants);
        return map;
    }
    //根据电话模糊查询申请人信息
    @RequestMapping("selectApplicantByP")
    @ResponseBody
    public Map<String, Object> selectApplicantByP(@RequestParam String phoneNum) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<ApplicantModel> applicants = workOrderService.selectApplicantByP(phoneNum);
        map.put("applicants", applicants);
        return map;
    }

    //查询现场处理人信息
    @RequestMapping("selectApplicantL")
    @ResponseBody
    public Map<String, Object> selectApplicantL() {
        Map<String, Object> map = new HashMap<String, Object>();
        List<User> users = userService.selectByRole();
        map.put("applicantLs",users);
        return map;
    }


    //修改工单
    @RequestMapping("update")
    @ResponseBody
    public String update(@RequestBody JSONObject orderConsultUser) {
        try {
            workOrderService.update(orderConsultUser);
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
            workOrderService.delete(Integer.parseInt(id));
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }
}
