/*------------------------------
문제
------------------------------*/
--1) 모든사원에게는 상관(Manager)이 있다. 하지만 employees테이블에 유일하게 상관이
--   없는 로우가 있는데 그 사원(CEO)의 manager_id컬럼값이 NULL이다. 상관이 없는 사원을
--   출력하되 manager_id컬럼값 NULL 대신 CEO로 출력하시오.
SELECT first_name, nvl(to_char(manager_id), 'CEO')
FROM employees;

--2) 가장최근에 입사한 사원의 입사일과 가장오래된 사원의 입사일을 구하시오.
SELECT max(hire_date), min(hire_date)
FROM employees;
 
--3) 부서별로 커미션을 받는 사원의 수를 구하시오.
SELECT department_id ,sum(nvl2(commission_pct, 1, 0)) AS "커미션 지급 사원수"
FROM employees
GROUP BY department_id;

   
--4) 부서별 최대급여가 10000이상인 부서만 출력하시오.   
SELECT department_id, max(salary)
FROM employees
WHERE salary >= 10000
GROUP BY department_id
ORDER BY department_id;

--5) employees 테이블에서 직종이 'IT_PROG'인 사원들의 급여평균을 구하는 SELECT문장을 기술하시오.
select job_id, avg(salary)
from employees
group by job_id
order by job_id;

--6) employees 테이블에서 직종이 'FI_ACCOUNT' 또는 'AC_ACCOUNT' 인 사원들 중 최대급여를  구하는    SELECT문장을 기술하시오.   
select job_id, max(salary)
from employees
where job_id = 'FI_ACCOUNT' or job_id = 'AC_ACCOUNT'
group by job_id;
  

--7) employees 테이블에서 50부서의 최소급여를 출력하는 SELECT문장을 기술하시오.
select department_id, min(salary)
from employees
where department_id = 50
group by department_id;
    
--8) employees 테이블에서 아래의 결과처럼 입사인원을 출력하는 SELECT문장을 기술하시오.
--   <출력:  2001		   2002		       2003
 --  	     1          7                6   >
select to_char(hire_date, 'yyyy'),  sum(nvl2(to_char(hire_date, 'yyyy'), 1, 0))  		   
from employees
group by to_char(hire_date, 'yyyy')
order by to_char(hire_date, 'yyyy');
    
--9) employees 테이블에서 각 부서별 인원이 10명 이상인 부서의 부서코드,
--  인원수,급여의 합을 구하는  SELECT문장을 기술하시오.
select department_id, count(department_id), sum(salary)
from employees
group by department_id
having count(department_id) >= 10;
  
  
--10) employees 테이블에서 이름(first_name)의 세번째 자리가 'e'인 직원을 검색하시오.
select first_name
from employees
where instr(first_name, 'e') = 3;