-- 오라클 관리자 
-- system, sys(최고권한)

-- <sys로 접근하는 방법>
-- 사용장 이름: sys as sysdba
-- 비밀번호: 그냥 엔터

-- 오라클 12c버전부터 일반적으로 사용자 계정 생성 시 접두어(c##)를 요구함
-- c##hr
-- c## 사용하지 않을때 아래 ㄱㄱ 


--sql구문의 실행 순서 (그냥 생각해보면 당연한거)
(3) SELECT 
(1) FROM 
(2) WHERE 
(4) ORDER BY 
;

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
-- 9)집합 연산자 : UNION, MINUS, INTERSECT


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


--집합연산자
--UNION(합집합)
--부서번호 10,20 사원조회
SELECT e.EMPNO,e.ENAME,e.SAL FROM emp e WHERE e.DEPTNO =10
UNION
SELECT e.EMPNO,e.SAL FROM emp e WHERE e.DEPTNO =20; --이런식으로 위 아래 컬럼이 매칭이 안 맞으면 당연히 오류 뜬다

--위 아래 순서 달라도 아래처럼 타입만 맞으면 된다 (대응하는 애들의 타입이 맞아야한다는 뜻 int는 int랑 string은 string이랑)
SELECT e.EMPNO, e.ENAME, e.SAL FROM emp e WHERE e.DEPTNO =10
UNION
SELECT e.ENAME, e.SAL, e.EMPNO FROM emp e WHERE e.DEPTNO =20; 

--(UNION)중복 제외하고 출력 / (UNION ALL)중복 데이터도 출력
SELECT e.EMPNO, e.ENAME, e.SAL FROM emp e WHERE e.DEPTNO =10
UNION ALL 
SELECT e.EMPNO, e.ENAME , e.SAL FROM emp e WHERE e.DEPTNO =10; 


--MINUS
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e 
MINUS 
SELECT e.EMPNO, e.ename, e.deptno FROM EMP e WHERE e.deptno = 10;

SELECT e.EMPNO, e.ENAME, e.SAL FROM emp e
MINUS
SELECT e.empno, e.ENAME, e.DEPTNO FROM emp e WHERE e.DEPTNO =10;

--INTERSECT(교집합)
SELECT e.EMPNO, e.ENAME, e.SAL,e.DEPTNO FROM emp e
INTERSECT 
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM emp e WHERE e.DEPTNO =10;

--오라클 함수
--내장함수
--1) 문자함수
--대소문자를 바꿔주는 함수 : upper(), lower(), initcap()
--문자의 길이를 구하는 함수 : LEGNTH(), LENGTHB()
--문자열 일부 추출 : SUBSTR(문자열데이터, 시작위치, 추출길이) -> (자바의 subString과 같은 개념)
--문자열 데이터 안에서 특정 문자 위치 찾기 : INSTR()
--특정문자를 다른 문자로 변경 : REPLACE(원본문자열, 찾을문자열, 변경문자열)
--두 문자열 데이터를 합치기 : CONCAT(문자열1, 문자열2)
--특정 문자 제거 : TRIM(), LTRIM(), RTRIM()

--사원 이름을 대문자, 소문자, 첫문자만 대문자로 변경
SELECT e.ENAME, UPPER(e.ENAME), LOWER(e.ENAME), INITCAP(e.ENAME)
FROM emp e;

--제목 oracle 검색 (아래처럼 하면 됨)
--SELECT *
--FROM board
--WHERE upper(title) = upper('oracle')  title을 전부 대문자로 바꿔버리고 검색하는 단어인 oracle도 다 대문자로 바꿔버린 후에 비교하기(뭐가 대문자고 소문자로 검색할지 모르니까)


--사원명 길이 구하기
SELECT e.ENAME, LENGTH(e.ENAME)
FROM emp e;

--사원명이 5글자 이상인 사원 조회
SELECT *
FROM emp e
WHERE LENGTH(e.ename)>=5;

--LENGTHB : 문자열 바이트 수 반환함
--밑에서 LEGNTH=2, LENGTH=6 (이 XE버젼에서는 한글에 3BYTE 사용해서)
--DUAL : sys 소유 테이블(임시 연산이나 함수의 결과값 확인 용도로 사용) 정확히 밑과 같은 상황 
SELECT LENGTH('한글'), LENGTHB('한글') 
FROM DUAL;


SELECT e.job, SUBSTR(E.JOB, 2, 3), SUBSTR(e.JOB,5) --길이 설정 안 하면 끝까지
FROM EMP e ;


-- 시작 위치를 줄 때 양수로 주면 왼쪽, 음수로 주면 오른쪽부터 시작 위치를 잡고 맨 오른쪽부터 -1 시작임 (~ -2, -3...) 
SELECT
	e.job,
	SUBSTR(E.JOB, -LENGTH(e.JOB)),
	SUBSTR(e.JOB, -LENGTH(e.JOB),2),
	SUBSTR(e.JOB,-3)
FROM
	EMP e ;


--INSTR(대상문자열, 위치를 찾으려는 문자, 시작위치, 시작위치에서 찾으려는 문자 몇 번째인지)
SELECT
	INSTR('HELLO, ORACLE!', 'L') AS INSTR_1,
	INSTR('HELLO, ORACLE!','L', 5) AS INSTR_2,
	INSTR('HELLO, ORACLE!','L', 1, 2) AS INSTR_3
FROM
	DUAL;

--사원 이름에 S가 있는 사원 조회 
SELECT *
FROM EMP E WHERE E.ENAME LIKE '%S%';

SELECT *
FROM EMP E WHERE INSTR(e.ename, 'S')>0; --응용해서 이렇게도 가능하다 (index넘버인 int로 반환하니까 있으면 0보다 커서)

--REPLACE(원본문자열, 찾을문자열, 변경문자열)
SELECT
	'010-1234-5678' AS REPLACE_BEFORE,
	REPLACE('010-9757-6779', '-', ' ') AS REPLACE1,
	REPLACE('010-2146-5242', '-') AS REPLACE2 --변경문자열 지정 안 하면 그냥 지움
FROM
	DUAL;


--CONCAT(문자열1, 문자열2)
--사번 : 사원명
SELECT CONCAT(E.EMPNO,CONCAT(': ',E.ENAME)) AS EMPNO_ENAME
FROM EMP E;

SELECT E.EMPNO ||' : '|| E.ENAME --OR기호로도 가능(좀 더 간편)
FROM EMP E;


--TRIM(삭제옵션(선택사항), 삭제 할 문자(선택사항) FROM 원본문자열(필수))
SELECT
	'[' || TRIM(' __Oracle__ ')|| ']' AS trim, --여기서 Oracle은 원본문자열임 (원본문자열만 필수니까)
	'[' || TRIM(LEADING FROM ' __Oracle__ ')|| ']' AS trim_leading,
	'[' || TRIM(TRAILING FROM ' __Oracle__ ')|| ']' AS trim_trailing,
	'[' || TRIM(BOTH FROM ' __Oracle__ ')|| ']' AS trim_both
FROM
	DUAL; 

--LTRIM() 아무것도 안 주면 공백 제거이다 
SELECT
	'[' || TRIM(' __Oracle__ ')|| ']' AS trim, --여기서 Oracle은 원본문자열임 (원본문자열만 필수니까)
	'[' || LTRIM( ' __Oracle__ ')|| ']' AS Ltrim,
	'[' || RTRIM(' __Oracle__ ')|| ']' AS Rtrim,
	'[' || RTRIM( '<_Oracle_>','>_')|| ']' AS RTRIM2
FROM
	DUAL; 

--숫자함수 -> 자바와 하는 일 같음 
--반올림 : ROUND()
--내림 : TRUNC()
--가장 큰 정수 : CEIL() 
--가장 작은 정수 : FLOOR()
--나머지 : MOD()

SELECT -- -(마이너스)는 점 기준으로 왼쪽으로 감 (안 주거나 0을 주면 소수점 첫째자리[0])
 	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND1,
	ROUND(1234.5678, 1) AS ROUND2, --소수점 둘째자리에서 반올림 
	ROUND(1234.5678, 2) AS ROUND3,
	ROUND(1234.5678, -1) AS ROUND4,--일의자리에서 반올림
	ROUND(1234.5678, -2) AS ROUND5--10의자리에서 반올림 
FROM
	DUAL;


SELECT -- -(마이너스)는 점 기준으로 왼쪽으로 감 (안 주거나 0을 주면 소수점 첫째자리[0])
 	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC1,
	TRUNC(1234.5678, 1) AS TRUNC2,
	TRUNC(1234.5678, 2) AS TRUNC3,
	TRUNC(1234.5678, -1) AS TRUNC4,
	TRUNC(1234.5678, -2) AS TRUNC5
FROM
	DUAL;

SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

--MOD (나머지)
SELECT MOD(15,6), MOD(10,2), MOD(11,2)
FROM DUAL;


--날짜함수
--오늘 날짜/시간 : SYSDATE
--몇개월 이후 날짜 구하기 : ADD_MONTHS()
--두 날짜간의 개월 수 차이 구하기 : MONTHS_BETWEEN()
--돌아오는 요일, 달의 마지막 날짜 구하기 : NEXT_DAY() / LAST DAY()


SELECT
	SYSDATE AS NOW,
	--일반적으로 가장 많이 쓰는 건 이거 
	SYSDATE-1 AS YESTERDAY, --연산 가능
	SYSDATE + 1 AS TOMORROW, -- =
	CURRENT_DATE AS CURRENT_DATE,
	CURRENT_TIMESTAMP AS CURRENT_TIMESTAMP
FROM
	DUAL;

--오늘 기준으로 3개월 뒤의 날짜 구해보기 
SELECT  SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM DUAL;


--입사한지 40년이 넘은 사원 
SELECT *
FROM EMP E WHERE ADD_MONTHS(E.HIREDATE, 480) < SYSDATE;

--오늘 날짜와 입사일자의 차이 구하기
SELECT
	E.EMPNO,
	E.ENAME,
	E.HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(E.HIREDATE, SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE, E.HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(E.HIREDATE, SYSDATE)) AS MONTH3
FROM
	EMP E;


SELECT
	SYSDATE,
	NEXT_DAY(SYSDATE, '월요일'),
	LAST_DAY(SYSDATE)
	--NEXT_DAY: 다음 월요일날짜
	--이달 마지막 날짜 
FROM
	DUAL;

--자료형을 변환하는 형변환 함수
--TO_CHAR() : 숫자 또는 날짜 데이터를 문자열 데이터로 반환
--TO_NUMBER() : 문자열 데이터를 숫자 데이터로 반환
--TO_DATE() : 문자열 데이터를 날짜 데이터로 반환


--NUMBER + '문자숫자' -> 덧셈이 되었음 : 자동형변환 되었다! 
SELECT E.EMPNO, E.ENAME, E.EMPNO + '500'
FROM EMP E
WHERE E.ENAME ='SMITH'


SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY/MM/DD' ) --자바의 SIMPLEDATEFORMAT처럼 날짜 포맷 지정 가능하다
FROM DUAL; 

--날짜와 시간 여러가지 포맷
SELECT SYSDATE, TO_CHAR(SYSDATE,'MM' ),
TO_CHAR(SYSDATE,'MON' ), 
TO_CHAR(SYSDATE,'MONTH' ), 
TO_CHAR(SYSDATE,'DD' ),
TO_CHAR(SYSDATE,'DY' ),
TO_CHAR(SYSDATE,'DAY' ),
TO_CHAR(SYSDATE,'MONTH DAY' ), 
TO_CHAR(SYSDATE,'YYYY MONTH DAY' ),
TO_CHAR(SYSDATE,'YEAR MM DD' ),
TO_CHAR(SYSDATE,'HH24:MI:SS' ),
TO_CHAR(SYSDATE,'HH12:MI:SS AM' ), --AM이나 PM이나 현재 기준으로 나온다
TO_CHAR(SYSDATE,'HH:MI:SS PM' ) 
FROM DUAL; 



















