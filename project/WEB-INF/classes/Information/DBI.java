package Information;

public class DBI {

   private static DBI instance;

   private String url;
   private String host;
   private String id;
   private String pwd;
   private String dbName;

   public DBI() {
      this.url = null;
      this.host = null;
      this.id = null;
      this.pwd = null;
      this.dbName = null;
   }

   public DBI(String host, String dbName, String id, String pwd) {
      this.host = host;
      this.dbName = dbName;
      this.id = id;
      this.pwd = pwd;
      this.url = "jdbc:mysql://"+host+":3306/"+dbName;
   }

   public static DBI getInstance(String host, String dbName, String id, String pwd) {
      if (instance != null) {
         if (instance.getHost() != host && instance.getDbName() != dbName) {
            instance = new DBI(host, dbName, id, pwd);
         }
      } else {
         instance = new DBI(host, dbName, id, pwd);
      }
      return instance;
   }

   public String getId() {
      return this.id;
   }
   public String getPwd() {
      return this.pwd;
   }
   public String getHost() {
      return this.host;
   }
   public String getUrl() {
      return this.url;
   }
   public String getDbName() {
      return this.dbName;
   }
}
