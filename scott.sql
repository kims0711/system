-- 오라클 관리자 
-- system, sys(최고권한)

-- <sys로 접근하는 방법>
-- 사용장 이름: sys as sysdba
-- 비밀번호: 그냥 엔터

-- 오라클 12c버전부터 일반적으로 사용자 계정 생성 시 접두어(c##)를 요구함
-- c##hr
-- c## 사용하지 않을때 아래 ㄱㄱ 
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- 비밀번호 변경
-- 비밀번호만 대소문자 구별함 
ALTER USER scott IDENTIFIED BY tiger; 

-- 계정 잠김 해제
ALTER USER scott account unlock;

--중복 제외 : select distinct

-- 별칭 만들기
SELECT ename, sal, sal*12+comm AS "annsal",comm FROM EMP; --AS는 선택

SELECT ename, sal, sal*12+comm AS annsal, comm   FROM EMP;

SELECT ename, sal, sal*12+comm,comm AS 연봉 FROM EMP;

SELECT ename, sal, sal*12+comm,comm AS "연 봉" FROM EMP; --이름에 공백에 있으면 쌍따옴표 필수이다!

SELECT ename 사원명, sal 급여, sal*12+comm "연 봉",comm 수당 FROM EMP e; --여기서 EMP e의 e도 별칭이다(필수는 아님)

--원하는 순서대로 출력 데이터를 정렬하여 조회하기
--emp 테이블의 모든 열을 급여 기준으로 오름차순 조회 
SELECT * FROM EMP e ORDER BY e.SAL ASC; -- ASC : 오름차순 -> 근데 default가 오름차순이라 ASC는 생략 가능하다!
SELECT * FROM EMP e ORDER BY e.SAL DESC; -- DESC: 내림차순 
SELECT * FROM emp e ORDER BY e.sal; -- default가 오름차순이라서 얘도 ASC랑 똑같이 나옴

--사번,이름,직무만 급여기준으로 내림차순 조회
SELECT e.DEPTNO, e.ENAME, e.JOB FROM EMP e ORDER  BY e.SAL DESC;
SELECT e.DEPTNO, e.ENAME, e.JOB, e.SAL FROM EMP e ORDER  BY e.SAL DESC; --그냥 급여도 출력해서 확인해봄

-- 부서번호의 오름차순, 급여의 내림차순
SELECT * FROM EMP e ORDER BY e.DEPTNO ASC, e.SAL DESC;

-- 별칭 바꾸고 조건에 맞춰서 정렬 후 조회하기
SELECT
	e.EMPNO AS EMPLOYEE_NO,
	e.ENAME AS EMPLOYEE_NAME,
	e.MGR AS MANAGER,
	e.sal AS SALARY,
	e.COMM AS COMMISION,
	e.DEPTNO AS DEPARTMENT_NO
FROM
	emp e
ORDER BY
	e.DEPTNO DESC,
	e.ENAME ASC;

-- where : 조회 시 조건 부여
-- 부서번호가 30번인 사원 조회 
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 30;

--사원번호가 7782인 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.EMPNO = 7782;

--부서번호가 30이고 직책이 sales man인 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.DEPTNO=30
	AND e.JOB = 'SALESMAN'; --오라클에서 문자열은 ''임 !! (그리고 문자열은 정확히 대소문자 구분 해줘야 함)
	
--사원번호가 7499이고 부서번호가 30번인 사원 조회 -> AND
SELECT
	*
FROM
	emp e
WHERE
	e.EMPNO = 7499
	AND e.DEPTNO = 30;

--사원번호가 7499이거나 부서번호가 30번인 사원 조회 -> OR
SELECT
	*
FROM
	emp e
WHERE
	e.EMPNO = 7499
	OR e.DEPTNO = 30;


--where절에서 쓸 수 있는 연산자
-- 1)산술연산자: + - * /
-- 2)비교연산자: >, <, >=, <=
-- 3)등가비교연산자: 같다 =, 같지않다 (!=, <>, ^=)
-- 4)논리부정연산자: NOT
-- 5)		   : IN 
-- 6)범위연산자: BETWEEN A AND B
-- 7)검색: LIKE 연산자와 와일드카드(_ , %)
-- 8)IS NULL : 널과 같다 (자바에서의 ==null과 같은 뜻)


--연봉이 36000인 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.SAL * 12 = 36000;

--급여가 3000이상인 사원
SELECT
	*
FROM
	emp e
WHERE
	e.sal >= 3000;

--급여가 2500 이상이고 직업이 ANALYST 인 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.SAL >= 2500
	AND e.JOB = 'ANALYST';

--문자를 대소비교 할 수 있음
--사원명의 첫 문자가 F와 같거나 F보다 뒤에 있는 사원 조회 (코드값 때문에)
SELECT
	*
FROM
	emp e
WHERE
	e.ename >= 'F';

--급여가 3000이 아닌 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.sal != 3000; --(<>랑 ^=도 가능은 함 근데 !=이 익숙하니까)
	
SELECT
	*
FROM
	emp e
WHERE
	NOT e.sal = 3000; -- 이렇게 not 이용해서도 가능
	

--In 연산자
-- job이 MANAGER이거나 SALESMAN이거나 CLERK인 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.job = 'MANAGER'
	OR e.JOB = 'SALESMAN'
	OR e.JOB = 'CLERK'; --원래 하던 방법

SELECT
	*
FROM
	emp e
WHERE
	e.job IN ('MANAGER', 'SALESMAN', 'CLERK'); -- IN 활용하여 좀 더 간단하게
	
--위 세 직업이 아닌 사원 조회하기
SELECT
	*
FROM
	emp e
WHERE
	e.job NOT IN ('MANAGER', 'SALESMAN', 'CLERK'); --그냥 NOT 앞에 붙이면 됨
	
--BETWEEN A AND B
--급여가 2000이상 3000이하
SELECT
	*
FROM
	emp e
WHERE
	e.SAL BETWEEN 2000 AND 3000; --이렇게 하면 됨
	
--NOT BETWEEN도 가능
SELECT
	*
FROM
	emp e
WHERE
	e.SAL NOT BETWEEN 2000 AND 3000; --2000미만 3000초과 

--LIKE연산자 
--_ : 어떤 값이든 상관없이 한 개의 문자열 데이터를 의미
--% : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자열 데이터를 의미

	
--ex1) 사원명이 S로 시작하는 사원을 조회하고 싶음
SELECT
	*
FROM
	emp e
WHERE
	e.ENAME LIKE 'S%';

--ex2) 사원명의 두번째 글자가 L인 사원 조회
SELECT  *
FROM emp e
WHERE e.ENAME LIKE '_L%'; --이렇게 하면 됨

--ex3) 사원명에 AM이 포함된 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.ENAME LIKE '%AM%';

--ex4) 사원명에 AM이 포함되지 않은 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.ENAME NOT LIKE '%AM%';

--IS NULL
--COMM이 NULL인 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.COMM IS NULL;

--MGR이 NULL인 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.MGR IS NULL; --mgr: 직속상관
	
--직속상관이 있는 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.MGR IS NOT NULL; -- NOT e.mgr IS NULL 도 가능했음










