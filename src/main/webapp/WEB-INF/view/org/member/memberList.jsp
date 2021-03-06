<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sh" uri="/WEB-INF/tlds/shUtil.tld" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/view/menu.jsp"></jsp:include>

<script src='/bower_components/moment/min/moment.min.js'></script>

<script>
    $(document).ready(function () {
        $("#checkall").click(function () {
            if ($("#checkall").prop("checked")) {
                $("input[name=chkMember]").prop("checked", true);
            } else {
                $("input[name=chkMember]").prop("checked", false);
            }
        });
    });


    //    $(document).ready(function () {
    //        $("input[type=checkbox]").switchButton({
    //            on_label: '사용',
    //            off_label: '사용안함'
    //        });
    //    });

    function onPage(pageNo) {
        $("#pageNo").val(pageNo);

        location.href = "/org/member/memberList.do?" + $("#searchForm").serialize();
    }

    function changeArticlePerPage(v) {
        $("#searchForm [name='pageSize']").val(v);
        onPage(1);
    }

    function orderList(orderVal, orderAsc) {
        $("#searchForm [name='orderVal']").val(orderVal);
        $("#searchForm [name='orderAsc']").val(orderAsc);

        onPage(1);
    }

    function simplyModify() {
        var datas = "";

        $(
            "#memberForm input[type='checkbox'][name='chkMember']:checked").each(function () {
            var data = {
                'memberId': $(this).val(),
                "used": ($("#memberForm input[type='checkbox'][name='used_" + $(this).val() + "']:checked").length > 0),
                "securityRating": ($("#memberForm select[id='securityRating_" + $(this).val() + "'] option:selected")).val()
            };

            if(datas != "")
                datas += "###";

            datas += encodeURI(JSON.stringify(data));
        });

        console.dir(datas);

        $.ajax({
            type: "POST",
            url: "simplyModify.do",
            data: {"datas": datas},
            success: function (data, textStatus) {
                alert("수정되었습니다");
                location.reload();
            }
        });
    }


    function simplyDelete() {

        var datas = "";

        $(
            "#memberForm input[type='checkbox'][name='chkMember']:checked").each(function () {
            var data = {
                'memberId': $(this).val()
            };

            if (datas != "")
                datas += "###";

            datas += encodeURI(JSON.stringify(data));
        });

        console.dir(datas);

        $.ajax({
            type: "GET",
            url: "simplyDelete.do",
            data: {"datas": datas},
            success: function (data, textStatus) {
                alert("삭제되었습니다");
                location.reload();
            }
        });
    }

    function show_layer(memberId) {

        $.ajax({
            type: "GET",
            url: "getMemoList.do?memberId="+memberId,
            success: function (data, textStatus) {
                var lay_pop = $('#pop');
                var pos = $('#btn_pos').position();    // 버튼의 위치에 레이어를 띄우고자 할 경우, 위치 정보 가져옴
                lay_pop.css('top', (pos) + 'px');    // 레이어 위치 지정
                lay_pop.css('left', (pos) + 'px');
                lay_pop.fadeIn();
                lay_pop.focus();
            }
        });
    }

    $(document).ready(function() {
        $('#close').click(function() {
            $('#pop').hide();
        });
    });

    function insertMemo(form) {
        $.ajax({
            type:"POST",
            url:form.action,
            dataType:"html",
            data:$(form).serialize(),
            success:function (data,textStatus) {
                alert("등록되었습니다");
                location.reload();
            }
        });
    }
</script>

<style type="text/css">
    #pop{
        width:600px; height:200px; background:#3d3d3d; color:#fff;
        position:absolute; top:100px; left:100px; text-align:left;
        border:2px solid #000;
    }
</style>

<div id="page-wrapper">
    <div class="row">
        <!-- /.col-lg-6 -->
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    회원 목록
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="table-responsive">

                        <div class="btn-group">
                            <button class="btn btn-default btn-sm dropdown-toggle" type="button" data-toggle="dropdown"
                                    aria-expanded="false">
                                limit pageSize <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="javascript:changeArticlePerPage('10')">10개씩 보기</a></li>
                                <li><a href="javascript:changeArticlePerPage('20')">20개씩 보기</a></li>
                                <li><a href="javascript:changeArticlePerPage('50')">50개씩 보기</a></li>
                                <li><a href="javascript:changeArticlePerPage('100')">100개씩 보기</a></li>
                            </ul>

                            <a href="javascript:simplyModify()" class="btn btn-warning">수정</a>
                            <a href="javascript:simplyDelete()" class="btn btn-danger">삭제</a>
                        </div>

                        <form action="/org/member/memberList.do" name="memberForm" id="memberForm">
                            <table id="memberTable" class="table">
                                <jsp:include page="reloadMember.jsp"></jsp:include>
                            </table>
                        </form>
                    </div>
                    <!-- /.table-responsive -->
                </div>
                <!-- /.panel-body -->
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <form name="searchForm" id="searchForm" action="/org/member/memberList.do" class="form-inline">
                        <input type="hidden" name="pageNo" id="pageNo" value="${paging.currentPage}">
                        <input type="hidden" name="pageSize" value="${paging.articlesPerPage}">

                        <input type="hidden" name="orderAsc" value="${orderAsc}">
                        <input type="hidden" name="orderVal" value="${orderVal}">
                        <div style="border: 1px; float: left; width: 20%; ">

                            이름 <input type="text" name="se_name" class="form-control" value="${se_name}"
                                      placeholder="Search for name">
                        </div>
                        <div style="border: 1px; float: left; width: 20%; ">

                            아이디 <input type="text" name="se_memberId" class="form-control" value="${se_memberId}"
                                       placeholder="Search for memberId">
                        </div>
                        <div style="border: 1px; float: left; width: 20%; ">

                            이메일 <input type="text" name="se_email" class="form-control" value="${se_email}"
                                       placeholder="Search for email">
                        </div>

                        <div style="border: 1px; float: left; ">
                            <input type="submit" class="btn btn-default" value="찾기">
                        </div>
                        <div style="border: 1px; float: left; ">
                            <a href="/org/member/memberList.do" class="btn btn-primary">목록으로</a>
                        </div>
                    </form>

                    <div style="clear:both;"></div>

                    <sh:paging currentPage="${paging.currentPage}" totalArticles="${paging.totalArticles}"
                               showPages="${paging.showPages}" articlesPerPage="${paging.articlesPerPage}"/>

                    <div id="msgArea" style="display:none;position:absolute;">

                        <input type="button" href="#" class="btn btn-primary" value="등록">

                    </div>

                    <form id="popForm" method="post" action="insertMemo.do" onsubmit="insertMemo(this)" class="form-inline">
                    <div id="pop" style="display:none;position:absolute;">
                        <div style="height:370px;">
                            <input type="hidden" name="memberId" value="${memberId}">
                            <textarea name="memo" class="form-control" rows="3"></textarea>
                            <c:forEach items="${memoList}" var="memo">
                            <textarea name="memo" class="form-control" rows="3">${memo.memo}</textarea>
                            </c:forEach>

                            <input type="submit" class="btn btn-primary" value="write">
                            <button id="close" class="btn btn-danger" type='button'><b>close</b></button>
                        </div>
                    </div>
                    </form>
                </div><!-- /.col-lg-6 -->
            </div><!-- /row-->
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-6 -->
    </div>
</div>

<form name='modifyForm'>

</form>

<jsp:include page="/WEB-INF/view/bottom.jsp"></jsp:include>