CREATE OR REPLACE FUNCTION EX5_C_1(k integer,inpcourse_id varchar)
	RETURNS TABLE(stu_id varchar(20))

	LANGUAGE plpgsql
AS $$
DECLARE
    mycursor_2 CURSOR FOR SELECT id FROM student;
    myrow_2 takes%ROWTYPE;
	stu_id_var varchar;
	cgpa_var float default 0;

BEGIN
	DROP TABLE IF EXISTS CGPA;
	DROP TABLE IF EXISTS stu_cgpa;
	CREATE TEMP TABLE stu_cgpa (stu_id varchar(20), cgpa float);
	OPEN mycursor_2;
    LOOP
        FETCH mycursor_2 INTO myrow_2;
        EXIT WHEN NOT FOUND;

		SELECT cal_cgpa(myrow_2.id) INTO cgpa_var;
		INSERT INTO stu_cgpa (stu_id, cgpa) VALUES (myrow_2.id,cgpa_var);
 
	END LOOP;
    CLOSE mycursor_2;
	   CREATE TABLE CGPA AS (SELECT id,rank() over (ORDER BY cgpa DESC ) AS s_rank FROM takes JOIN stu_cgpa ON takes.id = stu_cgpa.stu_id WHERE course_id = inpcourse_id ORDER BY s_rank LIMIT k);
	RETURN QUERY SELECT id FROM CGPA;
END;
$$ 
