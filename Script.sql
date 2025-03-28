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
ALTER USER hr IDENTIFIED BY hr; 



--데이터사전 DBA_USERS 를 사용하여 사용자 정보 조회
SELECT * FROM dba_users WHERE username = 'SCOTT';

--scott한테 view 생성 권한 부여하기
GRANT CREATE VIEW TO scott;


--------------------------------------------------------------------------------------------------------------------------

-- 사용자 관리
-- 오라클은 테이블, 인덱스, 뷰 등등 사용자별로 여럭 객체를 생성하므로 업무별 사용자를 생성한 후에 
-- 각 사용자 업무에 맞는 데이터 구조를 만들어 관리하는 방식 사용

-- 데이터베이스 스키마 
-- 스키마 : 데이터베이스에서 데이터 간 관계, 데이터 구조, 제약 조건 등 데이터를 저장하고 관리하고자 정의한 데이터베이스 구조 범위

-- 오라클 데이터베이스에서는 스키마 = 사용자 
-- 사용자 생성 구문 
--CREATE USER 사용자 이름 IDENTIFIED BY 비밀번호;

--CREATE USER 사용자 이름 IDENTIFIED BY 비밀번호
--DEFAULT TABLESPACE 테이블스페이스명
--TEMPORARY TABLESPACE 테이블스페이스그룹명
--QUOTA 테이블스페이스 크기 ON 테이블스페이스명;


--권한을 가지고 있지 않음, 로그온 거절됨 => 권한 부여 해야함

--1. 사용자 생성
CREATE USER c##test1 IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP 
QUOTA 10M ON USERS;

--2. 권한 부여(GRANT)

--BOARD 테이블에 SELECT, INSERT, DELETE 권한 부여하기
--GRANT SELECT,INSERT,DELETE ON BOARD(테이블명) TO c##test1;
--롤 : 여러 개의 권한이 묶여서 정의되어 있음 
GRANT CONNECT, RESOURCE TO c##test1;



ALTER SESSION SET "_oracle_script"=TRUE;-- 얘 실행하고 아래 실행하면 됨 
CREATE USER test2 IDENTIFIED BY 12345; -- 공통 사용자 또는 롤 이름이 부적합합니다.

--사용자 정보 조회
SELECT * FROM all_users
WHERE username = 'c##test1';

--비밀번호 변경
ALTER USER c##test1 IDENTIFIED BY 54321;















































































































































