package Information;

public class Student extends User {
   protected String name;
   protected String uid;
   protected int grade;
   protected int sclass;
   protected int stNum;
   protected String tel;

   public Student(String uid, String pwd, int auth, String name, int grade, int sclass, int stNum, String tel) {
      super(uid,pwd,auth);
      this.name = name;
      this.grade = grade;
      this.sclass = sclass;
      this.stNum = stNum;
      this.tel = tel;
   }

   public String[] toStringArray() {
      return new String[] {
         uid, pwd, Integer.toString(auth),
         name, uid, Integer.toString(grade), Integer.toString(sclass), Integer.toString(stNum),tel
      };
   }


   /***************************************************************************
   *  Getter And Setter
   ***************************************************************************/

   public String getName() {
      return this.name;
   }
   public void setName(String name) {
      this.name = name;
   }
   
   public int getGrade() {
      return this.grade;
   }
   public void setGrade(int grade) {
      this.grade = grade;
   }

   public int getSClass() {
      return this.sclass;
   }
   public void setSClass(int sclass) {
      this.sclass = sclass;
   }

   public int getStNum() {
      return this.stNum;
   }
   public void setStNum(int stNum) {
      this.stNum = stNum;
   }

   public String getTel() {
      return this.tel;
   }
   public void setTel(String tel) {
      this.tel = tel;
   }

   /***************************************************************************
   *  Getter And Setter end
   ***************************************************************************/
}
