-- 오라클 관리자 
-- system, sys(최고권한)

-- <sys로 접근하는 방법>
-- 사용장 이름: sys as sysdba
-- 비밀번호: 그냥 엔터

-- 오라클 12c버전부터 일반적으로 사용자 계정 생성 시 접두어(c##)를 요구함
-- c##hr
-- c## 사용하지 않을때 아래 ㄱㄱ 


--sql구문의 실행 순서 (그냥 생각해보면 당연한거)
(5) SELECT 
(1) FROM 
(2) WHERE 
(3) GROUP BY 
(4) HAVING 
(6) ORDER BY 


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
--데이터의 공간을 지정 문자로 채우기 : LPAD(), RPAD()
	-->LPAD(데이터, 데이터 자릿수, 채울 문자)
	-->RPAD(데이터, 데이터 자릿수, 채울 문자)

--Oracle => 10 자리로 표현 
SELECT
	'Oracle',
	LPAD('Oracle', 10, '#'),
	RPAD('Oracle', 10, '*'),
	LPAD('Oracle', 10),
	RPAD('Oracle', 10)
FROM
	dual;

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

--TO_CHAR로 돈 보기 편하게 쉼표 넣어주기도 ㄱㄴ하다
--9: 숫자 한자리를 의미
--0: 얘도 숫자 한 자리를 의미하지만 빈 자리가 있으면 0으로 채운다. 
SELECT
	e.sal,
	TO_CHAR(e.sal, '$999,999'),
	
	e.sal,
	TO_CHAR(e.sal, '$000,000')
FROM
	emp e; 

	
	--TO_NUMBER
--문자열 데이터와 숫자 데이터 연산
--이렇게 해도 계산 해준다  
	SELECT
	'1300' - '1500',
	1300 + '1500'
FROM
	DUAL;
--쉼표 넣으면 문자열 섞여서 에러 나고 계산 ㅂㄱㄴ
	SELECT
	'1,300' -'1500'
FROM
	DUAL;

--TO_NUMBER로 해결 ㄱㄴ하다!
--TO_NUMBER('문자열 데이터', '인식할 숫자 형태')
SELECT
	TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
	DUAL;


	--TO_DATE : 문자열 데이터를 날짜 형식으로 바꿈
--형식 지정할때 Y,M,D 사이에 어지간한 특수기호는 다 되는듯(걍 띄어쓰기도 됨)
SELECT
	TO_DATE('2025-03-20', 'YYYY$MM DD')
FROM
	DUAL;
	
	--NULL
--산술연산이나 비교연산자(IS NULL/IS NOT NULL)가 제대로 수행되지 않음
--1) NVL(널 여부 검사할  데이터, 널일 때 반환 할 데이터)
--2) NVL2(널 여부 검사할  데이터, 널이 아닐 때 반환 할 데이터, 널일 때 반환 할 데이터)
SELECT
	E.EMPNO,
	E.ENAME,
	E.SAL,
	E.COMM,
	E.SAL + E.COMM,
	NVL(E.COMM, 0),
	E.SAL + NVL(E.COMM, 0)
FROM
	EMP E;
--NVL2()
SELECT
	E.EMPNO,
	E.ENAME,
	E.SAL,
	E.COMM,
	E.SAL + E.COMM,
	NVL2(E.COMM, 'o' ,'x'),
	NVL2(E.COMM,E.SAL*12+E.COMM,E.SAL*12) AS 연봉
FROM
	EMP E;

--자바의 if, switch 구문과 유사하다 
--DECODE 
--DECODE(검사대상이 될 데이터, 
--	조건1, 조건1 만족 시 반환할 결과, 
--	조건2, 조건2 만족 시 반환할 결과,
--	조건3, 조건3 만족 시 반환할 결과,
--	...
--	조건1 ~ 조건n 일치하지 않을 때 반환할 결과
--	)

--CASE
--CASE 검사대상이 될 데이터
--	WHEN 조건1 THEN 조건1 만족 시 반환할 결과
--	WHEN 조건2 THEN 조건2 만족 시 반환할 결과
--	WHEN 조건3 THEN 조건3 만족 시 반환할 결과
--	...
--	ELSE 일치하지 않을 때 반환할 결과
--	END (END 꼭 있어야 함)
	
--직책이 MANAGER인 사원은 급여의 10% 인상
--직책이 SALESMAN인 사원은 급여의 5% 인상
--직책이 ANALYST인 사원은 동결
--나머지는 3%인상

--DECODE 예제
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	DECODE(e.job, 'MANAGER', e.sal * 1.1,
	e.job 'SALESMAN', e.sal * 1.05,
	e.job 'ANALYST', e.sal,
	e.sal * 1.03) AS UPSAL
FROM
	emp e;
--CASE 예제
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		e.job 
	WHEN 'MANAGER' THEN e.sal * 1.1
		WHEN e.job 'SALESMAN' THEN e.sal * 1.05
		WHEN e.job 'ANALYST' THEN e.sal
		ELSE e.sal * 1.03)
	END AS upsal
FROM
	emp e; 

--COMMISION이 NULL 이면 '해당사항 없음'
--COMMISION이 0이면 '수당없음'
--COMMISION이 > 0 이면 '수당: ~~'
SELECT
	E.EMPNO,
	E.ENAME,
	E.JOB,
	E.SAL,
CASE
		WHEN E.COMM IS NULL THEN '해당사항없음'
		WHEN E.COMM = 0 THEN '수당없음'
		WHEN E.COMM > 0 THEN '수당 : ' || E.COMM
	END AS COMM_TEXT
FROM
	EMP E;

--[실습]
--1.empno 7369 => 73**, ename SMITH => S****
--empno, 마스킹처리empno, ename, 마스킹처리ename

--RPAD() 이용
SELECT
	e.empno,
	--SUBSTR(e.EMPNO, 1, 2) || LPAD('*', LENGTH(e.EMPNO)-2, '*'),
	RPAD(SUBSTR(e.EMPNO,1,2), LENGTH(e.EMPNO), '*'),
	e.ENAME,
	--SUBSTR(e.ENAME, 1, 1) || LPAD('*', LENGTH(e.ENAME)-1, '*')
	RPAD(SUBSTR(e.ENAME,1,1), LENGTH(e.ENAME), '*')
FROM
	emp e;

--2.emp 테이블에서 사원의 월 평균 근무일수는 21일이다.
--하루 근무시간을 8시간으로 보았을 때 사원의 하루 급여(day_pay)와 시급(time_pay)를 계산하여 출력하기
--단, 하루급여는 소수 셋째자리에서 버리고, 시급은 둘째자리에서 반올림
SELECT
	e.ENAME,
	TRUNC(e.sal / 21, 2) AS day_pay,
	ROUND(e.sal / 21 / 8, 1) AS time_pay,
	e.SAL AS 월급
FROM
	emp e;

--3.입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
--사원이 정직원이 되는 날짜(R_JOB)을 YYYY-MM-DD 형식으로 출력한다.
--단, 추가수당이 없는 사원의 추가수당은 N/A로 출력
--출력형태) EMPNO, ENAME, HIREDATE, R_JOB, COMM
SELECT
	e.empno,
	e.ename,
	e.hiredate,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(e.HIREDATE , 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	NVL(TO_CHAR(e.COMM) ,'N/A') AS COMM --e.comm이 넘버 타입이라서 그냥 실행하면 오류 뜨고 TO_CHAR로 e.comm을 문자로 바꾸는 것
FROM
	emp e;

	
--4.직속상관의 사원번호가 없을 때 : 0000
--직속상관의 사원번호 앞 두 자리가 75일때: 5555
--직속상관의 사원번호 앞 두 자리가 76일때: 6666
--직속상관의 사원번호 앞 두 자리가 77일때: 7777
--출력형태: EMPNO, ENAME, MGR, CHG_MGR

SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	CASE 
		WHEN e.MGR IS NULL THEN '0000'
		WHEN SUBSTR(TO_CHAR(e.mgr), 1, 2) = '75' THEN '5555' -- 마찬가지로 e.mgr이 넘버타입이라서 to_char 해주어야 함
		WHEN SUBSTR(TO_CHAR(e.mgr), 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(TO_CHAR(e.mgr), 1, 2) = '77' THEN '7777'
		WHEN SUBSTR(TO_CHAR(e.mgr), 1, 2) = '78' THEN '8888'
		ELSE TO_CHAR(e.MGR)
	END AS chg_mgr --AS는 쓸거면 END 옆에 써야함 
FROM
	emp e;

--like으로도 ㄱㄴ
SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	CASE 
		WHEN e.MGR IS NULL THEN '0000'
		WHEN e.MGR like '75%' THEN '5555' 
		WHEN e.MGR like '76%' THEN '6666'
		WHEN e.MGR like '77%' THEN '7777'
		WHEN e.MGR like '78%' THEN '8888'
		ELSE TO_CHAR(e.MGR)
	END AS chg_mgr --AS는 쓸거면 END 옆에 써야함 
FROM
	emp e;

--decode로 하기
SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	DECODE(SUBSTR(to_char(nvl(e.mgr, 0)), 1, 2),
	'0', '0000',
'75', '5555',
'76', '6666',
'77', '7777',
'78', '8888',
substr(to_char(e.mgr), 1)) 
AS chg_mgr
FROM
	EMP e;

SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	DECODE(SUBSTR(to_char(e.mgr), 1, 2),
	NULL , '0000',
'75', '5555',
'76', '6666',
'77', '7777',
'78', '8888',
substr(to_char(e.mgr), 1)) 
AS chg_mgr
FROM
	EMP e;



--하나의  열에 출력결과를 담는 다중행 함수 (엑셀의 함수 같은 것)
--null행은 제외하고 연산 
--1. sum()
--2. count()
--3. max()
--4. min()
--5. avg()

--sum()
--전체사원 급여 합
SELECT sum(e.sal) FROM emp e;

--중복된 급여는 제외하고 합 
SELECT
	sum(e.SAL),
	sum(DISTINCT e.SAL),
	sum(ALL e.SAL)
FROM
	emp e;

--단일 그룹의 그룹 함수가 아닙니다 (해결 : group by 절에 사용한 컬럼만 가능)
--SELECT e.ename, sum(e.sal) FROM emp e;



--count()
--사원 수 구하기 (컬럼은 전부 수 똑같으니까 아무거나 해도 됨)
SELECT
	count(e.ENAME),
	count(ALL e.COMM) 
	--4명만 나옴 ->null은 제외해서
FROM
	emp e

--급여의 최댓값과 최솟값
SELECT max(e.sal), min(e.SAL)
FROM emp e;

--10번 부서 사원 중에서 급여 최댓값
SELECT max(e.sal) , min(e.SAL)
FROM emp e
WHERE e.DEPTNO = 10;	

--20번 부서에서 입사일이 가장 늦은 사람
SELECT max(e.HIREDATE)--날짜도 숫자의 개념이 있어서 이렇게 가능하다! 
FROM emp e
WHERE e.DEPTNO = 20;

--10번 부서에서 입사일이 가장 빠른 사람
SELECT min(e.hiredate)
FROM emp e
WHERE e.DEPTNO = 10;

--부서번호가 30번인 사원들의 평균 급여
SELECT avg(e.SAL)
FROM emp e
WHERE e.DEPTNO = 30;

--결과값을 원하는 열로 묶어 출력 : GROUP BY
--부서별 평균 급여 조회
SELECT e.DEPTNO AS 부서번호 ,AVG(e.SAL)
FROM emp e
GROUP BY e.DEPTNO;

--부서별, 직책별 평균 급여
SELECT e.DEPTNO, e.JOB, AVG(e.SAL)
FROM emp e
GROUP BY e.DEPTNO, e.JOB
ORDER BY e.DEPTNO;


--결과값을 원하는 열로 묶어 출력할 때 조건 추가 : GROUP BY + HAVING 

--부서별, 직책별 평균 급여 조회 + 평균급여 >= 2000
SELECT e.DEPTNO, e.JOB , AVG(e.SAL)
FROM emp e
GROUP BY e.DEPTNO, e.JOB HAVING AVG(e.SAL)>=2000

--같은 직무에 종사하는 사원이 3명 이상인 직책과 인원 수 출력
SELECT e.JOB, count(e.ENAME)
FROM emp e
GROUP BY e.job HAVING COUNT(e.ename) >=3;

--사원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력
--출력 예시 
--1987 20 2
--1987 30 1
--...
SELECT TO_CHAR(e.HIREDATE ,'YYYY'), e.DEPTNO, COUNT(e.EMPNO) AS 사원수
FROM emp e
GROUP BY TO_CHAR(e.HIREDATE,'YYYY') ,e.DEPTNO --연도로 그룹 잡기
ORDER BY TO_CHAR(e.HIREDATE,'YYYY') ,e.DEPTNO; --여기도 to_char 해야 정렬 ㄱㄴ SELECT 하고 정렬하니까 순서 상으로도 그게 맞음

--조인(join)
--여러 종류의 데이터를 다양한 테이블에 나누어 저장하기 때문에 여러 테이블의 데이터를 조합하여 출력할 때가 많다. 이때 사용하는 방식이 조인
--종류
	--내부조인(inner join) : 연결 안 되는 데이터는 제외시킴
		--1.등가조인: 각 테이블의 특정 열과 일치하는 데이터를 기준으로 추출
		--2.비등가조인: 등가조인 외의 방식
		--3.자체(slef) 조인: 같은 테이블끼리 조인
	--외부조인(outer join) : 연결 안 되는 데이터도 제외하지 않고 출력시킴
		--1.왼쪽외부조인(left outer join): 오른쪽 테이블의 데이터 존재 여부와 상관없이 왼쪽 테이블 기준으로 출력
		--2.오른쪽외부조인(right outer join): 왼쪽 테이블의 데이터 존재 여부와 상관없이 오른쪽 테이블 기준으로 출력


--사원별, 부서정보 조회 
SELECT e.EMPNO, e.DEPTNO, d.Dname, d.LOC --원하는 것만 뽑아서 볼 수 있다 
FROM emp e, DEPT d 
WHERE e.DEPTNO =d.DEPTNO; --e.deptno와 d.deptno가 일치하면 연결해라 (join) (등가조인)

--나올 수 있는 모든 조합 
SELECT e.EMPNO, e.DEPTNO, d.Dname, d.LOC 
FROM emp e, DEPT d ;

--사원별, 부서정보 조회 + 사원별 급여>=3000
SELECT e.EMPNO, e.DEPTNO, e.SAL, d.DNAME , d.LOC --원하는 것만 뽑아서 볼 수 있다 
FROM emp e, DEPT d 
WHERE e.DEPTNO =d.DEPTNO AND e.SAL >=3000;

--사원별, 부서정보 조회 + 사원별 급여<=2500 + 사원번호 9999이하
SELECT e.EMPNO, e.DEPTNO, e.SAL, d.DNAME , d.LOC --원하는 것만 뽑아서 볼 수 있다 
FROM emp e, DEPT d 
WHERE e.DEPTNO =d.DEPTNO AND e.SAL <=2500 AND e.EMPNO <=9999;

--비등가조인 
--사원별 정보 + salgrade grade
SELECT *
FROM EMP e ,SALGRADE s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;
--WHERE e.SAL >=s.LOSAL AND e.SAL <=s.HISAL; 
--위와 같이 between 쓰는게 굿 

--자체조인 
--사원정보 + 직속상관 정보 
SELECT
	e1.EMPNO ,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS manager_name
FROM
	emp e1,
	emp e2
WHERE
	e1.MGR = e2.EMPNO;

--left/right outer join
--left outer join
SELECT
	e1.EMPNO ,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS manager_name
FROM
	emp e1,
	emp e2
WHERE
	e1.MGR = e2.EMPNO(+);


--right outer join
SELECT
	e1.EMPNO ,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS manager_name
FROM
	emp e1,
	emp e2
WHERE
	e1.MGR(+) = e2.EMPNO;



--표준 문법을 사용한 조인
--join ~ on : inner 조인 
--join 테이블명 on 조인하는 조건 
SELECT e.EMPNO, e.DEPTNO, d.Dname, d.LOC 
FROM emp e JOIN DEPT d ON e.DEPTNO =d.DEPTNO;



SELECT
	*
FROM
	EMP e
JOIN SALGRADE s
ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;

--left outer join 테이블명 on 조인조건
SELECT
	e1.EMPNO ,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS manager_name
FROM
	emp e1
LEFT OUTER JOIN 
	emp e2
ON
	e1.MGR = e2.EMPNO;
--right outer join 테이블명 on 조인조건
SELECT
	e1.EMPNO ,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS manager_name
FROM
	emp e1
RIGHT OUTER JOIN 
	emp e2
ON
	e1.MGR = e2.EMPNO;

--inner, outer 생략 가능하다 
SELECT
	e1.EMPNO ,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS manager_name
FROM
	emp e1
INNER JOIN 
	emp e2
ON
	e1.MGR = e2.EMPNO;

--1)급여가 2000을 초과한 사원의 부서정보, 사원정보 출력 
--출력) 부서번호, 부서명, 사원번호, 사원명, 급여 
SELECT
	e.DEPTNO,
	d.DNAME,
	e.EMPNO,
	e.ENAME,
	e.SAL
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.sal>2000
ORDER BY
	e.DEPTNO ,
	d.DNAME,
	e.empno; --정렬은 그냥 내거 정렬한거


--2)모든 부서정보와 사원정보를 부서번호, 사원번호 순서로 정렬하여 출력 
--출력) 부서번호, 부서명, 사원번호, 사원명, 직무, 급여
SELECT
	e.DEPTNO,
	d.DNAME,
	e.EMPNO,
	e.ENAME,
	e.JOB ,
	e.SAL
FROM
	emp e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
ORDER BY
	e.DEPTNO,
	e.EMPNO;

--3)모든 부서정보, 사원정보, 급여등급정보, 각 사원의 직속상관 정보를 
--부서번호, 사원번호 순서로 정렬하여 출력
--출력)부서번호, 부서명, 사원번호, 사원명, 매니저번호, 급여, losal, hisal, grade,매니저empno, 매니저 이름

--얘 자체조인 이용해야함
SELECT
	e1.DEPTNO,
	d.DNAME,
	e1.EMPNO ,
	e1.ENAME,
	e1.MGR,
	e1.SAL,
	s.LOSAL,
	s.HISAL,
	s.GRADE,
	e2.EMPNO AS MANAGER_ID,
	e2.ENAME AS MANAGER_NAME
FROM
	emp e1
LEFT OUTER JOIN emp e2 ON
	e1.MGR = e2.EMPNO
JOIN dept d ON
	e1.DEPTNO = d.DEPTNO
JOIN 
	SALGRADE s ON
	e1.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY
	e1.DEPTNO,
	e1.EMPNO;

--4)부서별 평균급여, 최대급여, 최소급여, 사원 수 출력
--출력)부서번호, 부서명, avg_sal, min_sal, cnt
SELECT e.DEPTNO, d.DNAME, AVG(e.SAL) AS avg_sal, MIN(e.SAL) AS min_sal, COUNT(e.EMPNO) AS cnt 
FROM EMP e RIGHT OUTER  JOIN DEPT d ON e.DEPTNO =d.DEPTNO 
GROUP BY e.DEPTNO, d.DNAME --여기서 d.dname도 GROUP BY 해주어야 함 (행 수 맞추기)
ORDER BY e.DEPTNO ;








