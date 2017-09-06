package kr.groupware.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.Optional;

import kr.groupware.model.member.MemberData;
import kr.groupware.model.member.MemberSv;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
        locations={
                "classpath:common.xml",
                "classpath:db.xml"
        }
)
public class memberTest {
    @Autowired MemberSv memberSv;
    @Test
    public void Test(){
        MemberData memberData=new MemberData();
        memberData.setMemberId("test123");
        memberData.setPw("1234");
        memberData.setName("test");
        memberData.setPositionNo(1);
        memberData.setSpotNo(1);
        memberData.setDepartmentNo(1);
        memberData.setEmail("test@test.com");
        memberData.setEntryDate(new Date());
        memberData.setModifyDate(new Date());
        memberData.setRegistrationDate(new Date());
        memberData.setLastAccessTime(new Date());
        memberData.setUsed(true);
        memberData.setSecurityRating(3);
        memberData.setBusinessNo("2017-0529");
        memberSv.addMember(memberData);


    }

    @Test
    public void test2(){
        int page = 22;
        int countList = 10;
        int countPage = 10;

        int totalCount = 255;

        int totalPage = totalCount / countList;

        if (totalCount % countList > 0) {
            totalPage++;
        }

        if (totalPage < page) {
            page = totalPage;
        }

        int startPage = ((page - 1) / 10) * 10 + 1;

        int endPage = startPage + countPage - 1;

        if (endPage > totalPage) {
            endPage = totalPage;
        }

        if (startPage > 1) {
            System.out.print("<a href=\"?page=1\">처음</a>");
        }

        if (page > 1) {
            System.out.println("<a href=\"?page=" + (page - 1)  + "\">이전</a>");
        }

        for (int iCount = startPage; iCount <= endPage; iCount++) {
            if (iCount == page) {
                System.out.print(" <b>" + iCount + "</b>");
            } else {
                System.out.print(" " + iCount + " ");
            }
        }
        if (page < totalPage) {
            System.out.println("<a href=\"?page=" + (page + 1)  + "\">다음</a>");
        }
        if (endPage < totalPage) {
            System.out.print("<a href=\"?page=" + totalPage + "\">끝</a>");
        }
    }
}
