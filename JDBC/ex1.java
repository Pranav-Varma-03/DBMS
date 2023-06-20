import java.util.Scanner;
import java.sql.*;
import java.util.ArrayList;
// import java.sql.Connection;
// import java.sql.DriverManager;
// import java.sql.ResultSet;
// import java.sql.DatabaseMetaData;
// import java.sql.Statement;

public class ex1 {

    public static void main(String[] args) {
        int col=0;

        String table_name;
        int k;
        System.out.println("Enter table name and value k");
        Scanner s = new Scanner(System.in);
        table_name = s.next();
        k = s.nextInt();
        System.out.println("");
        ArrayList<String> col_name_list = new ArrayList<String>();

        Connection c = null;
      try {
         Class.forName("org.postgresql.Driver");
         c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/univdb","testuser", "1234");
        DatabaseMetaData dbmd = c.getMetaData();

        ResultSet rs = dbmd.getColumns(null,null,table_name,"%");

        System.out.print("|");
        while ( rs.next() ) {
            col++;
            String col_name = rs.getString("COLUMN_NAME");
            col_name_list.add(col_name);
            System.out.print(col_name);
            print_spaces(col_name);
            System.out.print("|");
            // for()
         }
         System.out.println("");
         for(int i=0;i<31*col;i++){
            System.out.print("_");
         }
         System.out.println("");

         rs.close();
         c.close();

      } catch (Exception e) {
         e.printStackTrace();
         System.err.println(e.getClass().getName()+": "+e.getMessage());
         System.exit(0);
      }



            Connection conn = null;
        Statement stmt_2 = null;
      try {
         Class.forName("org.postgresql.Driver");
         conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/univdb","testuser", "1234");

         stmt_2 = conn.createStatement();
        ResultSet rs = stmt_2.executeQuery("SELECT * FROM " + table_name + " LIMIT '" + k +"'");

        
        while ( rs.next() ) {

            System.out.print("|");
            
            for(int i=0;i<col_name_list.size();i++){
                String row_value = rs.getString(col_name_list.get(i));
            System.out.print(row_value);
            print_spaces(row_value);
            System.out.print("|");
            }
            System.out.println("");
         }
         rs.close();
         stmt_2.close();
         conn.close();

      } catch (Exception e) {
         e.printStackTrace();
         System.err.println(e.getClass().getName()+": "+e.getMessage());
         System.exit(0);
      }

    s.close();
    }

    public static void print_spaces(String name){
        int num = 30 - name.length();

        for(int i=0;i<num;i++){
            System.out.print(" ");
        }

        return;
    }
}




    //     Connection c = null;
    //     Statement stmt = null;
    //   try {
    //      Class.forName("org.postgresql.Driver");
    //      c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/univdb","testuser", "1234");

    //     stmt = c.createStatement();
    //     ResultSet rs = stmt.executeQuery("SELECT * FROM COURSE");

    //     while ( rs.next() ) {
    //         int id = rs.getInt("course_id");
    //         System.out.println( "ID = " + id );
    //         System.out.println();
    //      }
    //      rs.close();
    //      stmt.close();
    //      c.close();

    //   } catch (Exception e) {
    //      e.printStackTrace();
    //      System.err.println(e.getClass().getName()+": "+e.getMessage());
    //      System.exit(0);
    //   }
    //   System.out.println("Opened database successfully");


        // System.out.println("Hello World");