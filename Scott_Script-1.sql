--RDBMS
-->기본단위: 테이블		 

--EMP (사원정보 테이블)
--empno(사번), ename(사원명), job(직책), mgr(직속상관사번), hiredate(입사일), sla(급여), comm(추가수당), deptno(부서번호)
--NUMBER(4,0): 전체 자릴수 4자리(소수점 자릿수 0)
--VARCHAR2(10):	문자열 10Byte(VAR: 가변- 7byte 문자열 저장했다면 7byte 공간만 사용)
--			  > 영어 10문자, 한글 2byte, utf-8 3byte 할당
--DATE: 날짜
--DEPT(부서테이블)
--deptno(부서번호), dname(부서명), loc(부서위치) 

--SALGRADE(급여테이블)
--grade(급여 등급), losal(최저급여), highsal(최대급여)

--개발자: CR(Read)UD
--SQL(Structured Query Langauge: 구조질의언어): RDBMS 데이터를 다루는 언어

--1. 조회(SELECT) - Read
--사원정보조회
-- * : 모든 열을 의미함
SELECT * FROM EMP e; --사원정보 전체 조회

--특정 열 조회 방법
SELECT e.EMPNO, e.ENAME, e.JOB FROM EMP e;

--사원번호, 부서번호만 조회 
SELECT e.EMPNO, e.DEPTNO FROM EMP e;









