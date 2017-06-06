package Service;

import Error.*;
import java.sql.ResultSet;
import Information.*;
import DB.*;

public class GetInformation {

   public static User userByID(DBManager myDB, String id) {
      User user = null;
      ResultSet rs = null;

      if (myDB != null) {
         try {
            String[] qsts = {id};
            rs = DBQuery
                  .getResultSet(
                     myDB.getConnection(),
                     "select * from user where uid = ?",
                     qsts
                  );

            rs.next();

            user = new User(
               rs.getString("uid"),
               null,
               rs.getInt("auth")
            );
         } catch (Exception e) {
            ErrorJsp error = new ErrorJsp(e, GetInformation.class, "userByID");
         }
      }
      return user;
   }

   public static BakeryAccount bakeryAccountByID(DBManager myDB, String id) {
      BakeryAccount bakeryAccount = null;
      ResultSet rs = null;

      if (myDB != null) {
         try {
            String[] qsts = {id};
            rs = DBQuery
                  .getResultSet(
                     myDB.getConnection(),
                     "select * from (user natural join bakery) natural join account where user.uid = ?",
                     qsts
                  );

            rs.next();

            bakeryAccount = new BakeryAccount(
               rs.getString("uid"),
               null,
               rs.getInt("auth"),
               rs.getString("name"),
               rs.getString("tel"),
               rs.getString("address"),
               rs.getString("bankname"),
               rs.getString("account"),
               rs.getInt("point")
            );
         } catch (Exception e) {
            ErrorJsp error = new ErrorJsp(e, GetInformation.class, "bakeryAccountByID");
         }
      }
      return bakeryAccount;
   }

   public static StudentAccount studentAccountByID(DBManager myDB, String id) {
      StudentAccount studentAccount = null;
      ResultSet rs = null;

      if (myDB != null) {
         try {
            String[] qsts = {id};
            rs = DBQuery
                  .getResultSet(
                     myDB.getConnection(),
                     "select * from (user natural join student) natural join account where user.uid = ?",
                     qsts
                  );

            rs.next();

            studentAccount = new StudentAccount(
               rs.getString("uid"),
               null,
               rs.getInt("auth"),
               rs.getString("name"),
               rs.getInt("grade"),
               rs.getInt("sclass"),
               rs.getInt("stnum"),
               rs.getString("tel"),
               rs.getString("bankname"),
               rs.getString("account"),
               rs.getInt("point")
            );
         } catch (Exception e) {
            ErrorJsp error = new ErrorJsp(e, GetInformation.class, "studentAccountByID");
         }
      }
      return studentAccount;
   }

   public static Student studentByID(DBManager myDB, String id) {
      Student student = null;
      ResultSet rs = null;

      if (myDB != null) {
         try {
            String[] qsts = {id};
            rs = DBQuery
                  .getResultSet(
                     myDB.getConnection(),
                     "select * from user natural join student where user.uid = ?",
                     qsts);

            rs.next();

            student = new Student(
               rs.getString("uid"),
               null,
               rs.getInt("auth"),
               rs.getString("name"),
               rs.getInt("grade"),
               rs.getInt("sclass"),
               rs.getInt("stnum"),
               rs.getString("tel")
            );
         } catch (Exception e) {
            ErrorJsp error = new ErrorJsp(e, GetInformation.class, "studentByID");
         }
      }
      return student;
   }

   public static Bakery bakeryByID(DBManager myDB, String id) {
      Bakery bakery = null;
      ResultSet rs = null;

      if (myDB != null) {
         try {
            String[] qsts = {id};
            rs = DBQuery
               .getResultSet(
                  myDB.getConnection(),
                  "select * from user natural join bakery where user.uid = ?",
                  qsts
               );

            rs.next();

            bakery = new Bakery(
               rs.getString("uid"),
               null,
               rs.getInt("auth"),
               rs.getString("name"),
               rs.getString("tel"),
               rs.getString("address")
            );
         } catch (Exception e) {
            ErrorJsp error = new ErrorJsp(e, GetInformation.class, "bakeryByID");
         }
      }

      return bakery;
   }

   public static Bread[] breadsByID(DBManager myDB, String id) {
      Bread[] breads = null;
      ResultSet rs = null;

      if (myDB != null) {
         try {
            String[] qsts = {id};
            rs = DBQuery
            .getResultSet(
               myDB.getConnection(),
               "select * from bread where uid = ? order by name",
               qsts
            );

            while (rs.next()) {
               breads = Bread.addElement(breads, new Bread(rs.getString("uid"), rs.getString("name"), rs.getInt("price")));
            }
         } catch (Exception e) {
            ErrorJsp error = new ErrorJsp(e, GetInformation.class, "breadsByID");
         }
      }
      return breads;
   }

   public static Order[] orderedBreadByID(DBManager myDB, String id) {
      Order[] orders = null;
      ResultSet rs = null;

      if (myDB != null) {
         try {
            String[] qsts = {id};
            rs = DBQuery
            .getResultSet(
               myDB.getConnection(),
               "select * from ordered where uid = ? order by deliverydate",
               qsts
            );

            while (rs.next()) {
               orders = Order.addElement(orders, new Order(rs.getString("bid"), rs.getString("uid"), rs.getString("breadname"), rs.getString("deliverydate"), rs.getString("oredereddate")));
            }
         } catch (Exception e) {
            ErrorJsp error = new ErrorJsp(e, GetInformation.class, "ordersByID");
         }
      }
      return orders;
   }


}
