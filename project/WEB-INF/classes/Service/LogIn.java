package Service;

import DB.*;
import Error.*;
import Information.*;
import java.sql.ResultSet;

public class LogIn {

   public LogIn() {}

   public User auth(DBManager myDB, String id, String pwd) throws ErrorJsp {
      int loginResult = 0;
      User user = null;
      ResultSet rs = null;
      GetInformation get = null;

      if (myDB != null) {
         try {
            String[] qsts = {id, pwd};
            rs = DBQuery
                  .getResultSet(
                     myDB.getConnection(),
                     "select auth from user where uid=? and pwd = password(?)",
                     qsts);
            rs.next();
            loginResult = rs.getInt(1);
            rs.close();

            get = new GetInformation();

            switch (loginResult) {
               case 1:
                  user = get.studentAccountByID(myDB, id);
                  break;
               case 2:
                  user = get.bakeryAccountByID(myDB, id);
                  break;
               case 3:
                  break;
               default :
                  break;
            }
         } catch(Exception e) {
            ErrorJsp error =  new ErrorJsp(e, LogIn.class, "auth");
         }
      }
      return user;
   }
}
