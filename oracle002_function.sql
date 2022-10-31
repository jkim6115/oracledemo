/**************************************
SQL(structured query language)
1. 단일행함수 : 행 하나당 하나의 결과를 출력한다.
              (문자함수, 숫자함수, 날짜함수, 변환함수, 일반함수)
2. 복수행함수 : 행 여러개당 하나의 결과를 출력한다.
              (합계, 평균, 최대, 최소, 갯수)
**************************************/
-- SELECT 문에서는 반드시 테이블 명을 명시해야 한다
-- 그래서 SELECT 절에 식이나 특징함수를 이용해서 결과값을 가져올때
-- 사용할 수 있는 DUAL이라는 테이블을 제공한다.
SELECT 3+1
FROM dual;

SELECT sysdate
FROM dual;

/**************************
문자함수
**************************/
-- 단어의 첫글자만 대문자로 변경해 주는 함수
SELECT initcap('hello korea')
FROM dual;

-- 모든 문자를 대문자로 변경
SELECT upper('korea')
FROM dual;

-- 모든 문자를 소문자로 변환하는 함수
SELECT fitst_name, mane, upper(first_name),
      last_name, upper(last_name)
FROM employees

--SELECT fitst_name, mane, upper(first_name),
--      last_name, upper(last_name)
--FROM employees

-- employees 테이블 first_name에서 대소분자 구분없이
-- 'Js'가 포함된 first_name, salary 출력
--SELECT firtst_name, salary
--FROM employees
--WHERE upper(first_name) LIKE upper('%Ja%);
--
---- 문자의 길이를 리턴해주는 함수
--SELECT lenth('korea')
--FROM dual;
--
--SECECT length('한글')
--FROM dual;
--
--CREATE TABLE  user1 (
--    data varchar2(5);
--);
--
--DESC = UESR1;
--SELECT * FROM user1;
--
--INSERT INTO user1(data)
--VALUES('korea');
--
--SELECT * FROM user1;
--
--INSERT INTO user1;
--
--INSERT INTO user1(data)
--VALUES('south korea');
--
--INSERT INTO user1(data)
--VALUES('한글');

-- 특정범위의 문자를 추출해 주는 함수이다.
-- substr('문자', 시작위치, 갯수)
SELECT substr('oracle test', 1, 4)
FROM dual;

SELECT substr('Oracle test', 3, 4)
FROM dual;

SELECT substr('오라클 테스트',-3, 4)
FROM dual;

-- 특정문자의 인덱스를 추출해주는 함수이다.
SELECT instr('korea', 'or')
FROM dual;

SELECT instr('한국자바', '자바')
FROM dual;

-- 주어진 문자열에서 왼쪽으로 특정문자를 채우는 함수이다.
SELECT lpad('korea',8,'*')
FROM dual;

SELECT rpad('korea',8,'*')
FROM dual;

-- 주어진 문자열에서 왼쪽의 특정문자를 삭제하는 함수이다.
SELECT ltrim('***korea', '*')
FROM dual;

SELECT rtrim('korea***', '*')
FROM dual;

-- 주어진 문자열에서 양쪽 특정 문자를 삭제하는 함수이다.
SELECT trim('*' from '***korea***')
FROM dual;

-- 주어진 문자열에서 왼쪽의 공백제거
SELECT ltrim('   korea')
FROM dual;

SELECT '   korea', length('   korea'), ltrim('   korea'), length(ltrim('   korea'))
FROM dual;

SELECT 'korea   ', length('korea   '), rtrim('korea   '), length(rtrim('korea   '))
FROM dual;

-- 주어진 문자열에서 양쪽의 공백제거
SELECT trim(' ' from '   korea   '), length(trim(' ' from '   korea   '))
FROM dual;

-- 주어진 문자의 아스키 코드값을 구하는 함수이다.
SELECT ascii('A')
FROM dual;

-- 주어진 아스키 코드값의 문자를 구하는 함수이다.
SELECT chr(65)
FROM dual;

-- 주어진 문자를 연결하는 함수이다.
SELECT concat('java','jap')
FROM dual;

SELECT 'java' || 'jap'
FROM dual;

/*----------------------------
숫자함수
-----------------------------*/
-- 3.55의 소수점 1의 자리까지 구하시오
SELECT round(3.55)
FROM dual;

-- 42523을 십의 자리까지 구하시오
SELECT round(42523.55, -1)
FROM dual;

-- 42523을 일의 자리까지 구하시오
SELECT round(42523.55, 0)
FROM dual;

SELECT round(42523.55)
FROM dual;

-- 256.78을 무조건 올림
SELECT ceil(256.78)
FROM dual;

-- 무조건 버림
SELECT floor(289.76)
FROM dual;

-- 거듭제곱
SELECT power(3,2)
FROM dual;

-- 제곱근
SELECT sqrt(25)
FROM dual;

-- 나머지
SELECT mod(10,3)
FROM dual;

/*----------------------------
날짜함수
----------------------------*/
-- 현재 시스템에서 제동해주는 오늘의 날짜 구하는 함수
SELECT sysdate
FROM dual;

SELECT sysdate + 1
FROM dual;

SELECT sysdate - 1
FROM dual;

-- 오늘을 기준으로 10개월후의 날짜
SELECT add_months(sysdate, 10)
FROM dual;

/*---------------------------------
변환형 함수

숫자              문자          날짜
to_number() <-> to_char() <-> to_date()
---------------------------------*/
-- 숫자 -> 문자

SELECT to_char(2532, '9,999.99')
FROM dual;

SELECT to_char(2532, '999,999.99')
FROM dual;

SELECT to_char(2532, '000,000.00')
FROM dual;

-- 각 나라의 통화를 표현해 줄 때 L기호를 사용한다.
SELECT to_char(2532, 'L999,999.99')
FROM dual;

-- 날짜 -> 문자
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss day')
FROM dual;

SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss dy')
FROM dual;

SELECT to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss day')
FROM dual;
/*
java
//HH : 24시간, hh: 12시간
        string pattern = "yyyy-MM-dd HH:mm:ss a EEEE"
*/

/*
to_number()
문자 -> 숫자
*/
SELECT '253' || '12'
FROM dual;

SELECT concat('253','12')
FROM dual;

SELECT '253' + '12'
FROM dual;

SELECT to_number('253' + to_number('12'))
FROM dual;

/*
to_date()
문자 -> 날짜
*/
SELECT to_date('2022-10-24')
FROM dual;

-----------------------------------

SELECT first_name, hire_date
FROM employees;

-- hire_date(입사일)을 이용해서 "홍길동님은 2003년 1월 3일에 입사했습니다."로 출력하는 query를 작성
SELECT first_name || '님은 ' || to_char(hire_date, 'yyyy') || '년 ' || to_char(hire_date, 'mm')
        || '월 ' || ltrim(to_char(hire_date, 'dd'),'0') || '일에 입사했습니다.'
FROM employees;

/*
일반함수
1. nvl(컬럼, 대체값) : 첫번째 인자값이 null이면 0으로대체 가능
    대체할 값이 숫자이면 두번째 인자값에 숫자 지정
    대체할 값이 문자이면 두번째 인자값에 문자 지정
    대체할 값이 날짜이면 두번째 인자값에 날짜 지정
*/

SELECT commission_pct , nvl(commission_pct,0)
FROM employees;

SELECT first_name, manager_id, nvl(to_char(manager_id),'CEO')
FROM employees;

/*
일반함수(null)
2. nvl2(컬럼, 대체값1, 대체값2) : 컬럼의 값이 null이 아니면 대체값1, null이면 대체값2로 처리
*/

SELECT commission_pct, nvl2(commission_pct, 1, 0)
FROM employees;

SELECT count(*) AS 전체사원수, 
        sum(nvl2(commission_pct, 1, 0)) AS "커미션 지급 회원수", 
        count(*)-sum(nvl2(commission_pct, 1, 0)) AS "커미션미지급 회원수"
FROM employees;

/*
일반함수(NULL)
3. NULLIF(컬럼, 대체값)
    컬럼값과 비교값이 같으면 null로 리턴하고 같지 않으면 컬럼의 값으로 리턴
*/
SELECT commission_pct, NULLIF(commission_pct, 0.4)
FROM employees;

/*
일반함수
4. coalesce(컬럼1, 컬럼2)
*/

SELECT first_name,commission_pct, salary, coalesce(commission_pct, salary)
FROM employees;

/*
1. coalesce(칼럼1, 칼럼2)
    (칼럼1, 칼럼2 모두 null이면 
*/

/*
decode(컬럼, 처리1, 값2, 처리2, 그밖의 처리)
switch ~ case문과 비슷
*/
--department_id이 10이면 'ACCOUNTING' 20 - 'RESEARCH'
--                  30 - 'SALES' 40 - 'OPERATIONS', 'OTHER'
SELECT first_name, department_id,
        decode(department_id, 10, 'ACCOUNTING',
                              20, 'RESEARCH',
                              30, 'SALES',
                              40, 'OPERATIONS', 'OTHER') AS department_name
FROM employees;

-- 직급이 'PR-REP'인 사원은 5%, 'SA-MAN'인 사원은 10%
-- 'AC_NGR'인 사원은 15%, 'PU_CLERK'인 사원은 20% 인상
SELECT job_id, salary, decode(job_id, 'PR-REP', salary*1.05, 
                                      'SA-MAN', salary*1.1, 
                                      'AC_NGR', salary*1.15,
                                      'PU_CLERK', salary*1.2, salary) AS newsal
FROM employees;

/* 
case when 조건식1 then 처리1
     when 조건식2 then 처리2
     when 조건식3 then 처리3
     else 처리ㅜ
end AS alias;

java에서 다중 if-else 문과 비숫
*/
-- 입사일(hire_date) 1-3이면 '1사분기', 4-6이면 '2사분기', 7-9이면 '3사분기', 10-12이면 '4사분기'
-- 로 처리를 하고 시원명(first_name), 입사일(hire_date), 분기로 출력
SELECT first_name, hire_date, case when to_char(hire_date, 'mm')<=3 then '1사분기'
                                   when to_char(hire_date, 'mm')<=6 then '2사분기'
                                   when to_char(hire_date, 'mm')<=9 then '3사분기'
                                   when to_char(hire_date, 'mm')<=12 then '4사분기'
                              end AS 분기
FROM employees;

-- salary의 값이 10000 미만이면 '하', 10000 이상 20000미만이면 '중', 20000이상이면 '상'

SELECT first_name, salary,
       case when salary < 10000 then '하'
            when salary < 20000 then '중'
            else '상'
       end AS "구분"
FROM employees;

/*
집계함수(Aggregate Function), 그룹함수(Group Funstion)
max((DISTINCT) | (ALL) 컬럼) : 최대값
min((DISTINCT) | (ALL) 컬럼)
count((DISTINCT) | (ALL) 컬럼)
sum((DISTINCT) | (ALL) 컬럼)
avg((DISTINCT) | (ALL) 컬럼)
stddev((DISTINCT) | (ALL) 컬럼) 표준편차
variance((DISTINCT) | (ALL) 컬럼) 분산
*/

SELECT max(salary), min(salary), count(salary), sum(salary), avg(salary), stddev(salary), variance(salary)
FROM employees;

-- null값이 아닌 레코드 수 반환
SELECT count(commission_pct)
FROM employees;

SELECT count(employees_id)
FROM employees;

SELECT count(*)
FROM employees;

SELECT count(DISTINCT commission_pct)
FROM employees;

SELECT count(ALL commission_pct)
FROM employees;

-- 집계함수와 단순컬럼은 함께 사용할 수 없다.(출력되는 레코드의 수가 다르기 때문)
SELECT first_name, count(*)
FROM employees;

-- 그룹함수와 단순컬럼을 함께 사용하려면 단순컬럼을 그룹화 해야함
SELECT department_id, count(*)
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- 50이하인 부서에 대해서 NULL이 아닌 부서별 직원수를 출력
SELECT department_id, count(*)
FROM employees
WHERE department_id <= 50 AND department_id IS NOT NULL
GROUP BY  department_id;

SELECT department_id, count(*)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING department_id <= 50;

-- 부서별의 직원수가 5이하인 경우만 출력
SELECT department_id, count(*)
FROM employees
GROUP BY department_id
HAVING count(*) <= 5;

-- 업무별(job_id) 급여 합계
SELECT job_id, sum(salary)
FROM employees
GROUP BY job_id;

--부서별 최소 최대 급여
SELECT department_id, min(salary), max(salary)
FROM employees
GROUP BY department_id
HAVING min(salary) != max(salary)
ORDER BY department_id;

// 내림차순으로 정렬하면 NULL이 최상위에 출력
SELECT department_id
FROM employees
ORDER BY department_id DESC;

select first_name
from employees
where substr(first_name, 3, 1)='e';


/*
rownum
1. oracle의 select 문 결과에 대해서 논리적인 일련번호를 부여한다.
2. rownum은 조회되는 행수를 제한할 때 많이 사용된다.
3. rownum=1, rownum<=3 가능
    rownum=3, rownum>=3 불가능
*/
select rownum, first_name, salary
from employees;

select rownum, first_name, salary
from employees
where rownum = 1;

select rownum, first_name, salary
from employees
where rownum <= 3;

select rownum, first_name, salary
from employees
where rownum = 3; --X

/*
rowid
1. oracle에서 데이터를 구분할 수 있는 유일한 값이다.
2. select문에서 rowid를 사용할 수 있다.
3. rowid를 통해서 데이터가 어떤 데이터파일, 어느 블록에 저장되어 있는지 알수있다.
4. rowid 구조 (총 18자리)
    오브젝트 번호(1~6) : 오브젝트 별로 유일한 값을 가지고 있으며, 해당 오브젝트가 속해 있는 것이다.
    파일 번호(7~9) : 테이블스페이스에 속해있는 데이터파일에 대한 상대 파일번호이다.
    블록 정보(10~15) : 데이터 파일 내부에서 어느 블록에 데이터가 있는지 알려준다.
    데이터번호(16~18) : 데이터 블록에 데이터가 저장되어 있는 순서를 의미한다.

block size 확인 - 8kbyte가 저장됨
SQL> conn sys/a1234 as sysdba
Connected.
SQL> show user
USER is "SYS"
SQL> show parameter db_block_size
     NAME                 TYPE                 VALUE
----------------- ---------------------- ---------------------
db_block_size            integer                8192
*/
select rowid, first_name, salary
from employees;