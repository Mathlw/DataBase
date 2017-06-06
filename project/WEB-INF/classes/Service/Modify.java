package Service;

import DB.*;
import Error.*;
import Information.*;
import Service.*;

public class Modify {
   public Modify() {}

   public boolean user(DBManager myDB, User user) throws ErrorJsp {
      boolean result = false;
      Class c = user.getClass();
      LogIn login = new LogIn();

      if (c == StudentAccount.class) {
         try {
            StudentAccount st = (StudentAccount) user;
            login.auth(myDB, user.getUid(), user.getPwd());
            try {
               DBQuery.update(
                  myDB.getConnection(),
                  "update student set name=?,grade=?,sclass=?,stnum=?,tel=? where uid=?",
                  new String[] {
                     st.getName(),
                     Integer.toString(st.getGrade()),
                     Integer.toString(st.getSClass()),
                     Integer.toString(st.getStNum()),
                     st.getTel(),
                     st.getUid()
                  }
               );

               DBQuery.update(
                  myDB.getConnection(),
                  "update account set account=?,bankname=? where uid=?",
                  new String[] {
                     st.getAccount(),
                     st.getBankName(),
                     st.getUid()
                  }
               );

            } catch (ErrorJsp e) {
               throw new ErrorJsp("회원 정보가 중복 됩니다.");
            }
         } catch (ErrorJsp e) {
            throw new ErrorJsp("비밀번호를 확인해주세요.");
         }

         result = true;
      } else if (c == BakeryAccount.class) {
         try {
            BakeryAccount bk = (BakeryAccount) user;
            login.auth(myDB, user.getUid(), user.getPwd());
            try {
               DBQuery.update(
                  myDB.getConnection(),
                  "update bakery set name=?,tel=?,address=? where uid=?",
                  new String[] {
                     bk.getName(),
                     bk.getTel(),
                     bk.getAddress(),
                     bk.getUid()
                  }
               );

               DBQuery.update(
                  myDB.getConnection(),
                  "update account set account=?,bankname=? where uid=?",
                  new String[] {
                     bk.getAccount(),
                     bk.getBankName(),
                     bk.getUid()
                  }
               );

            } catch (ErrorJsp e) {
               throw new ErrorJsp("회원 정보가 중복 됩니다.");
            }
         } catch (ErrorJsp e) {
            throw new ErrorJsp("비밀번호를 확인해주세요.");
         }

         result = true;
      }

      return result;
   }
}
