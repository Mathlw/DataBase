<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
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
      <link href="resources/css/breadRequest.css" rel="stylesheet"/>

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
      <%
      Calendar cal = Calendar.getInstance();

      String strYear = request.getParameter("year");
      String strMonth = request.getParameter("month");

      int year = cal.get(Calendar.YEAR);
      int month = cal.get(Calendar.MONTH);
      int date = cal.get(Calendar.DATE);

      if(strYear != null)
      {
         year = Integer.parseInt(strYear);
         month = Integer.parseInt(strMonth);
      }
      //년도/월 셋팅
      cal.set(year, month, 1);

      int startDay = cal.getMinimum(java.util.Calendar.DATE);
      int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
      int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
      int newLine = 0;

      //오늘 날짜 저장.
      Calendar todayCal = Calendar.getInstance();
      SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
      int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));


      // 빵정보
      DBManager db = new DBManager(DBI.getInstance("manycore.jbnu.ac.kr", "BreadShuttle", "db2016", "rlawhddlr123"));
      Order[] orders = GetInformation.orderedBreadByID(db, (String) session.getAttribute("uid"));

      %>

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
                  <li class="active"><a href="#">빵신청 <span class="sr-only">(current)</span></a></li>
                  <% } else if ((session.getAttribute("auth") != null) && ((int) session.getAttribute("auth") == 2)) { %>
                  <li><a class="nav-link" href="breadmanage">빵관리</a></li>
                  <% } %>
               </ul>

               <ul class="nav navbar-nav navbar-right">
                  <% if (session.getAttribute("auth") == null) { %>
                  <li><a class="nav-link" href="" data-toggle="modal" data-target=".signup-modal">Sign Up</a></li>
                  <li><a class="nav-link" href="" data-toggle="modal" data-target=".signin-modal">Sign In</a></li>
                  <% } else { %>
                  <li><a class="nav-link" href="mypage">My Page</a></li>
                  <li><a href="#" onclick="logOut()">Sign Out</a></li>
                  <% } %>
               </ul>
            </div><!-- /.navbar-collapse -->
         </div><!-- /.container-fluid -->
      </nav>
      <%-- / 상단 고정된 네비게이션 바 --%>

      <div class="container">

         <form name="calendarFrm" id="calendarFrm" action="" method="post">
            <div id="content">
            </form>
            <!--날짜 네비게이션  -->
            <table width="100%" border="0" cellspacing="1" cellpadding="1" id="KOO" bgcolor="#F3F9D7" style="border:1px solid #CED99C">

               <tr>
                  <td height="60">

                     <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                           <td height="10"></td>
                        </tr>

                        <tr>
                           <td align="center" >

                              <%=year%>년

                              <%=month+1%>월

                           </td>
                        </tr>
                     </table>

                  </td>
               </tr>
            </table>
            <br>
               <table border="0" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF">
                  <thead>
                     <tr bgcolor="#CECECE">
                        <td width='100px'>
                           <div align="center"><font color="red">일</font></div>
                        </form>
                     </td>
                     <td width='100px'>
                        <div align="center">월</div>
                     </form>
                  </td>
                  <td width='100px'>
                     <div align="center">화</div>
                  </form>
               </td>
               <td width='100px'>
                  <div align="center">수</div>
               </form>
            </td>
            <td width='100px'>
               <div align="center">목</div>
            </form>
         </td>
         <td width='100px'>
            <div align="center">금</div>
         </form>
      </td>
      <td width='100px'>
         <div align="center"><font color="#529dbc">토</font></div>
      </form>
   </td>
</tr>
</thead>
<tbody>
   <tr>
      <%

      //처음 빈공란 표시
      for(int index = 1; index < start ; index++ )
      {
         out.println("<td>&nbsp;</td>");
         newLine++;
      }

      for(int index = 1; index <= endDay; index++) {
         String color = "";

         if(newLine == 0){
            color = "RED";
         } else if(newLine == 6) {
            color = "#529dbc";
         } else {
            color = "BLACK";
         }

         // TODO: - 때리기

         String sUseDate = Integer.toString(year);
         sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
         sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);

         int iUseDate = Integer.parseInt(sUseDate);

         sUseDate = Integer.toString(year);
         sUseDate += "-";
         sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
         sUseDate += "-";
         sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);

         String backColor = "#EFEFEF";
         if(iUseDate == intToday) {
            backColor = "#c9c9c9";
         }
         String breadName = null;
         if (orders != null) {
            for (Order order : orders) {
               if (sUseDate.equals(order.getDeliveryDate())) {
                  breadName = order.getBreadName();
                  break;
               }
            }
         }
         out.println("<td onclick=\"dateClick('"+sUseDate+"','"+breadName+"')\" id=\"date"+index+"\" valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>");

         %>
         <font color='<%= color %>'>
         <%= index %>
         <br />
         <% if (breadName != null) {
            out.println(breadName);
         }
         %>

      </font>
      <%
      //기능 제거
      out.println("</td>");
      newLine++;

      if(newLine == 7)
      {
         out.println("</tr>");
         if(index <= endDay)
         {
            out.println("<tr>");
         }
         newLine=0;
      }
   }
   //마지막 공란 LOOP
   while(newLine > 0 && newLine < 7)
   {
      out.println("<td>&nbsp;</td>");
      newLine++;
   }
   %>
</tr>

</tbody>
</table>
</div>
</form>

</div>

<%-- sing up modal --%>
<div class="modal fade bread-modal" id="breadModal" tabindex="-1" role="dialog" aria-labelledby="breadModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <%-- TODO --%>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="breadModalLabel">빵</h4>
         </div>

         <form action="/BreadShuttle/brd" id="breadForm" class="form-horizontal" method="post">
            <div class="modal-body">

               <div class="breadModalImage" id="divBreadImage">
                  <img src="" id="breadImage" alt="" width="140" height="200" class="img-rounded">
               </div>

               <%-- <div>
                  <label for="selectBakery">빵집</label>
                  <select id="selectBakery" class="form-control" name=""> --%>
                     <%-- 현재 빵집을 뿌려주고 선택이 되면 id를 가져올 수 있도록 --%>
                     <%-- <%
                     String bakeryID = null;
                     %>
                  </select>

               </div> --%>

               <div>
                  <label for="inputDeliveryDate">날짜</label>
                  <input id='inputDate' class="form-control" type="text" name="date" value="" required />
               </div>

               <div id="divSelectBread">
                  <label for="selectBread">빵을 선택하세요</label>
                  <select id="selectBread" class="form-control" name="breadName">
                     <%
                     Bread[] breads = null;
                     breads = GetInformation.breadsByID(db, "powerbread@google.com");
                     if (breads != null) {
                        for (Bread bread : breads) {
                           out.println("<option value='"+bread.getName()+"'>"+bread.getName()+"</option>");
                        }
                     }
                     %>
                  </select>
               </div>

               <div id="divShowPrice">
                  <label for="inputSelect">가격</label>
                  <input id="inputBreadPrice" class="form-control" type="text" name="breadPrice" value="" readonly required>
               </div>
               <input id="addfix" type="text" name="addfix" class="hide" />

               <div class="modal-footer">
                  <button type="submit" name="submit" class="btn btn-primary">확인</button>
               </div>
            </form>
         </div>
      </div>
   </div>
   <%-- / sign up modal --%>

   <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
   <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
   <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
   <!-- Custom java script -->
   <script src="resources/js/logOut.js"></script>

   <script type="text/javascript">
   function dateClick(date, breadName) {
      if (breadName == 'null') {
         $('#addfix').val('add');
      } else {
         $('#addfix').val('fix');
         $('#breadImage').show();
         $('#breadImage').attr('src','resources/image/'+breadName+'.jpg');
      }
      $('#selectBread').val(breadName);
      $('#inputDate').val(date);
      $('#breadModal').modal('toggle');
   }

   $('#selectBread').on('change', function () {
      var bn = $('#selectBread').val();
      var price = 0;
      <%
      if (breads != null) {
         for (Bread bread : breads) {
            %> if ('<%=bread.getName()%>' == bn) {
               price = <%=bread.getPrice()%>;
            }
            <%
         }
      }
      %>
      $('#breadImage').attr('src','resources/image/'+bn+'.jpg');
      $('#inputBreadPrice').val(price);
   });
   </script>
</body>
</html>
