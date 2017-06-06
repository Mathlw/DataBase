<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="DB.*" %>
<%@ page import="Service.*" %>
<%@ page import="Information.*" %>


<html lang="ko">
   <head>
      <meta charset="utf-8"/>
      <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->

      <link rel="icon" href="resources/image/favicon.ico" />
      <title>빵셔틀</title>
      <!-- 부트스트랩 -->
      <!-- 합쳐지고 최소화된 최신 CSS -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
      <!-- 부가적인 테마 -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
      <!-- Custom styles for this template -->
      <link href="resources/css/cover.css" rel="stylesheet"/>
      <link href="resources/css/breadManage.css" rel="stylesheet"/>

      <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
      <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
   </head>
   <body>
      <%-- 로그인 엑세스가 필요한 페이지 입니다. --%>
      <% if (session.getAttribute("auth") == null) response.sendRedirect("/BreadShuttle/"); %>
      <% request.setCharacterEncoding("UTF-8"); %>

      <%-- 상단 고정된 네비게이션 바 --%>
      <nav class="navbar navbar-inverse navbar-static-top">
         <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
               <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
               </button>
               <a class="navbar-brand" href="/BreadShuttle">빵셔틀</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
               <ul class="nav navbar-nav">
                  <li class="active"><a href="#">빵관리 <span class="sr-only">(current)</span></a></li>
               </ul>

               <ul class="nav navbar-nav navbar-right">
                  <li><a href="mypage">My page</a></li>
                  <li><a href="#" onclick="logOut()">Sign Out</a></li>
               </ul>
            </div><!-- /.navbar-collapse -->
         </div><!-- /.container-fluid -->
      </nav>
      <%-- / 상단 고정된 네비게이션 바 --%>

      <div class="container">

         <% DBManager db = new DBManager(DBI.getInstance("manycore.jbnu.ac.kr", "BreadShuttle", "db2016", "rlawhddlr123")); %>


         <div class="">
            <div class="table-head row">
               <div class="col-md-1">
                  #
               </div>
               <div class="col-md-4">
                  사진
               </div>
               <div class="col-md-4">
                  빵이름
               </div>
               <div class="col-md-3">
                  가격
               </div>
            </div>
            <%
            Bread[] breads = null;
            breads = GetInformation.breadsByID(db, (String) session.getAttribute("uid"));

            int i = 1;
            %>
            <div class="table-body row">
               <div class="row table-row">
                  <form class="form-inline" action="breadremove" method="post">
                     <input class="form-control" type="text" name="removebread" placeholder="삭제하려는 빵을 입력" required />
                     <button class="btn btn-danger" type="submit" name="button"><span class="glyphicon glyphicon-trash"></span></button>
                  </form>
               </div>
               <div id="table-row-0" class="row add-bread table-row" onclick="breadAdd()">
                  <span class="glyphicon glyphicon-plus"></span>
               </div>
               <%
            if (breads != null) {
               for (Bread bread : breads) {
                  %>
                  <div id="table-row-<%=i%>" class="row table-row" onclick="breadFix('<%=bread.getName()%>',<%=bread.getPrice()%>)">
                     <div class="col-md-1 table-cell-num">
                        <%= i++ %>
                     </div>
                     <div class="col-md-4 table-cell-image">
                        <img src="resources/image/<%=bread.getName()%>.jpg" alt="" height="140", width="140" class="img-rounded" />
                     </div>
                     <div class="col-md-4 table-cell-name">
                        <p><%= bread.getName() %></p>
                     </div>
                     <div class="col-md-3 table-cell-price">
                        <p><%= bread.getPrice() %>원</p>
                     </div>
                  </div>
                  <%
               }
            }
            %>
            </div>
            <%

            db.disConnect();
            %>
         </div>

      </div>

      <!-- bread add modal -->
      <div class="modal fade bread-modal" id="breadModal" tabindex="-1" role="dialog" aria-labelledby="breadModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" id="breadModalLabel">빵</h4>
               </div>
               <form action="/BreadShuttle/breadfix" class="form-signin" method="post" enctype="multipart/form-data">
                  <div class="modal-body">
                     <div class="row">
                        <img src="" alt="" height="200", width="140" class="img-rounded col-md-4 col-md-offset-4" />
                     </div>
                     <div class="form-group">
                        <label for="inputBreadImage">빵 사진</label>
                        <input id="inputBreadImage" type="file" name="breadimage" value="" class="" />
                     </div>
                     <div class="form-group">
                        <label for="inputBreadName">빵 이름</label>
                        <input type="text" name="breadname" id="inputBreadName" class="form-control" placeholder="빵 이름" required readonly />
                     </div>
                     <div class="form-group">
                        <label for="inputBreadPrice">빵 가격</label>
                        <input type="number" name="breadprice" id="inputBreadPrice" class="form-control" placeholder="0" required />
                     </div>
                  </div>
                  <div class="modal-footer">
                     <button id="btnFix" class="btn btn-lg btn-primary btn-block" type="submit">확인</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
      <%-- /bread add modal --%>

      <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
      <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
      <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
      <!-- Custom java script -->
      <script src="resources/js/logOut.js"></script>
      <script type="text/javascript">
         $('#brnRemove').on('click', function () {
            $('#remove').val('1');
         });
         function breadAdd() {
            $('#breadModal').modal('toggle');
            $('#breadModal').find('img').attr('src', '');
            $('#breadModal').find("#inputBreadName").val(null);
            $('#breadModal').find("#inputBreadPrice").val(null);
            $('#breadModal').find("#inputBreadImage").show();
         }
         function breadFix(breadName, breadPrice) {
            $('#breadModal').modal('toggle');
            $('#breadModal').find('img').attr('src', 'resources/image/'+breadName+'.jpg');
            $('#breadModal').find('#inputBreadName').val(breadName);
            $('#breadModal').find('#inputBreadPrice').val(breadPrice);
            $('#breadModal').find("#inputBreadImage").hide();
         }

         $('#inputBreadImage').on('change', function() {
            var fname = $('#inputBreadImage').val().split('\\').pop().split('.')[0];
            $("#breadModal").find('#inputBreadName').val(fname);
         });
      </script>
   </body>
</html>
