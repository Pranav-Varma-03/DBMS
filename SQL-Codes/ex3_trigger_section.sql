-- CREATE TABLE temp_section AS(SELECT * FROM section); 
-- CREATE TABLE temp_teaches AS(SELECT * FROM teaches);
-- DROP TABLE temp_section;
-- DROP TABLE temp_teaches;
--------------------------------------------------------
CREATE OR REPLACE FUNCTION check_section_fn()
RETURNS TRIGGER AS $$
DECLARE
	r record ;
-- 	s record ;
	valid_bool int default 0;
-- 	time_slot varchar;
	count_1 numeric default 0;
BEGIN
	DROP TABLE IF EXISTS teaches_section;
    CREATE TEMP TABLE teaches_section AS (SELECT * FROM teaches NATURAL JOIN section);
-- 	SELECT time_slot_id into time_slot from teaches_section where course_id = new.course_id and sec_id = new.sec_id and semester = new.semester and year = new.year;

for r in select * from teaches_section
	LOOP
	
	IF r.semester = new.semester and r.year = new.year and r.time_slot_id = new.time_slot_id THEN
	select count(id) into count_1 from teaches_section where id = r.id and semester = r.semester and year = r.year and time_slot_id = r.time_slot_id;
	END IF;
	
	END LOOP;
	
	IF count_1 > 0 THEN 
	RAISE NOTICE 'ENTERED BOOL 0';
		return old;
	ELSE 
	RAISE NOTICE 'ENTERED BOOL 1';
		return new;
	END IF;
	
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_section
BEFORE UPDATE ON section
FOR EACH ROW
EXECUTE FUNCTION check_section_fn();

-- DROP TRIGGER check_section ON section;
