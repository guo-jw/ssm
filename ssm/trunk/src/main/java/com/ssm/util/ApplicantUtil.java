package com.ssm.util;

import com.ssm.model.Applicant;
import com.ssm.model.ApplicantModel;
import com.ssm.model.Dept;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class ApplicantUtil {
   public static ApplicantModel reverseApplicant(Applicant applicant, List<Dept> deptList){
       ApplicantModel applicantModel = new ApplicantModel();
       applicantModel.setId(applicant.getId());
       applicantModel.setName(applicant.getName());
       applicantModel.setPhoneNum(applicant.getPhoneNum());
       applicantModel.setCompany(applicant.getCompany());
       applicantModel.setCodeNum(applicant.getCodeNum());
       for (Dept dept:deptList) {
           if(dept.getId()==applicant.getDepartmentId()){
               applicantModel.setDepartmentName(dept.getDeptName());
               }
           }
        return applicantModel;
    }
    public static Timestamp reverseDate(){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        try {
            date = dateFormat.parse(dateFormat.format(date));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Timestamp ts = new Timestamp(date.getTime());
        return ts;
    }
}
