SELECT name "team name", number_of_players "number of players"
FROM teams
ORDER BY name;


SELECT name "team name", number_of_players "number of players"
FROM teams
ORDER BY number_of_players DESC;


SELECT name "Team Name", number_of_players "Players"
FROM teams
ORDER BY "Team Name" DESC;


SELECT ROWNUM As "number","Customer Name"
FROM (SELECT first_name || ' ' || last_name AS "Customer Name"
             FROM customers)
WHERE ROWNUM <=3;


SELECT first_name, last_name
FROM sales_representatives
WHERE commission_rate = :commission_rate_num 
ORDER BY last_name;


SELECT *
FROM students
ORDER BY RGS_YEA;


SELECT *
FROM XAM_RESULTS
ORDER BY STU_ID, CRS_ID;


SELECT *
FROM STUDENT_ATTENDANCES
ORDER BY STU_ID;


SELECT *
FROM DEPARTMENTS_FOR_AB
ORDER BY ID;


SELECT NUMBER_OF_WRK_DAYS, NUMBER_OF_DAYS_OFF, STU_ID,  ACADEMIC_SESSIONS_ID, (NUMBER_OF_DAYS_OFF*100/(NUMBER_OF_WRK_DAYS+NUMBER_OF_DAYS_OFF)) AS "precent of days off"
FROM STUDENT_ATTENDANCES
ORDER BY "precent of days off";


SELECT ROWNUM AS "Num", stu_id, name, grade, crs_id
FROM (SELECT stu_id, frst_name|| ' ' || lst_name AS name, grade, crs_id
     FROM student_course_details JOIN students ON student_course_details.stu_id=students.id
     ORDER BY grade)
WHERE ROWNUM <=5;


SELECT *
FROM pnt_informations
ORDER BY id;


SELECT *
FROM sales_representatives NATURAL JOIN SALES_REP_ADDRESSES;


SELECT id, first_name, last_name, address_line_1, address_line_2, city, email , phone_number 
FROM sales_representatives NATURAL JOIN SALES_REP_ADDRESSES;


SELECT id, first_name, last_name, address_line_1, address_line_2, city, email , phone_number 
FROM sales_representatives JOIN SALES_REP_ADDRESSES
USING (id) ;


SELECT *
FROM items JOIN price_history
USING (itm_number) ;


SELECT c.ctr_number, c.first_name, c.last_name, c.phone_number, c.email, 
r.id, r.first_name, r.last_name, r.email
FROM customers c JOIN sales_representatives r
ON (c.sre_id = r.id);


SELECT c.ctr_number, c.first_name, c.last_name, c.phone_number, c.email, 
r.id, r.first_name, r.last_name, r.email, t.name
FROM customers c 
JOIN sales_representatives r
ON (c.sre_id = r.id)
JOIN teams t
ON c.tem_id = t.id;



SELECT c.ctr_number, c.first_name, c.last_name, c.phone_number, c.email, 
r.id, r.first_name, r.last_name, r.email, t.name
FROM customers c 
JOIN sales_representatives r
ON (c.sre_id = r.id)
JOIN teams t
ON c.tem_id = t.id
WHERE c.ctr_number = 'c00001';


SELECT 'The cost of the ' ||i.name|| ' on this day was ' || p.price AS message
FROM items i JOIN price_history p
USING (itm_number) 
WHERE itm_number = 'im01101045' AND start_date <= '12-Dec-2016' AND (end_date >= '12-Dec-2016' OR end_date IS NULL);


SELECT s1.first_name || ' ' || s1.last_name AS Rep, s2.first_name || ' ' || s2.last_name AS Supervisor
FROM sales_representatives s1 JOIN sales_representatives s2
ON (s1.supervisor_id = s2.id);



SELECT *
FROM teams LEFT OUTER JOIN customers
ON teams.id = customers.tem_id;


SELECT *
FROM customers, sales_representatives;


SELECT *
FROM courses;


SELECT *
FROM courses
WHERE academic_session_id = 100;


SELECT c.name AS course, s.frst_name || ' ' || s.lst_name AS student,  d.name AS department
FROM courses c 
JOIN student_course_details scd ON scd.crs_id = c.id
JOIN students s ON scd.stu_id = s.id
JOIN departments_for_ab d ON c.dpt_id = d.id
ORDER BY c.name;


SELECT c.name AS course, s.frst_name || ' ' || s.lst_name AS student,  d.name AS department
FROM courses c 
JOIN student_course_details scd ON scd.crs_id = c.id
JOIN students s ON scd.stu_id = s.id
JOIN departments_for_ab d ON c.dpt_id = d.id
WHERE d.id = 20
ORDER BY c.name;


SELECT s.frst_name || ' ' || s.lst_name AS student, c.name course, grade
FROM xam_results xr JOIN students s ON xr.stu_id = s.id 
JOIN courses c ON c.id = xr.crs_id
WHERE xr.crs_id BETWEEN 190 AND 192;


SELECT *
FROM xam_results xr LEFT OUTER JOIN courses c ON c.id = xr.crs_id;





























