package Informaion;

public class Account {
   private String uid;
   private String bankName;
   private String account;

   public Account() {}
   public Account(String uid, String bankName, String account) {
      this.uid = uid;
      this.bankName = bankName;
      this.account = account;
   }

   public String[] toStringArray() {
      return new String[] {
         uid, bankName, account
      };
   }

   /***************************************************************************
   *  Getter and setter
   ***************************************************************************/

   public String getUid() {
      return this.uid;
   }
   public void setUid(String uid) {
      this.uid = uid;
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
}
