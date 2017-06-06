package Information;

public class Order  {
   private String bid;
   private String uid;
   private String breadName;
   private String deliveryDate;
   private String orderedDate;

   public Order (String bid, String uid, String breadName, String deliveryDate, String orderedDate) {
      this.bid = bid;
      this.uid = uid;
      this.breadName = breadName;
      this.deliveryDate = deliveryDate;
      this.orderedDate = orderedDate;
   }

   public static Order[] addElement(Order[] array, Order element) {
      Order[] newArray = null;
      if (array != null) {
         newArray = new Order[array.length+1];
         for (int i = 0; i < array.length; i++) {
            newArray[i] = array[i];
         }
         newArray[newArray.length-1] = element;
      } else {
         newArray = new Order[]{element};
      }

      return newArray;
   }

   public String[] toStringArray() {
      return new String[] {
         this.bid,
         this.uid,
         this.breadName,
         this.deliveryDate,
         this.orderedDate
      };
   }

   public String getBid() {
      return this.bid;
   }
   public void setBid(String bid) {
      this.bid = bid;
   }

   public String getUid() {
      return this.uid;
   }
   public void setUid(String uid) {
      this.uid = uid;
   }

   public String getBreadName() {
      return this.breadName;
   }
   public void setBreadName(String breadName) {
      this.breadName = breadName;
   }

   public String getDeliveryDate() {
      return this.deliveryDate;
   }
   public void setDeliveryDate(String deliveryDate) {
      this.deliveryDate = deliveryDate;
   }

   public String getOrderedDate() {
      return this.orderedDate;
   }
   public void setOrderedDate(String orderedDate) {
      this.orderedDate = orderedDate;
   }
}
