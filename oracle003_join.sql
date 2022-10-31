/*
join
1. 여러개의 테이블에서 원하는 데이터를 추출해주는 쿼리문
2. join은 oracle제품에서 사용되는 oracle용 join이 있고
    모든 제품에서 공통적으로 사용되는 표준(ansi)join이 있다.
*/

/*
1. equi join
    가장 많이 사용되는 join으로 조인 대상이 되는 두 테이블에서 공통적으로 존재하는 컬럼의 값이
    일치되는 행을 연결하고 결과를 생성하는 방법
*/
-- oracle용 equi join
select dept.department_id, emp.first_name, emp.job_id, dept.department_name
from employees emp, departments dept
where emp.department_id = dept.department_id;

-- ansi용 inner join
select dept.department_id, emp.first_name, emp.job_id, dept.department_name
from employees emp inner join departments dept
on emp.department_id = dept.department_id;

-- employees와 department테이블에서 사원번호(employees_id), 부서번호(department_id), 부서명(department_name)을 검색
select emp.employee_id, dept.department_id, dept.department_name
from employees emp inner join departments dept
on emp.department_id = dept.department_id
order by emp.employee_id;

--employees 와 jobs 테이블에서 사원번호(employee_id), 업무번호(job_id), 업무명(jb_title)을 검색
select e.employee_id, j.job_id, j.job_title
from employees e inner join jobs j
on e.job_id = j.job_id
order by e.employee_id;

--job_id가 'FI_MGR'인 사원이 속한
--급여(salary)의 최솟값(min_salary), 최대값(max_salary)을 출력
select e.first_name, e.job_id, j.min_salary, j.max_salary
from employees e inner join jobs j
on e.job_id = j.job_id
where j.job_id = 'FI_MGR';

/*
선행테이블(Driving) - 후행테이블(Driven)

*/
