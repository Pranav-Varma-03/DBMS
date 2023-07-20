-- DECLARE tot_elems integer := 0;
-- select COUNT(*) INTO tot_elems from takes where id = '65901';

Create OR REPLACE function cal_count(stu_id varchar)  
returns integer  
language plpgsql  
as  
$$  
Declare  
 num_count integer DEFAULT 0;  
Begin  
   select count(*)   
   into num_count  
   from takes  
   where id = stu_id;  
   return num_count;  
End;  
$$;  

SELECT cal_count('65901');
