Create OR REPLACE function cal_loop(stu_id varchar)  
returns float  
language plpgsql  
as  
$$  
Declare  
 num_count integer;
 num_it float DEFAULT 0;
Begin
   select count(*)   
   into num_count  
   from takes  
   where id = stu_id;
   
   FOR i IN 1..num_count LOOP
   num_it = num_it + 1;
   END LOOP;
   
	return num_it;  
End;  
$$;

SELECT cal_loop('65901');
