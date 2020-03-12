-- 기존 테이블 삭제
DROP TABLE COUNSELING;
DROP TABLE SERVICE;
DROP TABLE REPLY;
DROP TABLE POST;
DROP TABLE ANALYSIS_RESULT;
--DROP TABLE ANALYSIS_DETAIL;
DROP TABLE MEMBER;

-- 기존 시퀀스 삭제
DROP SEQUENCE post_seq;
DROP SEQUENCE reply_seq;
DROP SEQUENCE serv_seq;
DROP SEQUENCE anal_result_seq;
--DROP SEQUENCE anal_detail_seq;
DROP SEQUENCE couns_seq;
insert into MEMBER values('test','test','test','test','user');
-- 테이블 생성
select * from MEMBER
CREATE TABLE MEMBER(
                MEMBER_ID VARCHAR2(20) PRIMARY KEY,
                MEMBER_PW VARCHAR2(20),
                MEMBER_NM VARCHAR2(20),
                MEMBER_EMAIL VARCHAR2(20),
                MEMBER_GRADE VARCHAR2(20));
                
--CREATE TABLE ANALYSIS_DETAIL(
--                ANALYSIS_DETAIL_CD NUMBER(20),
--                MORPHEME_CD NUMBER(20),
--                MORPHEME_VAL VARCHAR2(100),
--                SCORE_PUBLIC NUMBER(4),
--                SCORE_SPEC NUMBER(4),
--                SCORE_INSULT NUMBER(4),
--                CONSTRAINT anal_detail_pk PRIMARY KEY("ANALYSIS_DETAIL_CD","MORPHEME_CD"));

CREATE TABLE ANALYSIS_RESULT(
                ANALYSIS_RESULT_CD NUMBER(20) PRIMARY KEY,
                ORIGINAL_DATA VARCHAR2(2000),
                RESULT VARCHAR2(20));
                
CREATE TABLE POST(
                POST_CD NUMBER(20) PRIMARY KEY,
                POST_CONTENT VARCHAR2(2000),
                POST_DT DATE,
                MEMBER_ID VARCHAR2(20),
                ANALYSIS_RESULT_CD NUMBER(20),
                CONSTRAINT post_member_id_fk FOREIGN KEY ("MEMBER_ID")
                REFERENCES MEMBER ("MEMBER_ID"),
                CONSTRAINT post_anal_result_fk FOREIGN KEY ("ANALYSIS_RESULT_CD")
                REFERENCES ANALYSIS_RESULT ("ANALYSIS_RESULT_CD"));
            
CREATE TABLE REPLY(
                REPLY_CD NUMBER(20) PRIMARY KEY,
                POST_CD NUMBER(20),
                MEMBER_ID VARCHAR2(20),
                REPLY_CONTENT VARCHAR2(1000),
                CONSTRAINT reply_post_cd_fk FOREIGN KEY ("POST_CD")
                REFERENCES POST ("POST_CD"),
                CONSTRAINT reply_member_id_fk FOREIGN KEY ("MEMBER_ID")
                REFERENCES MEMBER ("MEMBER_ID"));

CREATE TABLE SERVICE(
                SERVICE_CD NUMBER(20) PRIMARY KEY,
                MEMBER_ID VARCHAR2(20),
                SERVICE_DT DATE,
                ANALYSIS_RESULT_CD NUMBER(20),
                CONSTRAINT service_member_id_fk FOREIGN KEY ("MEMBER_ID")
                REFERENCES MEMBER ("MEMBER_ID"),
                CONSTRAINT service_anal_result_fk FOREIGN KEY ("ANALYSIS_RESULT_CD")
                REFERENCES ANALYSIS_RESULT ("ANALYSIS_RESULT_CD"));
                
CREATE TABLE COUNSELING(
                COUNSELING_CD NUMBER(20) PRIMARY KEY,
                MEMBER_ID VARCHAR2(20),
                COUNSELOR_ID VARCHAR2(20),
                COUNSELING_CONTENT VARCHAR2(2000),
                COUNSELING_DATE DATE,
                CONSTRAINT coun_member_id_fk FOREIGN KEY ("MEMBER_ID")
                REFERENCES MEMBER ("MEMBER_ID"),
                CONSTRAINT coun_counselor_id_fk FOREIGN KEY ("COUNSELOR_ID")
                REFERENCES MEMBER ("MEMBER_ID"));
                
-- 시퀀스 생성
CREATE SEQUENCE post_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 100000 ;

CREATE SEQUENCE reply_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 100000 ;

CREATE SEQUENCE serv_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 100000 ;

CREATE SEQUENCE anal_result_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 100000 ;

--CREATE SEQUENCE anal_detail_seq
--START WITH 1
--INCREMENT BY 1
--MAXVALUE 100000 ;


CREATE SEQUENCE couns_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 100000 ;

-- 더미 데이터 입력
INSERT INTO MEMBER
VALUES('test','1111','김예시','test@test.com','user');
INSERT INTO MEMBER
VALUES('manager','1111','김관리','test@test.com','manage');

select * from MEMBER

--INSERT INTO ANALYSIS_DETAIL
--VALUES(anal_detail_seq.nextval,1,'너',0,1,0);
--INSERT INTO ANALYSIS_DETAIL
--VALUES(anal_detail_seq.nextval,1,'는',0,0,0);
--INSERT INTO ANALYSIS_DETAIL
--VALUES(anal_detail_seq.nextval,1,'바보',0,0,3);
--INSERT INTO ANALYSIS_DETAIL
--VALUES(anal_detail_seq.nextval,1,'야',0,0,0);

INSERT INTO ANALYSIS_RESULT
VALUES(anal_result_seq.nextval,'너는 바보야',0);

INSERT INTO POST
VALUES(post_seq.nextval, '테스트용 더미 게시글 입니다. 게시글의 내용이 들어갑니다.',sysdate,'test','1');

INSERT INTO REPLY
VALUES(reply_seq.nextval,1,'test','테스트용 더미 댓글 입니다. 댓글의 내용이 들어갑니다.');

INSERT INTO SERVICE
VALUES(serv_seq.nextval,'test',sysdate,1);

INSERT INTO COUNSELING
VALUES(couns_seq.nextval,'test','manager','manager:테스트용 더미 채팅내역 입니다. test:채팅내역 내용이 들어갑니다.',sysdate);