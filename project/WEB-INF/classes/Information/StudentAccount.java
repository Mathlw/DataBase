package Information;

public class StudentAccount extends Student {

   protected String bankName;
   protected String account;
   protected int point;

   public StudentAccount(String uid, String pwd, int auth, String name, int grade, int sclass, int stNum, String tel, String bankName, String account, int point) {
      super(uid, pwd, auth, name, grade, sclass, stNum, tel);
      this.bankName = bankName;
      this.account = account;
      this.point = point;
   }

   public String[] toStringArray() {
      return new String[] {
         uid, pwd, Integer.toString(auth),
         name, Integer.toString(grade), Integer.toString(sclass), Integer.toString(stNum), tel,
         bankName, account, Integer.toString(point)
      };
   }

   public String getBankName() {
      return this.bankName;
   }
   public void setBankName(String bankName) {
      this.bankName = bankName;
   }

   public String getAccount() {
      return this.account;
   }
   public void setAccount(String account) {
      this.account = account;
   }

   public int getPoint() {
      return this.point;
   }
   public void setPoint(int point) {
      this.point = point;
   }
}
