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

