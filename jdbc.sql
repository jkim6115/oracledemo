-- java jdbc

CREATE TABLE mem (
	num NUMBER CONSTRAINT mem_num_pk PRIMARY KEY,
	name varchar2(100),
	age NUMBER(3),
	loc varchar2(50)
);

-- 시퀀스 생성
CREATE SEQUENCE mem_num_seq
 START WITH 1
 INCREMENT BY 1
 nocache
 nocycle;

-- 삽입
INSERT INTO mem(num, name, age, loc)
VALUES(mem_num_seq.nextval, '홍길동', 30, '서울');

SELECT * FROM mem;

COMMIT;

-- join
SELECT e.employee_id, e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT d.department_id, d.department_name, e.employee_id, e.employee_id, e.job_id
FROM departments d, employees e
WHERE d.department_id = e.department_id;



SELECT * FROM mem
ORDER BY num DESC;




