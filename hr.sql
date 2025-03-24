-- employees (scott의 emp 동일개념)
-- first_name, last_name, job_id 조회
SELECT e.FIRST_NAME, e.LAST_NAME, e.JOB_ID FROM EMPLOYEES e; 

-- job_id 중복 제외 후 출력
SELECT DISTINCT  e.JOB_ID FROM EMPLOYEES e;  --DISTINCT : 중복 제외(2개 이상 요소 조회 할 때는 두 요소가 완전히 같아야 중복)

--사번이 176인 사원의 last_name과 부서번호 조회하기
SELECT
	e.LAST_NAME,
	e.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	e.EMPLOYEE_ID = 176;
--급여가 12000이상되는 사원의 last_name과 급여 조회하기
SELECT
	e.LAST_NAME,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	e.SALARY >= 12000;

--급여가 5000~12000범위가 아닌 사원의 last_name과 급여 조회하기 
SELECT
	e.LAST_NAME,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	NOT (e.SALARY >= 5000
		AND e.SALARY <= 12000); 

--위에거 BETWEEN으로 가능
SELECT
	*
FROM
	EMPLOYEES e
WHERE
	e.SALARY NOT BETWEEN 5000 AND 12000;

--IN
--20,50번 부서에 근무하는 사원 조회(LAST_NAME, 부서번호,), 그리고 LAST_NAME 오름차순
SELECT
	e.LAST_NAME,
	e.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	e.DEPARTMENT_ID IN(20, 50)
ORDER BY
	E.LAST_NAME ASC;
--급여가 2500,3500,7000이 아니고 직무가 SA_REP, ST_CLERK가 아닌 사원 조회
SELECT
	*
FROM
	EMPLOYEES e
WHERE
	e.SALARY NOT IN(2500, 3500, 7000)
	AND e.JOB_ID NOT IN('SA_REP', 'ST_CLERK');

--날짜 데이터도 '' 사용
--고용일이 2014년인 사원 조회(2014-01-01 ~ 2014-12-31)
SELECT
	*
FROM
	EMPLOYEES e
WHERE
	e.HIRE_DATE BETWEEN '2014-01-01' AND '2014-12-31';

--LIKE
-- ex1)LAST_NAME에 U가 포함되는 사원들의 사번, LAST_NAME 조회
SELECT
	e.EMPLOYEE_ID,
	e.LAST_NAME
FROM
	EMPLOYEES e
WHERE
	e.LAST_NAME LIKE '%U%';
-- ex2)LAST_NAME의 4번째 글자가 a인 사원들의 사번 LAST_NAME 조회
SELECT
	e.EMPLOYEE_ID,
	e.LAST_NAME
FROM
	EMPLOYEES e
WHERE
	e.LAST_NAME LIKE '___a%';
-- ex3)LAST_NAME에 a 혹은 e가 있는 사람들의 사번, LAST_NAME조회 (LAST_NAME내림차순)
SELECT
	e.EMPLOYEE_ID,
	e.LAST_NAME
FROM
	EMPLOYEES e
WHERE
	e.LAST_NAME LIKE '%a%'
	OR e.LAST_NAME LIKE '%e%'
ORDER BY
	e.LAST_NAME DESC ;
-- ex4)LAST_NAME에 a와 e가 모두 있는 사원의 사번, LAST_NAME조회(LAST_NAME내림차순)
SELECT
	e.EMPLOYEE_ID,
	e.LAST_NAME
FROM
	EMPLOYEES e
WHERE
	e.LAST_NAME LIKE '%a%e%'
	or e.LAST_NAME LIKE '%e%a%'
ORDER BY
	e.LAST_NAME DESC;

--IS NULL
-- ex1) 매니저가 없는 사원들의 LAST_NAME, JOB_ID 조회
SELECT
	e.LAST_NAME,
	e.JOB_ID
FROM
	EMPLOYEES e
WHERE
	e.MANAGER_ID IS NULL;

-- ex2) ST_CLERK인 직업을 가진 사원이 없는 부서 번호 조회(단, 부서번호가 널 값인 부서 제외)
SELECT
	DISTINCT e.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	e.JOB_ID != 'ST_CLERK' -- NOT e.JOB_ID = 'ST_CLERK' 으로도 가능
	AND e.DEPARTMENT_ID IS NOT NULL
ORDER BY
	e.DEPARTMENT_ID; --중복 제외랑 정렬은 내가 그냥 한 것임
	
-- ex3) COMMISSION_PCT가 NULL이 아닌 사원들 중에서 COMMISSION=SALARY * COMMISSION_PCT를 구한다
--      계산결과와 함께 사번, FIRST_NAME, JOB_ID를 출력
SELECT
	e.SALARY * e.COMMISSION_PCT AS COMMISSION,
	e.EMPLOYEE_ID,
	e.FIRST_NAME,
	e.JOB_ID
FROM
	EMPLOYEES e
WHERE
	e.COMMISSION_PCT IS NOT NULL;

--FIRST_NAME이 'Curtis'인 사람의 first_name과 last_name, email, phone_number, job_id 조회
--단 job_id 결과는 소문자로 출력한다.
SELECT
	e.FIRST_NAME,
	e.LAST_NAME,
	e.EMAIL,
	e.PHONE_NUMBER,
	LOWER(e.JOB_ID) AS JOB_ID
	--필드명도 소문자로 바뀌니까 그냥 AS 해주는거
FROM
	EMPLOYEES e
WHERE
	e.FIRST_NAME = 'Curtis';


--부서번호가 60,70,80,90인 사원들의 사번, first_name, last_name, hire_date, job_id 조회
--단, job_id가 IT_PROG인 사원의 경우 '프로그래머'로 변경하여 출력한다
SELECT
	e.EMPLOYEE_ID,
	e.FIRST_NAME,
	e.LAST_NAME,
	e.HIRE_DATE,
	REPLACE(e.JOB_ID, 'IT_PROG', '프로그래머') AS JOB_ID
FROM
	EMPLOYEES e
WHERE
	e.DEPARTMENT_ID IN (60, 70, 80, 90);


--job_id가 AD_PRES, PU_CLERK인 사원들의 사번, first_name, last_name, 부서번호, JOB_ID조회
--단, 사원명은 first_name, last_name을 연결하여 출력한다(예 '이름 성')
SELECT
	e.EMPLOYEE_ID,
	e.FIRST_NAME || ' ' || e.LAST_NAME AS NAME,--별칭은 그냥 함
	e.DEPARTMENT_ID,
	e.JOB_ID
	
FROM
	EMPLOYEES e
WHERE
	e.JOB_ID IN ('AD_PRES', 'PU_CLERK');


--입사 10주년이 되는 날짜를 출력 하고 싶음
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.HIRE_DATE , ADD_MONTHS(E.HIRE_DATE,120) 
FROM EMPLOYEES e ;



--회사 내에 최대 연봉자와 최소 연봉자의 차를 구해라
SELECT max(e.SALARY) - min(e.SALARY) AS 연봉차이
FROM EMPLOYEES e ;

--매니저로 근무하는 사원들 숫자 조회
SELECT count(DISTINCT e.MANAGER_ID)
FROM EMPLOYEES e ;



-- 부서 별 직원 수를 구하기(부서번호 오름차순)
--부서번호, 직원수
SELECT e.DEPARTMENT_ID, COUNT(e.EMPLOYEE_ID) AS 직원수
FROM EMPLOYEES e 
GROUP BY e.DEPARTMENT_ID
ORDER BY e.DEPARTMENT_ID;


--부서 별 평균 연봉 조회(부서번호 오름차순)
--부서번호 평균연봉(2215.45 => 2215)
SELECT e.DEPARTMENT_ID, round(AVG(e.SALARY)) AS 평균연봉
FROM EMPLOYEES e 
GROUP BY e.DEPARTMENT_ID
ORDER BY e.DEPARTMENT_ID;

--동일한 직무를 가진 사원의 수 조회
--job_id 인원수 
SELECT e.JOB_ID, COUNT(e.EMPLOYEE_ID) AS 해당직무직원수
FROM EMPLOYEES e 
GROUP BY e.JOB_ID;



--------------------------------------------------------------------------------------------------

-- 직업 id가 SA_MAN 인 사원들의 최대 연봉보다 높게 받는 사원들의 
-- last_name, job_id, salary 조회
SELECT
	e.LAST_NAME ,
	e.JOB_ID ,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	e.salary > (
	SELECT
		max(e.SALARY)
	FROM
		employees e
	WHERE
		e.JOB_ID = 'SA_MAN');


-- 커미션을 받는 사원들의 부서와 연봉이 동일한 사람들의 last_name, deptno, salary 조회
SELECT e.LAST_NAME, e.DEPARTMENT_ID , e.SALARY, e.COMMISSION_PCT FROM EMPLOYEES GROUP BY  e WHERE e.COMMISSION_PCT >0;

SELECT AVG(e.SALARY) FROM EMPLOYEES e WHERE e.COMMISSION_PCT >0; 

-- 회사 전체 평균 연봉보다 더 버는 사원들 중 last_name에 u가 있는 사원들이 근무하는 부서와 같은 부서에 근무하는 사원들의 
-- 사번, last_name, salary 조회 
    SELECT e.EMPLOYEE_ID, e.LAST_NAME, e.SALARY FROM employees e WHERE e.salary > (SELECT AVG(e.SALARY) FROM EMPLOYEES e) 
    AND (SELECT e.DEPARTMENT_ID  FROM employees e WHERE e.LAST_NAME ) 

-- 각 부서별 평균 연봉보다 더 받는 동일부서 사원들의 last_name, salary, deptno, 해당 부서의 평균연봉 조회(부서별 평균 연봉을 기준으로 오름차순)
SELECT e.LAST_NAME, e.SALARY, e.DEPARTMENT_ID , AVG(e.SALARY)  FROM EMPLOYEES e 

-- last_name 이 'Davies'인 사람보다 나중에 고용된 사원들의 last_name, hire_date 조회 
SELECT
	e.LAST_NAME,
	e.HIRE_DATE
FROM
	EMPLOYEES e
WHERE
	e.HIRE_DATE > (
	SELECT
		e.HIRE_DATE
	FROM
		EMPLOYEES e
	WHERE
		e.LAST_NAME = 'Davies' ); 
-- last_name 이 'King'인 사원을 매니저로 두고 있는 모든 사원들의 last_name, salary 조회
SELECT
	e.LAST_NAME,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	e.MANAGER_ID = (
	SELECT
		e.EMPLOYEE_ID
	FROM
		EMPLOYEES e
	WHERE
		e.LAST_NAME = 'King'
		AND e.EMPLOYEE_ID = ANY(SELECT e.MANAGER_ID FROM EMPLOYEES e) );

SELECT e.MANAGER_ID FROM EMPLOYEES e ORDER BY e.MANAGER_ID;

-- last_name 이 'Hall'인 사원과 동일한 연봉 및 커미션을 받는 사원들의 last_name, 부서번호, 연봉 조회
-- 단 Hall은 제외
SELECT
	e.LAST_NAME,
	e.DEPARTMENT_ID,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	e.SALARY = (
	SELECT
		e.SALARY
	FROM
		EMPLOYEES e
	WHERE
		e.LAST_NAME = 'Hall' )
	OR e.COMMISSION_PCT = (
	SELECT
		e.COMMISSION_PCT
	FROM
		employees e
	WHERE
		e.LAST_NAME = 'Hall')
	AND e.LAST_NAME != 'Hall';


-- last_name 이 'Zlotkey'인 사원과 동일한 부서에서 근무하는 모든 사원들의 사번, 고용날짜 조회
-- 단, Zlotkey 제외
SELECT
	e.EMPLOYEE_ID,
	e.HIRE_DATE,
	e.LAST_NAME
FROM
	EMPLOYEES e
WHERE
	e.DEPARTMENT_ID = (
	SELECT
		e.DEPARTMENT_ID
	FROM
		EMPLOYEES e
	WHERE
		e.LAST_NAME = 'Zlotkey')
;  

-- 부서가 위치한 지역의 국가 ID 및 국가명을 조회한다
-- Location 테이블, departments, contries 테이블 사용
SELECT c.COUNTRY_ID, c.COUNTRY_NAME FROM LOCATIONS l , DEPARTMENTS d , COUNTRIES c GROUP BY d.DEPARTMENT_ID; 



-- 위치 ID가 1700인 사원들의 연봉과 커미션을 추출한 뒤, 추출된 사원들의 연봉과 커미션이 동일한 사원정보 출력
-- 출력: 사번, 이름(first_name + last_name), 부서번호, 급여
SELECT e.SALARY*12 AS 연봉, e.COMMISSION_PCT  FROM EMPLOYEES e, LOCATIONS l WHERE l.LOCATION_ID =1700 ORDER BY e.SALARY;

SELECT e.EMPLOYEE_ID, (e.FIRST_NAME ||' '||e.LAST_NAME), e.DEPARTMENT_ID , e.SALARY FROM EMPLOYEES e
WHERE e.salary = ANY (SELECT e.SALARY  FROM EMPLOYEES e, LOCATIONS l WHERE l.LOCATION_ID =1700 );
AND WHERE e.COMMISSION_PCT = ANY (SELECT e.COMMISSION_PCT FROM EMPLOYEES e, LOCATIONS l WHERE l.LOCATION_ID =1700 );





















