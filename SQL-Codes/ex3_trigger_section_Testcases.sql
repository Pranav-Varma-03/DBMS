UPDATE SET time_slot_id = WHERE course_id= and sec_id = and semester = and year = 
SELECT * FROM teaches NATURAL JOIN section order by id;
SELECT * FROM temp_section where time_slot_id = 'K';
-------------correct-------------------------
update temp_section set 
time_slot_id ='J' where 
course_id = '338' and sec_id = '1' and semester = 'Spring' and
year = 2007 ;

-- select * from temp_section ;
-- where course_id = '338';
--------------wrong------------------------------
update temp_section set 
time_slot_id ='M' where 
course_id = '338' and sec_id = '1' and semester = 'Spring' and
year = 2007 ;
-- 22591
select * from teaches_section where id = '14365' and semester = 'Spring' and year = 2007 and time_slot_id = 'D';
	
