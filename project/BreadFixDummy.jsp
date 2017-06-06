<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="com.oreilly.servlet.*" %>

<%@ page import="DB.*" %>
<%@ page import="Information.*" %>
<%@ page import="Service.*" %>
<%@ page import="Error.*" %>
<%@ page import="java.io.File" %>


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

      <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
      <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
   </head>
   <body>
      <% request.setCharacterEncoding("utf-8"); %>

      <div class="">
         <%
         String saveDir = application.getRealPath("/resources/image/");
         int maxSize = 1024*1024*100;
         String encType = "UTF-8";

         MultipartRequest multipartRequest = new MultipartRequest(request, saveDir, maxSize, encType, new DefaultFileRenamePolicy());

         DBManager db = new DBManager(DBI.getInstance("manycore.jbnu.ac.kr", "BreadShuttle", "db2016", "rlawhddlr123"));



         Bread to = new Bread(
         (String) session.getAttribute("uid"),
         multipartRequest.getParameter("breadname"),
         Integer.parseInt(multipartRequest.getParameter("breadprice"))
         );

         File img = multipartRequest.getFile("breadimage");

         try {
            if (img == null) {
               BreadFix.fix(db, to);
            } else {
               BreadFix.add(db, to);
            }

         } catch (Exception e) {

            for (String s : to.toStringArray()) {
               out.println(s);
            }

         }

         db.disConnect();

         response.sendRedirect("/BreadShuttle/breadmanage");
         %>
      </div>

      <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
      <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
      <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
      <!-- Custom java script -->
   </body>
</html>
