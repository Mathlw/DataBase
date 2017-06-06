

$("input:radio").on("change", function() {
   var current = this.id;

   if (current == "stORba2") {
      // alert("빵집");
      $("#fgName").find("label").text("빵집 이름");
      $("#inputClassNum").removeAttr("required");
      $("#inputStnum").removeAttr("required");
      $("#arcodianAddress").find("input").attr("required");
      $("#arcodianStudent").collapse('hide');
      $("#arcodianAddress").collapse('show');
   } else {
      // 학생일 때
      $("#fgName").find("label").text("이름");
      $("#inputClassNum").attr('required', true);
      $("#inputStnum").attr('required', true);
      $("#arcodianAddress").find("input").removeAttr("required");
      $("#arcodianStudent").collapse('show');
      $("#arcodianAddress").collapse('hide');
   }
});

$("#signupForm").submit(function (event) {
   var pwd = $("#signupModal").find("#inputPassword").val();
   var pwdConfirm = $("#signupModal").find("#inputPasswordConfirm").val();
   var popover = $('[data-toggle="popover"]').popover();
   if (pwd != pwdConfirm) {
      popover.popover('show');
      return false;
   } else {
      popover.popover('hide');
   }
});
