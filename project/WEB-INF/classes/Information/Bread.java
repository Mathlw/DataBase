package Information;

public class Bread{
   private String uid;
   private String name;
   private int price;

   public Bread(String uid, String name, int price) {
      this.uid = uid;
      this.name = name;
      this.price = price;
   }

   public static Bread[] addElement(Bread[] array, Bread element) {
      Bread[] newArray = null;
      if (array != null) {
         newArray = new Bread[array.length+1];
         for (int i = 0; i < array.length; i++) {
            newArray[i] = array[i];
         }
         newArray[newArray.length-1] = element;
      } else {
         newArray = new Bread[]{element};
      }

      return newArray;
   }

   public String[] toStringArray() {
      return new String[] {uid, name, Integer.toString(price)};
   }

   public String getUid() {
      return this.uid;
   }
   public void setUid(String uid) {
      this.uid = uid;
   }

   public String getName() {
      return this.name;
   }
   public void setName(String name) {
      this.name = name;
   }

   public int getPrice() {
      return this.price;
   }
   public void setPrice(int price) {
      this.price = price;
   }
}
