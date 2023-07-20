with recursive c_prereq as (
		select prereq_id
		from prereq
		where course_id = '760'
	union 
		select prereq.prereq_id
		from prereq,c_prereq
		where prereq.course_id = c_prereq.prereq_id
	
	)
select c_prereq.prereq_id,course.title from c_prereq,course where c_prereq.prereq_id = course.course_id;

