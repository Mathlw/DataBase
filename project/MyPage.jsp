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
      <link href="resources/css/cover.css" rel="stylesheet" />
      <link href="resources/css/mypage.css" rel="stylesheet" />

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
      <% request.setCharacterEncoding("utf-8"); %>

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

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
               <ul class="nav navbar-nav">
                  <% if ((session.getAttribute("auth") != null) && ((int) session.getAttribute("auth") == 1)) { %>
                  <li><a class="nav-link" href="breadrequest">빵신청</a></li>
                  <% } else if ((session.getAttribute("auth") != null) && ((int) session.getAttribute("auth") == 2)) { %>
                  <li><a class="nav-link" href="breadmanage">빵관리</a></li>
                  <% } %>
               </ul>

               <ul class="nav navbar-nav navbar-right">
                  <% if (session.getAttribute("auth") == null) { %>
                  <li><a class="nav-link" href="" data-toggle="modal" data-target=".signup-modal">Sign Up</a></li>
                  <li><a class="nav-link" href="" data-toggle="modal" data-target=".signin-modal">Sign In</a></li>
                  <% } else { %>
                  <li class="active"><a href="mypage">My Page <span class="sr-only">(current)</span></a></li>
                  <li><a href="#" onclick="logOut()">Sign Out</a></li>
                  <% } %>
               </ul>
            </div><!-- /.navbar-collapse -->
         </div><!-- /.container-fluid -->
      </nav>
      <%-- / 상단 고정된 네비게이션 바 --%>


      <div class="container">
         <form action="/BreadShuttle/modify" method="post">

            <div class="form-group row">
               <label class="col-md-2 col-md-offset-2" for="inputEmail">이메일</label>
               <div class="col-md-5">
                  <input type="email" name="email" id="inputEmail" class="form-control" placeholder="breadshuttle@example.com" required autofocus="true" readonly/>
               </div>
            </div>

            <div class="form-group row">
               <label class="col-md-2 col-md-offset-2" for="inputName" id="inputNameLabel">이름</label>
               <div class="col-md-5">
                  <input type="text" name="name" id="inputName" class="form-control" placeholder="이름" required/>
               </div>
            </div>

            <%
            int auth = 0;
            User user = null;
            if (session.getAttribute("auth") != null) {
               DBManager db = new DBManager(DBI.getInstance("manycore.jbnu.ac.kr", "BreadShuttle", "db2016", "rlawhddlr123"));
               auth = (int) session.getAttribute("auth");

               if (auth == 1) {
                  // 학생 !
                  user = GetInformation.studentAccountByID(db, (String) session.getAttribute("uid"));
                  %>
                  <div class="form-group row">
                     <label class="col-md-2 col-md-offset-2" for="selectGrade">학년</label>
                     <div class="col-md-5">
                        <select class="form-control" id="selectGrade" name="grade">
                           <option value="1">1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                        </select>
                     </div>
                  </div>

                  <div class="form-group row">
                     <label class="col-md-2 col-md-offset-2" for="inputClass">반</label>
                     <div class="col-md-5">
                        <input type="number" name="class" id="inputClass" class="form-control" placeholder="1" required />
                     </div>
                  </div>

                  <div class="form-group row">
                     <label class="col-md-2 col-md-offset-2" for="inputStnum">번호</label>
                     <div class="col-md-5">
                        <input type="number" name="stnum" id="inputStnum" class="form-control" placeholder="1" required />
                     </div>
                  </div>

                  <div class="form-group row">
                     <label class="col-md-2 col-md-offset-2" for="inputTel">전화번호</label>
                     <div class="col-md-5">
                        <input type="tel" name="tel" id="inputTel" class="form-control" placeholder="010-1234-5678" required />
                     </div>
                  </div>
               <%
               } else if (auth == 2) {
                  // 빵집 !
                  user = GetInformation.bakeryAccountByID(db, (String) session.getAttribute("uid"));
                  %>
                  <div class="form-group row">
                     <label class="col-md-2 col-md-offset-2" for="inputTel">전화번호</label>
                     <div class="col-md-5">
                        <input type="tel" name="tel" id="inputTel" class="form-control" placeholder="010-1234-5678" required />
                     </div>
                     <div class="col-md-5">

                     </div>
                  </div>

                  <div class="form-group row">
                     <label class="col-md-2 col-md-offset-2" for="inputAddress">주소</label>
                     <div class="col-md-5">
                        <input type="text" name="address" id="inputAddress" class="form-control" placeholder="전북 전주시 덕진구 백제대로 567" />
                     </div>
                  </div>
                  <%
               }
               db.disConnect();
            } else {
               response.sendRedirect("/BreadShuttle");
            }
            %>
            <div class="form-group row">
               <label for="inputPassword" class="col-md-2 col-md-offset-2" for="inputBankName">은행</label>
               <div class="col-md-5">
                  <input type="text" name="bankName" id="inputBankName" class="form-control" placeholder="은행" required />
               </div>
            </div>

            <div class="form-group row">
               <label for="inputPassword" class="col-md-2 col-md-offset-2" for="inputAccount">계좌번호</label>
               <div class="col-md-5">
                  <input type="text" name="account" id="inputAccount" class="form-control" placeholder="계좌번호" required />
               </div>
            </div>

            <div class="form-group row">
               <label for="inputPassword" class="col-md-2 col-md-offset-2" for="inputPassword">비밀번호</label>
               <div class="col-md-5">
                  <input type="password" name="password" id="inputPassword" class="form-control" placeholder="비밀번호" required />
               </div>
            </div>

            <div class="form-group row">
               <button type="submit" name="submit" class="btn btn-primary col-md-2 col-md-offset-5">회원정보 수정</button>
            </div>
         </form>
      </div>

      <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
      <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
      <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
      <!-- Custom java script -->
      <script src="resources/js/logOut.js"></script>
      <script type="text/javascript">

         <% if (auth == 1) { %>
               // student
               $("#inputEmail").val("<%= ((StudentAccount) user).getUid() %>");
               $("#inputName").val("<%= ((StudentAccount) user).getName() %>");
               $("#selectGrade").val(<%= ((StudentAccount) user).getGrade() %>);
               $("#inputClass").val(<%= ((StudentAccount) user).getSClass() %>);
               $("#inputStnum").val(<%= ((StudentAccount) user).getStNum() %>);
               $("#inputTel").val("<%= ((StudentAccount) user).getTel() %>");
               $("#inputBankName").val("<%= ((StudentAccount) user).getBankName() %>");
               $("#inputAccount").val("<%= ((StudentAccount) user).getAccount() %>");
         <% } else { %>
               // bakery
               $("#inputEmail").val("<%= ((BakeryAccount) user).getUid() %>");
               $("#inputName").val("<%= ((BakeryAccount) user).getName() %>");
               $("#inputTel").val("<%= ((BakeryAccount) user).getTel() %>");
               $("#inputAddress").val("<%= ((BakeryAccount) user).getAddress() %>");
               $("#inputBankName").val("<%= ((BakeryAccount) user).getBankName() %>");
               $("#inputAccount").val("<%= ((BakeryAccount) user).getAccount() %>");
         <% } %>
      </script>
   </body>
</html>
