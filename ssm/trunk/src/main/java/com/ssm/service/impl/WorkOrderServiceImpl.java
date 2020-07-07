package com.ssm.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.ssm.dao.EmployeeDao;
import com.ssm.dao.UserDao;
import com.ssm.dao.WorkOrderDao;
import com.ssm.model.*;
import com.ssm.service.WorkOrderService;
import com.ssm.util.ApplicantUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service("workOrderService")
public class WorkOrderServiceImpl implements WorkOrderService {


    @Autowired
    private WorkOrderDao workOrderDao;
    @Autowired
    private EmployeeDao employeeDao;
    @Autowired
    private UserDao userDao;

    @Override
    public List<TotalOrder> selectOrderTotalNum(Order order) {
        int count = workOrderDao.selectCount(order);
        List<TotalOrder> list1 = workOrderDao.selectOrderTotalNumA(order);
        List<TotalOrder> list2 = workOrderDao.selectOrderTotalNumB(order);
        List<TotalOrder> list = new ArrayList<>();
        int size = list1.size();
        int size1 = list2.size();
        TotalOrder totalOrder1 = TotalOrder.getInstanceBase();
        totalOrder1.setClassName("---------");
        for (int i = 0; i < size; i++) {
        list.add(list1.get(i));
            for (int j = 0; j < size1; j++) {
                if(list1.get(i).getId()==list2.get(j).getId()){
                    list.add(list2.get(j));
                }
            }
            list.add(totalOrder1);
        }
       /* for (TotalOrder totalOrder : list2) {
            list1.add(totalOrder);
        }*/
        TotalOrder totalOrder = TotalOrder.getInstanceBase();
        totalOrder.setClassName("总条数");
        totalOrder.setNumber(count);
        list.add(totalOrder);
        return list;
    }

    @Override
    public Consult selectClassById(int id) {
        return workOrderDao.selectClassById(id);
    }
    @Transactional
    @Override
    public void closeAll(List<String> arr,int id) {
        //Order order = new Order();
        Timestamp ts = ApplicantUtil.reverseDate();
        //order.setStartTime(ts);
        workOrderDao.closeAll(arr,ts,id);
    }

    @Override
    public List<Consult> selectClassA() {
        return workOrderDao.selectClassA();
    }

    @Override
    public List<Consult> selectClassB(String id) {
        return workOrderDao.selectClassB(id);
    }

    private List<ApplicantModel> reverseModel(List<Applicant> list){
        List<ApplicantModel> models = new ArrayList<>();
        List<Dept> deptList = employeeDao.selectDept();
        for (Applicant applicant: list) {
            ApplicantModel applicantModel = ApplicantUtil.reverseApplicant(applicant, deptList);
            models.add(applicantModel);
        }
        return models;
    }
    @Override
    public List<ApplicantModel> selectApplicant() {
        List<ApplicantModel> models = reverseModel(workOrderDao.selectApplicant());
        return models;
    }

    @Override
    public List<ApplicantModel> selectApplicantByP(String phoneNum) {
        List<ApplicantModel> models = reverseModel(workOrderDao.selectApplicantByP(phoneNum));
        return models;
    }

    @Override
    public List<Applicant> selectApplicantL() {
        return workOrderDao.selectApplicantL();
    }

    @Override
    public Applicant selectApplicantById(int id) {
        return workOrderDao.selectApplicantById(id);
    }

    //OrderConsultUser转换成order
    public static Order reverseOrderCU(OrderConsultUser orderConsultUser){
        //Order order = new Order();
        Order order = Order.getInstanceBase();
        order.setId(orderConsultUser.getId());
        order.setApplicantId(orderConsultUser.getApplicantId());
        order.setClassA(orderConsultUser.getClassA());
        order.setClassB(orderConsultUser.getClassB());
        order.setContent(orderConsultUser.getContent());
        order.setDetail(orderConsultUser.getDetail());
        order.setEndTime(orderConsultUser.getEndTime());
        order.setHandleId(orderConsultUser.getHandleId());
        order.setHandleResult(orderConsultUser.getHandleResult());
        order.setIsLive(orderConsultUser.getIsLive());
        order.setOrderNum(orderConsultUser.getOrderNum());
        order.setSource(orderConsultUser.getSource());
        order.setStartTime(orderConsultUser.getStartTime());
        order.setStatus(orderConsultUser.getStatus());
        order.setStatus2(orderConsultUser.getStatus2());
        order.setTitle(orderConsultUser.getTitle());
        order.setName(orderConsultUser.getName());
        order.setUserId(orderConsultUser.getUserId());
        order.setCodeNum(orderConsultUser.getCodeNum());
        order.setPhoneNum(orderConsultUser.getPhoneNum());
        order.setDepartmentName(orderConsultUser.getDepartmentName());
        order.setCompany(orderConsultUser.getCompany());
        order.setApplicantName(orderConsultUser.getApplicantName());
        return order;
    }
    //JSONObject转换成order
    public static Order reverseOrderCU2(JSONObject orderConsultUser){
       // Order order = new Order();

        Order order = Order.getInstanceBase();
        order.setId(Integer.parseInt(orderConsultUser.getString("id")));
        order.setApplicantId(Integer.parseInt(orderConsultUser.getString("applicantId")));
        order.setClassA(Integer.parseInt(orderConsultUser.getString("classA")));
        order.setClassB(Integer.parseInt(orderConsultUser.getString("classB")));
        order.setContent(orderConsultUser.getString("contaddent"));
        order.setDetail(orderConsultUser.getString("detail"));
        if(orderConsultUser.getString("handleId")!=null && orderConsultUser.getString("handleId")!=""){
            order.setHandleId(Integer.parseInt(orderConsultUser.getString("handleId")));
        }
        order.setHandleResult(orderConsultUser.getString("handleResult"));
        order.setIsLive(Integer.parseInt(orderConsultUser.getString("isLive")));
        order.setOrderNum(orderConsultUser.getString("orderNum"));
        order.setSource(orderConsultUser.getString("source"));
        order.setTitle(orderConsultUser.getString("title"));
        order.setCodeNum(orderConsultUser.getString("codeNum"));
        order.setPhoneNum(orderConsultUser.getString("phoneNum"));
        order.setDepartmentName(orderConsultUser.getString("departmentName"));
        order.setCompany(orderConsultUser.getString("company"));
        order.setApplicantName(orderConsultUser.getString("applicant"));
        return order;
    }
    @Transactional
    @Override
    public void add(OrderConsultUser orderConsultUser) {
        Order order = reverseOrderCU(orderConsultUser);
        Timestamp ts = ApplicantUtil.reverseDate();
        order.setStartTime(ts);
        /*if(order.getIsLive()==0){
            order.setEndTime(ts);
            order.setStatus(0);
        }else {
            order.setStatus(0);
        }


                                if(order['isLive'] == 0){
                                    html+='<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: red; background:grey" disabled>' +
                                        '<input type="button" value="修改" id = "update" onclick="update(\'' + order['id'] + '\')" style="color: blue"> ' +
                                        '<input type="button" id = "delete" onclick="delete1(\'' + order['id'] + '\')" value="删除" style="color: red">'+
                                        '</td>' +
                                        '</tr>';
                                }else {
                                html+='<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: red">' +
                                    '<input type="button" value="修改" id = "update" onclick="update(\'' + order['id'] + '\')" style="color: blue"> ' +
                                    '<input type="button" id = "delete" onclick="delete1(\'' + order['id'] + '\')" value="删除" style="color: red">'+
                                    '</td>' +
                                    '</tr>';
                                }

        */
        order.setStatus(0);
        workOrderDao.add(order);
    }
    @Transactional
    @Override
    public void update(JSONObject orderConsultUser) {
        Order order = reverseOrderCU2(orderConsultUser);
        workOrderDao.update(order);
    }

    @Override
    public Order selectById(int id) {
        return workOrderDao.selectById(id);
    }
    @Transactional
    @Override
    public void delete(int id) {
        //Order order = new Order();
        Order order = Order.getInstanceBase();
        order.setId(id);
        workOrderDao.delete(order);
    }

    @Override
    public Pagination selectOrderByUser(Order order,String pageNum,String pageSize) {

        Integer pageNo = Integer.parseInt("1");
        if(pageNum!=null&&!("").equals(pageNum)){
            pageNo = Integer.parseInt(pageNum);
        }

        Integer pageSize1 = Integer.parseInt(pageSize);
        Integer pageNo1 = Pagination.cpn(pageNo);
        Integer start = (pageNo1-1)*pageSize1;
        Integer count = workOrderDao.selectCount(order);
        List<Order> orders = workOrderDao.selectOrderByUser(order,start,pageSize1);


        //List<?> orders = pagination.getList();

        List<OrderModel> orderModels = new ArrayList<OrderModel>();

        for (int i = 0; i < orders.size(); i++) {

            OrderModel model = OrderModel.getInstanceBase();
            //序号
            model.setName(String.valueOf(i+1));
            Order order1 = (Order)orders.get(i);
            User user = userDao.getById(order1.getUserId());
            model.setUserId(user.getName());
            model.setApplicantId(order1.getApplicantName());

            Consult consultA = workOrderDao.selectClassById(order1.getClassA());
            Consult consultB = workOrderDao.selectClassById(order1.getClassB());
            model.setClassA(consultA.getName());
            model.setClassB(consultB.getName());
            model.setContent(order1.getContent());
            model.setDetail(order1.getDetail());

            if (order1.getIsLive()!=0){
                if (order1.getStatus()==1){

                    User userOne = userDao.getById(order1.getHandleId());
                    model.setHandleId(userOne.getName());
                    model.setHandleResult("已处理");
                }else {
                    model.setHandleId("");
                    model.setHandleResult("未处理");
                }
            }else {
                model.setHandleId("");
                model.setHandleResult("");
            }
            model.setSource(order1.getSource());
            model.setTitle(order1.getTitle());
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            if(order1.getEndTime()!=null && !("").equals(order1.getEndTime())){
                model.setEndTime(dateFormat.format(order1.getEndTime()));
            }else{
                model.setEndTime("");
            }


            if(order1.getStartTime()!=null && !("").equals(order1.getStartTime())){
                model.setStartTime(dateFormat.format(order1.getStartTime()));
            }
            model.setOrderNum(order1.getOrderNum());
            model.setStatus(String.valueOf(order1.getStatus()));
            model.setStatus2(String.valueOf(order1.getStatus2()));
            model.setId(order1.getId());
            model.setIsLive(String.valueOf(order1.getIsLive()));
            orderModels.add(model);
        }
        Pagination pagination = new Pagination(pageNo1, pageSize1, count, orderModels);

        return pagination;
    }


}
