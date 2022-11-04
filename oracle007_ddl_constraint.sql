/*
테이블 구조 정의
create table table_name(
    colimn_name datatype
    )
*/

/*
자료형
varchar() - 가변길이 문자를 저장
char - 고정길이 문자 저장
number(m) - 정수저장
number(m,n) - 실수저장
data - 날짜저장
dtatatime - 날짜 시간 저장
*/

CREATE TABLE student(
    name varchar2(20),
    age number(3),
    avg number(5, 2),
    hire date
);

SELECT * FROM student;

-- 정상 삽입
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동', 30, 97.85, sysdate);

-- ORA-12899: value too large for column "HR"."STUDENT"."NAME" (actual: 26, maximum: 20)
INSERT INTO student(name, age, avg, hire)
VALUES('박차고 나온 세상에', 30, 97.85, sysdate);

--3000 : 크기초과
-- ORA-01438: value larger than specified precision allowed for this column
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동', 3000, 97.85, sysdate);

--2997.85 크기초과
--ORA-01438: value larger than specified precision allowed for this column
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동', 30, 2997.85, sysdate);

-- 소수점 이하는 반올림 해서 삽입
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동', 30, 297.8589, sysdate);

SELECT * FROM student;

--소수점 2자리로 무조건 계산
--ORA-01438: value larger than specified precision allowed for this column
INSERT INTO student(name, age, avg, hire)
VALUES('홍길동', 30, 5297.8, sysdate);

/*
ALTER
 객체(table)의 구조를 변경해주는 명령어이다.
*/

--생성 : CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE INCEX
--수정 : ALTER TABLE, ALTER SEQUENCE, ALTER VIEW, ALTER INCEX

ALTER TABLE student
ADD loc varchar2(50);

/*
DESCRIBE
*/

DESC student;

SELECT * FROM student;

--cannot decrease column length because some value is too big
alter table student
modify name varchar2(5);

--저장된 데이터의 크기로 줄일 수는 있다.
alter table student
modify name varchar2(9);

--크기를 늘리는 것은 상관없다.
alter table student
modify name varchar2(30);

desc student;

--테이블의 컬럼명을 수정한다.
alter table student
rename column avg to jumsu;

--테이블명을 변경한다.
alter table student
rename to menbers;

--ORA-04043: student 객체가 존재하지 않습니다.
desc student;

--정상수행
desc menbers;

/*
delete : 테이블에 저장된 데이터 모두 삭제 (auto commit이 안됨)
truncate : 테이블에 저장된 데이터 모두 삭제 (auto commit 발생)
drop : 테이블 자체를 삭제한다.(auto commit 발생)
*/

DELETE FROM menbers;
SELECT * FROM menbers;
ROLLBACK;

TRUNCATE TABLE menbers; --auto commit
SELECT * FROM menbers;
ROLLBACK;

SELECT * FROM menbers;

COMMIT;

DROP TABLE menbers;

SELECT * FROM menbers;
ROLLBACK;

SELECT * FROM menbers;

/*
무결성 제약조건
	무결성이 데이터베이스 내에 있는 데이터의 정확성을 유지를 의미한다면
	제약조건은 바람직하지 않는 데이터가 저장되는 것을 방지하는 것을 말한다.
	
	무결성 제약조건 : not null, unique, primary key, foreign key, check
	not null : null을 허용하지 않는다.
	unique : 중복된 값을 허용하지 않는다. 항상 유일한 값이다.
	primary key : not null + unique
	foreign key : 참조되는 테이블의 컬럼의 값이 존재하면 허용된다.
	check : 저장 가능한 데이터의 값의 범위나 조건을 지정하여 설정한 값만을 허용한다.
	
	무결성 제약조건 2가지 레벨 : 컬럼레벨, 테이블레벨
	
	컬럼레벨 설정
	create table emp06(
		id varchar2(10) constraint emp06_id_pk primary key,
		name varchar2(20) constraint emp06_name_nu not null,
		age number(3) constraint emp06_age_ck check(age between 20 and 50),
		gen char(1) constraint emp06_gen_ck check(gen in('m','w'))
	);
	
	테이블 레벨 설정
	create table emp07(
		id varchar2(10),
		name varchar2(20) constraint emp07_name_nu not null,
		age number(3),
		gen char(1),
		constraint emp07_id_pk primary key(id),
		constraint emp07_age_ck check(age between 20 and 50),
		constraint emp07_gen_ck check(gen in('m','w'))
	);
*/

SELECT * FROM user_constraints;

create table emp06(
	id varchar2(10) constraint emp06_id_pk primary key,
	name varchar2(20) constraint emp06_name_nu not null,
	age number(3) constraint emp06_age_ck check(age between 20 and 50),
	gen char(1) constraint emp06_gen_ck check(gen in('m','w'))
);

SELECT * FROM user_constraints
WHERE CONSTRAINT_name LIKE '%EMP06%';

INSERT INTO emp06(id, name, age, gen)
VALUES('kim', '김고수', 15, 'm');

--ORA-02290: check constraint (HR.EMP06_GEN_CK) violated
INSERT INTO emp06(id, name, age, gen)
VALUES('kim', '김고수', 20, 'p');

--정상삽입
INSERT INTO emp06(id, name, age, gen)
VALUES('kim', '김고수', 25, 'm');

--ORA-00001: unique constraint (HR.EMP06_ID_PK) violated
INSERT INTO emp06(id, name, age, gen)
VALUES('kim', '김고수', 25, 'm');

--ORA-01400: cannot insert NULL into ("HR"."EMP06"."ID")
INSERT INTO emp06(id, name, age, gen)
VALUES(null, '김고수', 25, 'm');

DROP TABLE emp06;

SELECT * FROM user_constraints
WHERE CONSTRAINT_name LIKE '%EMP06%';

--foreign key 확인
CREATE TABLE dept01(
	deptno number(2) CONSTRAINT dept01_deptno_pk PRIMARY KEY,
	dname varchar(20)
);

INSERT INTO dept01(deptno, dname)
VALUES(10, 'accounting');

SELECT * FROM dept01;

INSERT INTO dept01(deptno, dname)
VALUES(20, 'sales');

SELECT * FROM dept01;

INSERT INTO dept01(deptno, dname)
VALUES(30, 'research');

SELECT * FROM dept01;

CREATE TABLE loc01(
	locno number(2),
	locname varchar2(20),
	CONSTRAINT loc01_1ocno_pk PRIMARY KEY(locno)
);

INSERT INTO loc01(locno, locname)
VALUES(11, 'seoul');

INSERT INTO loc01(locno, locname)
VALUES(12, 'jeju');

INSERT INTO loc01(locno, locname)
VALUES(13, 'busan');

SELECT * FROM loc01;

CREATE TABLE emp08(
	empno number(2) CONSTRAINT emp08_empno_pk PRIMARY KEY,
	deptno number(2) CONSTRAINT emp08_deptno_fk REFERENCES dept01(deptno),
	locno number(2),
	CONSTRAINT emp08_locno_fk FOREIGN KEY(locno) REFERENCES loc01(locno)
);

SELECT * FROM emp08;

--정상 삽입
INSERT INTO emp08(empno, deptno, locno)
VALUES(1, 10, 11);

SELECT * FROM emp08;

INSERT INTO emp08(empno, deptno, locno)
VALUES(2, 20, 12);

INSERT INTO emp08(empno, deptno, locno)
VALUES(3, null, null);

SELECT * FROM emp08;

--ORA-02291: integrity constraint (HR.EMP08_DEPTNO_FK) violated - parent key not found
INSERT INTO emp08(empno, deptno, locno)
VALUES(4, 40, 11);

--ORA-02291: integrity constraint (HR.EMP08_LOCNO_FK) violated - parent key not found
INSERT INTO emp08(empno, deptno, locno)
VALUES(5, 30, 14);

--emp08테이블의 deptno컬럼에서 30을 참조하지 않고 있기 때문에 삭제 이상 없음
DELETE FROM dept01
WHERE deptno=30;

SELECT * FROM dept01;

--ORA-02292: integrity constraint (HR.EMP08_DEPTNO_FK) violated - child record found
DELETE FROM dept01
WHERE deptno=20;

SELECT * FROM dept01;

/*
 * 다른 테이블에서 현재 테이블을 참조해서 사용하고 있을 때는
 * 제약조건을 제거한 후 현재 테이블의 데이터를 삭제한다.
 */

SELECT * FROM user_constraints
WHERE CONSTRAINT_name LIKE '%EMP08%';

ALTER TABLE emp08
DROP CONSTRAINT emp08_deptno_fk;

DELETE FROM dept01
WHERE deptno=20;

SELECT * FROM dept01;

/*
 * 부모키가 삭제가 되면 참조되는 키도 삭제가 되도록 cascade을 설정한다.
 */

INSERT INTO dept01
VALUES(20, 'sales');

--cascade 설정
ALTER TABLE emp08
ADD CONSTRAINT emp08_deptno_fk FOREIGN KEY(deptno) REFERENCES dept01(deptno) ON DELETE CASCADE;

SELECT * FROM dept01;
SELECT * FROM emp08;

DELETE FROM dept01
WHERE deptno=10;

SELECT * FROM dept01;
SELECT * FROM emp08;

/*
 * on update cascade은 오라클에서 제공 안됨
 * 해결방법 : trigger
 */

CREATE OR REPLACE TRIGGER dept_tri
	AFTER UPDATE ON dept01 FOR EACH ROW --업데이트 된 후 명령문 실행
BEGIN
	UPDATE emp08
	SET deptno=50
	WHERE deptno=20;
END;

UPDATE dept01
SET deptno=50
WHERE deptno=20;

SELECT * FROM dept01;
SELECT * FROM emp08;

COMMIT;







