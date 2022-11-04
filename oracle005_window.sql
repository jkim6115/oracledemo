/*
rollup()함수, cude()함수
*/
select department_id, job_id, count(*)
from employees
group by department_id, job_id
order by department_id, job_id;

/*
rollup(컬럼1, 컬럼2)
(컬럼1, 컬럼2)
(컬럼1)
()

rollup(departmant_id, job_id)
20 MK_MAN 1 -- 그룹
20 MK_REP 1 -- 그룹
20        2 -- 그룹
          107 -- 총계
*/

select department_id, count(*)
from employees
group by rollup(department_id)
order by department_id;

select department_id, job_id, count(*)
from employees
group by rollup(department_id, job_id)
order by department_id, job_id;

/*
cube() 함수
cube(컬럼1, 컬럼2)
    (컬럼1, 컬럼2)
    (컬럼1)
    ()
cube(department_id, job_id)
20 MK_MAN 1 -- 그룹
20 MK_REP 1 -- 그룹
20        2 -- 그룹
   MK_MAN 1 -- 소계
   MK_REP 1 -- 소계
          107 -- 총계
*/
select department_id, count(*)
from employees
group by cube(department_id)
order by department_id;

select department_id, job_id, count(*)
from employees
group by cube(department_id, job_id)
order by department_id, job_id;

select department_id, job_id, count(*)
from employees
group by cube((department_id, job_id))
order by department_id, job_id;

/*
grouping sets() 함수
*/
select department_id, job_id, count(*)
from employees
group by grouping sets(department_id), grouping sets(job_id)
order by department_id, job_id;

select case department_id 
            when 10 then 'A'
            when 20 then 'B'
            else 'C'
        end as "alias"
from employees;

select case grouping(d.department_name)
            when 1 then 'All Departments'
            else d.department_name
        end as "dname",
        case grouping(e.job_id)
            when 1 then 'All Jobs'
            else e.job_id
        end as "JOB",
        count(*) as "Total sal",
        sum(e.salary) as "total sal" 
from employees e, departments d
where e.department_id = d.department_id
group by rollup(d.department_name, job_id);

/*
그룹내 순위 관련 함수
rank() over() : 특정 컬럼에 대한 순위를 구하는 함수로 동일한 값에 대해서는 동일한 순위를 준다.
dence() over() : 동일한 순위를 하나의 건수로 취급한다.
row() over() : 동일한 값이라도 고유한 순위를 부여한다.
*/

select job_id, first_name, salary, rank() over(order by salary desc)
from employees;

// 그룹별로 순위를 부여할 때 사용 partition by
select job_id, first_name, salary, rank() over(partition by job_id order by salary desc)
from employees;

select job_id, first_name, salary, dense_rank() over(partition by job_id order by salary desc)
from employees;

select job_id, first_name, salary, row_number() over(partition by job_id order by salary desc)
from employees;

/*
계층형 질의
*/
select first_name, lpad(first_name,10)
from employees;

select first_name, lpad(first_name,10, '*')
from employees;

-- 매니저 -> 사원
select employee_id, level, lpad(' ', 3*(level-1)) || first_name
from employees
start with manager_id is null
connect by prior employee_id = manager_id;

select employee_id, first_name, manager_id
from employees;

/*=====================================================================================================
 계층형 질의
 1. START WITH 절은 계층구조 전개의 시작 위치를 지정하는 구문이다. 
 2. CONNECT BY 절은 다음에 전개될 자식 데이터를 지정하는 구문이다. 
 3. 루트 데이터는 LEVEL 1이다. (0이 아님) (의사컬럼)
    (1)CONNECT_BY_ROOT(의사컬럼)  
       - 현재 조회된 최상위 정보 
    (2)CONNECT_BY_ISLEAF(의사컬럼) 
       - 현재 행이 마지막 계층의 데이터인지 확인 
       - LEAF을 만나면 1을 반환하고 0을 반환
    (3) SYS_CONNECT_BY_PATH( 컬럼, 구분자)(의사컬럼)
        - 루트 노드부터 해당 행까지의 겨올를 입력한 컬럼기준으로 구분자를 사용해서 보여줌  
    (4)CONNECT_BY_ISCYCLE(의사컬럼)  
       - 현재 행의 조상이기도 한 자식을 갖는 경우 1을 반환 
       - 이 의사컬럼을 사용하기 위해서 CONNECT BY다음에 NOCYCLE을 사용해야한다.
 4. PRIOR 자식 = 부모 (부모->자식 방향으로 전개. 순방향 전개)
    PRIOR 부모 = 자식 (자식->부모 방향으로 전개. 역방향 전개)
 ===================================================================================*/

-- 사원 -> 매니저
select employee_id, manager_id, level, lpad(' ', 3*(level-1)) || first_name
from employees
start with manager_id is not null
connect by prior manager_id = employee_id;

select employee_id, manager_id, level, lpad(' ', 3*(level-1)) || first_name, connect_by_root employee_id
from employees
start with manager_id is null
connect by prior employee_id = manager_id;

select employee_id, manager_id, level, lpad(' ', 3*(level-1)) || first_name, connect_by_isleaf
from employees
start with manager_id is null
connect by prior employee_id = manager_id;

-- order siblings by 레벨 단위로 정렬해줌
SELECT employee_id, manager_id, LEVEL, LPAD(' ', 3*(LEVEL-1)) || first_name, CONNECT_BY_ISLEAF,
        SYS_CONNECT_BY_PATH(first_name, '/')
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY first_name;

