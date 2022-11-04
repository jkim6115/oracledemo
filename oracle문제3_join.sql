/*----------------------------------------------
 문제
 ----------------------------------------------   */
1)EMPLOYEES 테이블에서 입사한 달(hire_date) 별로 인원수를 조회하시오 . 
  <출력: 월        직원수   >
select to_char(hire_date, 'mm') as 월, count(*) as 직원수
from employees
group by to_char(hire_date, 'mm')
order by 월;

2)각 부서에서 근무하는 직원수를 조회하는 SQL 명령어를 작성하시오. 
단, 직원수가 5명 이하인 부서 정보만 출력되어야 하며 부서정보가 없는 직원이 있다면 부서명에 “<미배치인원>” 이라는 문자가 출력되도록 하시오. 
그리고 출력결과는 직원수가 많은 부서먼저 출력되어야 합니다.
select d.department_id, nvl(d.department_name,'<미배치인원>'), count(*) as 인원수
from employees e inner join departments d
on e.department_id = d.department_id(+) /* left outer join */
group by d.department_id, d.department_name
having count(*) <= 5
order by count(*) desc;
 

3)각 부서 이름 별로 2005년 이전에 입사한 직원들의 인원수를 조회하시오.
 <출력 :    부서명		입사년도	인원수  >
select d.department_name as 부서명, to_char(e.hire_date,'yyyy') as 입사년도, count(*) as 인원수
from employees e inner join departments d
on e.department_id = d.department_id
having to_char(e.hire_date,'yyyy') <= '2005'
group by to_char(e.hire_date,'yyyy'), d.department_name
order by 입사년도 desc;

 
 
4)직책(job_title)에서 'Manager'가 포함이된 사원의 이름(first_name), 직책(job_title), 부서명(department_name)을 조회하시오.
select e.first_name as 사원이름, j.job_title as 직책, d.department_name as 부서명
from employees e inner join jobs j
on e.job_id = j.job_id inner join departments d on e.department_id = d.department_id
where j.job_title like '%Manager%';
  
5)'Executive' 부서에 속에 있는 직원들의 관리자 이름을 조회하시오. 
단, 관리자가 없는 직원이 있다면 그 직원 정보도 출력결과에 포함시켜야 합니다.
 <출력 : 부서번호 직원명  관리자명  >
select d.department_id as 부서번호, w.first_name as 직원명, m.first_name as 관리자명
from departments d, employees w, employees m 
where m.manager_id = w.employee_id(+)
and w.department_id = d.department_id
and d.department_name = 'Executive';


 