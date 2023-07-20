select * from teaches natural join temp_section WHERE id = '77346';
insert into teaches(id,course_id,sec_id,semester,year) values('99052','408','2','Spring',2003); -- WRONG
insert into teaches(id,course_id,sec_id,semester,year) values('99052','137','1','Spring',2002); -- CORRECT
-- select * from temp_teaches where id = '77346';
-- order by id desc;
-- where id = '99052';
-- DELETE FROM temp_teaches where course_id = '408';
-- SELECT * FROM temp_teaches where id = '99052';
-- select * from teaches;
DROP TABLE temp_teaches;
SELECT * FROM temp_teaches natural join temp_section WHERE id = '6569';
UPDATE temp_teaches SET id = '6569', course_id = '349',sec_id = '3',semester = 'Spring',year = '2008' WHERE id = '6569'and course_id = '362'and sec_id = '3' and semester = 'Spring'; --WRONG
UPDATE temp_teaches SET id = '77346', course_id = '443',sec_id = '1',semester = 'Spring',year = '2010' WHERE id = '77346'and course_id = '493'and sec_id = '1' and semester = 'Spring'; --CORRECT
-- SELECT * from section where year = '2010';
