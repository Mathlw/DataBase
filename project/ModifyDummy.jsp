<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="DB.*" %>
<%@ page import="Service.*" %>
<%@ page import="Information.*" %>
<%@ page import="Error.*" %>

<html lang="ko">
   <head>
      <meta charset="utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
      <link rel="icon" href="resources/image/favicon.ico" />
      <title>빵셔틀</title>


      <!-- 합쳐지고 최소화된 최신 CSS -->
      <!-- 부트스트랩 -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />

      <!-- 부가적인 테마 -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css" />

      <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
      <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
   </head>
   <body>
      <%
      request.setCharacterEncoding("UTF-8");

      if (session.getAttribute("auth") != null) {
         DBManager db = new DBManager(DBI.getInstance("manycore.jbnu.ac.kr", "BreadShuttle", "db2016", "rlawhddlr123"));
         Modify modify = new Modify();
         int auth = (int) session.getAttribute("auth");
         User user = null;

         if (auth == 1) {
            // 학생
            try {
               user = new StudentAccount(
                  (String) request.getParameter("email"),
                  (String) request.getParameter("password"),
                  auth,
                  (String) request.getParameter("name"),
                  Integer.parseInt(request.getParameter("grade")),
                  Integer.parseInt(request.getParameter("class")),
                  Integer.parseInt(request.getParameter("stnum")),
                  (String) request.getParameter("tel"),
                  (String) request.getParameter("bankName"),
                  (String) request.getParameter("account"),
                  0
               );
               modify.user(db, user);
            } catch (ErrorJsp e) {
               out.println("<script>alert('"+e.getMessage()+"');");
               out.println("window.location.href = \"http://manycore.jbnu.ac.kr:8080/BreadShuttle/\";");
               out.println("</script>");
            }
         } else if (auth == 2) {
            // 빵집

         } else {
            // 오류
         }
         %>
         <script type="text/javascript">
            alert("정보 수정 완료.")
            window.location.href = "http://manycore.jbnu.ac.kr:8080/BreadShuttle/mypage";
         </script>
         <%

         db.disConnect();
      } else {
         %>
         <script type="text/javascript">
            window.location.href = "http://manycore.jbnu.ac.kr:8080/BreadShuttle/";
         </script>
         <%
      }
      %>


      <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
      <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
      <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
      <!-- Custom java script -->
   </body>
</html>
