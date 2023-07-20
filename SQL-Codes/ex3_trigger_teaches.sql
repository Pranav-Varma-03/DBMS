-- CREATE TABLE temp_section AS(SELECT * FROM section); 
-- CREATE TABLE temp_teaches AS(SELECT * FROM teaches);
-- SELECT * FROM temp_teaches;
-- SELECT * FROM temp_section;

-- DROP TABLE teaches_section;
-- CREATE TEMP TABLE teaches_section AS (SELECT * FROM teaches NATURAL JOIN section);
-- SELECT * FROM teaches_section;

CREATE OR REPLACE FUNCTION check_teaches_fn()
RETURNS TRIGGER AS $$
DECLARE
	r record ;
	valid_bool int default 0;
	time_slot varchar;
BEGIN
	DROP TABLE IF EXISTS teaches_section;
    CREATE TEMP TABLE teaches_section AS (SELECT * FROM teaches NATURAL JOIN section);
		SELECT time_slot_id into time_slot from teaches_section where course_id = new.course_id and sec_id = new.sec_id and semester = new.semester and year = new.year;
	IF old.id is null then
		valid_bool = 1; -- NEW INPUT TUPLE DONOT EXIST ON TABLE THUS INSTRUCTOR CAN TAKE COURSE
	END IF;
for r in select * from teaches_section WHERE id = NEW.id
	LOOP
		
		IF r.course_id = new.course_id and r.sec_id = new.sec_id and r.semester = new.semester and r.year = new.year THEN
			-- the input tuple already exists. hence no update or addition
			new = old;
			valid_bool = 1;
			RAISE NOTICE 'Tuple already exists';
			EXIT;
		ELSE
			IF r.semester = new.semester and r.year = new.year and r.time_slot_id = time_slot THEN
				IF r.sec_id = new.sec_id and r.course_id = new.course_id THEN
					valid_bool = 1;
					EXIT;
				ELSE 
					valid_bool = 0;
				END IF;
			END IF;
		END IF;
		
	
	END LOOP;
	IF valid_bool = 0 THEN 
		IF old.id is null then
		RAISE NOTICE 'INVALID INSERT QUERY';
		RETURN null;
		else
		RAISE NOTICE 'INVALID UPDATE QUERY';
		return old;
		END IF;
	ELSE
	RAISE NOTICE 'QUERY SUCCESSFUL';
		return new;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_teaches
BEFORE INSERT OR UPDATE ON teaches
FOR EACH ROW
EXECUTE FUNCTION check_teaches_fn();

DROP TRIGGER check_teaches ON teaches;
