package DB;

import java.sql.*;
import Error.*;

public class DBQuery {

   public DBQuery() {}

   public static ResultSet getResultSet(Connection conn, String qry) throws ErrorJsp {
      PreparedStatement pst = null;
      ResultSet rs = null;
      try {
         if (conn != null) {
            pst = conn.prepareStatement(qry);
            rs = pst.executeQuery();
         }
      } catch (Exception e) {
         throw new ErrorJsp(e, DBQuery.class, "getResultSet simple");
      }
      return rs;
   }

   public static ResultSet getResultSet(Connection conn, String qry, String[] qsts) throws ErrorJsp {
      PreparedStatement pst = null;
      ResultSet rs = null;

      try {
         if (conn != null) {
            pst = conn.prepareStatement(qry);
            int i = 1;
            for (String qst : qsts) {
               pst.setString(i++, qst);
            }
            rs = pst.executeQuery();
         }
      } catch (Exception e) {
         throw new ErrorJsp(e, DBQuery.class, "getResultSet qsts");
      }
      return rs;
   }

   public static boolean insert(Connection conn, String qry, String[] qsts) throws ErrorJsp {
      PreparedStatement pst = null;
      boolean result = false;

      try {
         if (conn != null) {
            pst = conn.prepareStatement(qry);
            int i = 1;

            for (String qst : qsts) {
               pst.setString(i++, qst);
            }
            pst.executeUpdate();
            result = true;
         }
      } catch (Exception e) {
         throw new ErrorJsp(e, DBQuery.class, "insert");
      }

      return result;
   }

   public static boolean delete(Connection conn, String qry, String[] qsts) throws ErrorJsp {
      PreparedStatement pst = null;
      boolean result = false;

      try {
         if (conn != null) {
            pst = conn.prepareStatement(qry);
            int i = 1;

            for (String qst: qsts) {
               pst.setString(i++, qst);
            }
            pst.executeUpdate();
            result = true;
         }
      } catch (Exception e) {
         throw new ErrorJsp(e, DBQuery.class, "delete");
      }
      return result;
   }

   public static boolean update(Connection conn, String qry, String[] qsts) throws ErrorJsp {
      PreparedStatement pst = null;
      boolean result = false;

      try {
         if (conn != null) {
            pst = conn.prepareStatement(qry);
            int i = 1;

            for (String qst: qsts) {
               pst.setString(i++, qst);
            }
            pst.executeUpdate();
            result = true;
         }
      } catch (Exception e) {
         throw new ErrorJsp(e, DBQuery.class, "update");
      }
      return result;
   }
}
