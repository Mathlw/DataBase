package Information;

public class Bakery extends User {
   protected String name;
   protected String uid;
   protected String tel;
   protected String address;

   public Bakery (String uid, String pwd, int auth, String name, String tel, String address) {
      super(uid, pwd, auth);
      this.name = name;
      this.tel = tel;
      this.address = address;
   }

   public String[] toStringArray() {
      return new String[] {
         uid, pwd, Integer.toString(auth),
         name, tel, address
      };
   }

   public static Bakery[] addElement(Bakery[] array, Bakery element) {
      Bakery[] newArray = null;
      if (array != null) {
         newArray = new Bakery[array.length+1];
         for (int i = 0; i < array.length; i++) {
            newArray[i] = array[i];
         }
         newArray[newArray.length-1] = element;
      } else {
         newArray = new Bakery[]{element};
      }

      return newArray;
   }

   public String getName() {
      return this.name;
   }
   public void setName(String name) {
      this.name = name;
   }

   public String getTel() {
      return this.tel;
   }
   public void setTel(String tel) {
      this.tel = tel;
   }

   public String getAddress() {
      return this.address;
   }
   public void setAddress(String address) {
      this.address = address;
   }
}
