CREATE TABLE board(
	id NUMBER(8) PRIMARY KEY,
	name varchar(20) NOT NULL,
	regdate DATE DEFAULT sysdate --이런식으로 가능하다는 거! 그냥 날짜 sysdate으로 고정
);