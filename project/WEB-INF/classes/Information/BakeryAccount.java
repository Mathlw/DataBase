package Information;

public class BakeryAccount extends Bakery {
   protected String bankName;
   protected String account;
   protected int point;

   public BakeryAccount(String uid, String pwd, int auth, String name, String tel, String address, String bankName, String account, int point) {
      super(uid, pwd, auth, name, tel, address);
      this.bankName = bankName;
      this.account = account;
      this.point = point;
   }

   public String[] toStringArray() {
      return new String[] {
         uid, pwd, Integer.toString(auth),
         name, tel, address,
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
