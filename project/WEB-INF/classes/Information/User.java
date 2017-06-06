package Information;

public class User {
   protected String uid;
   protected String pwd;
   protected int auth;

   public User(String uid, String pwd, int auth) {
      this.uid = uid;
      this.pwd = pwd;
      this.auth = auth;
   }

   public String[] toStringArray() {
      return new String[] {
         uid, pwd, Integer.toString(auth)
      };
   }

   public String getUid() {
      return this.uid;
   }
   public void setUid(String uid) {
      this.uid = uid;
   }

   public String getPwd() {
      return this.pwd;
   }
   public void setPwd(String pwd) {
      this.pwd = pwd;
   }

   public int getAuth() {
      return this.auth;
   }
   public void setAuth(int auth) {
      this.auth = auth;
   }
}
