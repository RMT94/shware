package kr.groupware.model.rank.department;

import java.util.List;

/**
 * Created by Lsh on 2017-05-30.
 */
public interface DepartmentSv {
    //    리스트 뿌리기
    List<DepartmentData> getDepartments();
    //    하나 가져온다
    DepartmentData getDepartment(int departmentNo);
    //    직책추가
    void addDepartment(DepartmentData departmentData);
    //    직책수정
    void modifyDepartment(DepartmentData departmentData);
    //    직책삭제
    void deleteDepartment(int departmentNo);
}
