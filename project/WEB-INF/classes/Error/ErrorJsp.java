package Error;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
//7300
public class ErrorJsp extends Exception {
   private String message = null;

   public ErrorJsp(Object e, Class where, String func) {
      try {
         BufferedWriter w = new BufferedWriter(new FileWriter(new File("/home/vely/webapps/BreadShuttle/error.txt"), true));
         long time = System.currentTimeMillis();
         SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		   String str = dayTime.format(new Date(time));
         w.write(str);
         w.append("//"+where+"//"+func+"\n");
         w.append(e.toString());
         w.append("\n");
         w.close();
      } catch (Exception er) {
         er.printStackTrace();
      }
   }
   public ErrorJsp (String message) {
      this.message = message;
   }

   public String getMessage() {
      return message;
   }
}
