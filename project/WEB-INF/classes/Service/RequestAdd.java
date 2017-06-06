package Service;

import Error.*;
import DB.*;

// 하드 코딩
public class RequestAdd {
   public RequestAdd(){}
   public static void add(DBManager db, String uid, String name, String date) throws Exception {
      try {
         DBQuery.insert(
            db.getConnection(),
            "insert into ordered values ('powerbread@google.com',?,?,?,'2016-01-01')",
            new String[] {
               uid, name, date
            }
         );
      } catch (Exception e) {
         throw e;
      }
   }

   public static void fix(DBManager db, String uid, String name, String date) throws Exception {
      try {
         DBQuery.insert(
            db.getConnection(),
            "update ordered set breadname=? where uid=? and deliverydate =?",
            new String[] {
               name, uid, date
            }
         );
      } catch (Exception e) {
         throw e;
      }
   }
}
