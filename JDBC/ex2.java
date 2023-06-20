import java.util.Scanner;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class ex2 {

    public static void main(String[] args) {

        int course_id;

        System.out.println("Enter the course ID: ");

        Scanner s = new Scanner(System.in);

        course_id = s.nextInt();


        Connection c = null;
        Statement stmt = null;
      try {
         Class.forName("org.postgresql.Driver");
         c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/univdb","testuser", "1234");

        stmt = c.createStatement();
        ResultSet rs = stmt.executeQuery("with recursive c_prereq as (select prereq_id from prereq where course_id = '"+ course_id + "' union select prereq.prereq_id from prereq,c_prereq where prereq.course_id = c_prereq.prereq_id)select c_prereq.prereq_id,course.title from c_prereq,course where c_prereq.prereq_id = course.course_id;");

        while ( rs.next() ) {
            int id = rs.getInt("prereq_id");
            String title = rs.getString("title");
            System.out.println( "course_ID = " + id + ", Title = " + title );
            System.out.println();
         }
         rs.close();
         stmt.close();
         c.close();

      } catch (Exception e) {
         e.printStackTrace();
         System.err.println(e.getClass().getName()+": "+e.getMessage());
         System.exit(0);
      }

        s.close();
    }

}

// with recursive c_prereq as (
// 		select prereq_id
// 		from prereq
// 		where course_id = '760'
// 	union 
// 		select prereq.prereq_id
// 		from prereq,c_prereq
// 		where prereq.course_id = c_prereq.prereq_id
	
// 	)
// select c_prereq.prereq_id,course.title from c_prereq,course where c_prereq.prereq_id = course.course_id;
