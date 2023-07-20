CREATE OR REPLACE FUNCTION EX5_A(k integer)
	RETURNS TABLE(stu_id varchar(20))

	LANGUAGE plpgsql
AS $$
DECLARE
    mycursor_2 CURSOR FOR SELECT id FROM student;
    myrow_2 takes%ROWTYPE;
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
    -- code to use the temp_table
	END LOOP;
    CLOSE mycursor_2;
	   CREATE TEMP TABLE CGPA AS (SELECT stu_cgpa.stu_id as id,rank() over (ORDER BY cgpa DESC ) AS s_rank FROM stu_cgpa ORDER BY s_rank LIMIT k);
	   RETURN QUERY SELECT id from CGPA;
END;
$$ 
