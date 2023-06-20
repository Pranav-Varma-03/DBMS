import java.util.Scanner;
import java.sql.*;

public class ex4 {
    public static void main(String[] args) {

        Scanner s = new Scanner(System.in);
        System.out.println("Enter Roll number to get CGPA :");
        String roll_num = s.next();
        Connection c = null;
        Statement stmt = null;

      try {
         Class.forName("org.postgresql.Driver");
         c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/univdb","testuser", "1234");

        stmt = c.createStatement();
            try {
            stmt.executeUpdate("CREATE OR REPLACE FUNCTION cal_cgpa(stu_id varchar) " + 
            "RETURNS float " +
            "LANGUAGE plpgsql " +
          "AS $$ " +
          "DECLARE " +
              "mycursor CURSOR FOR SELECT * FROM takes where id = stu_id; " +
              "myrow takes%ROWTYPE; " +
              "course_id_var varchar; " +
              "credits_var int; " +
              "totcredits_var int default 0; " +
              "grade_var varchar; " +
              "num_var int default 0; " +
              "cgpa float default 0; " +
          
          "BEGIN " +
              "DROP TABLE IF EXISTS CGPA_table; " +
              "CREATE TEMP TABLE CGPA_table AS (select id,takes.course_id as takes_cid,sec_id,semester,year,grade,course.course_id as course_cid,credits from takes JOIN course ON takes.course_id = course.course_id where id = stu_id);	" +
              "OPEN mycursor; " +
              "LOOP " +
                  "FETCH mycursor INTO myrow; " +
                  "EXIT WHEN NOT FOUND; " +
                  "course_id_var = myrow.course_id; " +
                  
                  "SELECT credits into credits_var from CGPA_table where takes_cid = myrow.course_id; " +
                  "SELECT grade into grade_var from CGPA_table where takes_cid = myrow.course_id and sec_id = myrow.sec_id and semester = myrow.semester and year = myrow.year; " +
                  
                  "IF grade_var = 'A+' THEN " +
                  "   num_var = num_var + 10*credits_var; " +
                  "ELSIF grade_var = 'A ' THEN " +
                  "     num_var = num_var + 9*credits_var; " +
                  "ELSIF grade_var = 'A-' THEN " +
                   "   num_var = num_var + 8*credits_var; " +
                  "ELSIF grade_var = 'B+' THEN " +
                   "   num_var = num_var + 7*credits_var; " +
                  "ELSIF grade_var = 'B ' THEN " +
                   "   num_var = num_var + 6*credits_var; " +
                  "ELSIF grade_var = 'B-' THEN " +
                   "   num_var = num_var + 5*credits_var; " +
                  "ELSIF grade_var = 'C+' THEN " +
                   "   num_var = num_var + 4*credits_var; " +
                  "ELSIF grade_var = 'C ' THEN " +
                   "   num_var = num_var + 3*credits_var; " +
                  "ELSIF grade_var = 'C-' THEN " +
                   "   num_var = num_var + 2*credits_var; " +
                  "END IF; " +
                  
                  "totcredits_var = totcredits_var + credits_var; " +
              "END LOOP; " +
              "CLOSE mycursor; " +

              "IF totcredits_var = 0 THEN " +
		        "cgpa = 0; " +
	          "ELSE " +
		        "cgpa = num_var::float/totcredits_var; " +
	          "END IF; " +

              "return cgpa; " +
          "END; " +
          "$$");

            } catch (Exception e) {

                System.out.println("error! creating function");
            }


        ResultSet rs = stmt.executeQuery("SELECT cal_cgpa('"+ roll_num+"') as CGPA;");

        while ( rs.next() ) {
            float cgpa = rs.getFloat("CGPA");
            if(cgpa == 0){
                System.out.println("Incorrect RollNumber, Enter again !!");
                break;
            }
            System.out.println( "CGPA of " + roll_num +" = " + cgpa );
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
