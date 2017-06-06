package Service;

import DB.*;
import Information.Bread;
import Error.*;

public class BreadFix {
   public BreadFix(){}

   public static boolean add(DBManager myDB, Bread bread) throws ErrorJsp {
      boolean result = false;

      try {
         DBQuery.insert(
         myDB.getConnection(),
         "insert into bread values (?,?,?)",
         new String[] {
            bread.getUid(),
            bread.getName(),
            Integer.toString(bread.getPrice())
         }
         );

         result = true;

      } catch (Exception e) {
         throw new ErrorJsp(e, BreadFix.class, "add");
      }

      return result;
   }

   public static boolean fix(DBManager myDB, Bread to) throws ErrorJsp {
      boolean result = false;

      try {
         DBQuery.update(
         myDB.getConnection(),
         "update bread set price=? where uid=? and name=?",
         new String[] {
            Integer.toString(to.getPrice()),
            to.getUid(),
            to.getName()
         }
         );

         result = true;
      } catch (ErrorJsp e) {
         throw new ErrorJsp(e, BreadFix.class, "fix");
      }

      return result;
   }
}
