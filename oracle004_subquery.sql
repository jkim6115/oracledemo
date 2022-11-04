/*
서브쿼리
1. 스칼라 쿼리 : select
2. 인라인 뷰 : from
3. 서브쿼리 : where
*/

-- 90번 부서에 근무하는 Lex사원의 근무하는 부서명을 출력
select department_name 
from departments
where department_id = 90;

-- 'Lex'가 근무하는 부서명을 출력
select department_id
from employees
where first_name = 'Lex';

select department_name 
from departments
where department_id = 90;

select d.department_name 
from employees e inner join departments d
on e.department_id = d.department_id
where e.first_name = 'Lex';

select department_name 
from departments
where department_id=(
                    select department_id
                    from employees
                    where first_name = 'Lex'
                    );

-- 'Lex'와 동일한 업무를 가진 사원의 이름, 업무명, 입사일 출력
select e.first_name, j.job_title, e.hire_date
from employees e, jobs j
where e.job_id = j.job_id
and e.job_id = (
                select job_id
                from employees
                where first_name = 'Lex'
                );

-- 'IT'에 근무하는 사원 이름, 부서번호 출력
select first_name, department_id
from employees
where department_id = (
                        select department_id
                        from departments
                        where department_name = 'IT'
                        );
                        
-- 'Bruce'보다 급여를 많이 받는 사원이름, 부서명, 급여를 출력
select e.first_name, d.department_name, e.salary
from employees e, departments d
where e.department_id = d.department_id
and e.salary > (
                select salary
                from employees
                where first_name = 'Bruce'
                )
order by e.salary;

select e.first_name, e.salary, e.hire_date
from employees e
where department_id in (
                        select department_id
                        from employees
                        where first_name = 'Steven'
                        );

-- 부서별로 가장 급여를 많이 받는 사원이름, 부서번호, 급여를 출력하시오.
select e.first_name, e.department_id, e.salary
from employees e
where (e.department_id, e.salary) in (
                                        select department_id, max(salary)
                                        from employees
                                        group by department_id
                                     )
order by e.department_id;

-- 30소속된 사원들의 급여 보다 더 많은 급여를 받는
-- 사원이름, 급여, 입사일을 출력
select salary
from employees
where department_id = 30;

select first_name, salary, hire_date
from employees
where salary >ALL (
                    select salary
                    from employees
                    where department_id = 30
                    );
                    
-- 30소속된 사원들의 급여 보다 더 많은 급여를 받는
-- 사원이름, 급여, 입사일을 출력 (any)

select first_name, salary, hire_date
from employees
where salary >any (
                    select salary
                    from employees
                    where department_id = 30
                    )
order by salary;

-- 20번 부서에 사원이 잇으면 사원명, 입사일, 급여, 부서번호 출력)
select first_name, hire_date, salary, department_id
from employees
where exists (
                select department_id
                from employees
                where department_id = 20
            );

-- 사원이 있는 부서만 출력하시오
select count(*)
from departments;

select department_id, department_name
from departments
where department_id in (
                        select department_id
                        from employees
                        where department_id is not null
                        --group by department_id
                        );

-- 사원이 없는 부서                        
select department_id, department_name
from departments d
where not exists (
                select 1
                from employees e
                where e.department_id = d.department_id
            );

-- 부서가 있는 사원의 정보
select e.employee_id, e.first_name, e.department_id
from employees e
where exists (
                select 1
                from departments d
                where e.department_id = d.department_id
            );

-- 부서가 없는 사원의 정보
select e.employee_id, e.first_name, e.department_id
from employees e
where not exists (
                select 1
                from departments d
                where e.department_id = d.department_id
            );   
            
-- 관리자가 있는 사원의 정보를 출력
select count(*)
from employees
where manager_id is not null;

select w.employee_id, w.first_name, w.manager_id
from employees w
where exists (
              select 1
              from employees m
              where w.manager_id = m.employee_id
            );

/*
 top-n 서브쿼리
    상위의 값을 추출할 때 사용한다.
    <, <= 연산자를 사용할 수 있다. 단 비교되는 값이 1일 때는 =도 가능하다
    order by 절을 사용할 수 있다.
*/

-- 급여가 가장 높은 상위 3명을 검색하시오.
select rownum, emp.first_name, emp.salary
from (
        select first_name, salary
        from employees
        order by salary desc
    ) emp
where rownum <= 3;

-- 급여가 가장 높은 상위 4위부터 8위까지 검색
select emp2.*
from(
    select rownum as rm, emp.*
    from  (
          select first_name, salary
          from employees
          order by salary desc   
          )emp
    )emp2
where emp2.rm >= 4 and emp2.rm <= 8;

-- 월별 입사사 수를 조회하되 입사자수가 가장 많은 상위 3개만 출력
-- 출력 : 월       입사자수
select rownum as rm, emp.*
from (
    select to_char(hire_date, 'mm') as 월, count(*) as 입사자수
    from employees
    group by to_char(hire_date, 'mm')
    order by count(*) desc
    )emp
where rownum <= 3;