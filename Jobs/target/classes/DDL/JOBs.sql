/*회원 테이블*/

create table jobs_user(
	idx number(4) primary key,--회원번호
	userid varchar2(20) unique,--id
	pwd varchar2(256) not null,--password
	name varchar2(30) not null,--이름 (회원, 기업)
	imagename varchar2(200) default 'noimage.png',--회원사진 or 기업로고
	info varchar2(4000), --기업 정보
	state number(1) default 0, --회원상태 (일반회원:0, 기업회원:1, 관리자:2, 정지회원:3, 탈퇴회원:4)
  	indate date default sysdate, --가입일
  	outdate date --탈퇴일
);

create sequence jobs_user_seq nocache;

--------------------------------------------

/* 채용정보 테이블 */

create table jobs_recruitboard(
	num number(8) primary key,--글번호
	type varchar2(20),--공채 or 상시
	career varchar2(20),--경력 or 신입
  	subject varchar2(2000),--제목
	content varchar2(4000),--내용
	wdate date default sysdate,--작성일
	readnum number(8) default 0, --조회수
	filename varchar2(200),--첨부파일명
	filesize number(8), --첨부파일 크기
  	idx_fk number(4),
  	constraint jobs_recruitboard_idx_fk foreign key (idx_fk) references jobs_user(idx)
);


create sequence jobs_recruitboard_seq nocache;

--------------------------------------------

/* 인재정보 테이블 */

create table jobs_hunterboard(
	num number(8) primary key,--글번호
	type varchar2(20),--정규 or 계약
	career varchar2(20),--경력 or 신입
  	subject varchar2(2000),--제목
	content varchar2(4000),--내용
	wdate date default sysdate,--작성일
	readnum number(8) default 0, --조회수
	filename varchar2(200),--첨부파일명
	filesize number(8), --첨부파일 크기
  	idx_fk number(4),
  	constraint jobs_hunterboard_idx_fk foreign key (idx_fk) references jobs_user(idx)
);

create sequence jobs_hunterboard_seq nocache;

--------------------------------------------

/* 뉴스레터 테이블*/

create table jobs_newsletter(
  	idx number(8) primary key,--등록번호
  	email varchar2(4000) not null --이메일 주소
);

create sequence jobs_newsletter_seq nocache;

--------------------------------------------

--state가 4이고 탈퇴한지 1달이 지나면 회원정보를 삭제하게 해주는 프로시저

SET SERVEROUTPUT ON--developer에 띄워줌

CREATE OR REPLACE PROCEDURE DEL_USER
IS
BEGIN
  DELETE FROM jobs_user WHERE state=4 and outdate < ADD_MONTHS(SYSDATE, -1);
  DBMS_OUTPUT.PUT_LINE('회원 정보가 삭제되었습니다');
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('삭제할 정보가 존재하지 않습니다.');
END;
/

EXECUTE DEL_USER;--테스트 할때 사용

--------------------------------------------

--회원정보 삭제해주는 프로시저를 매일 00시마다 자동으로 실행시켜주는 프로시저 (DBMS 스케줄러)

DECLARE
    jos_user_delete    NUMBER;
BEGIN
    DBMS_JOB.SUBMIT
    (
      JOB       => jos_user_delete
    , WHAT      => 'DEL_USER;'
    , NEXT_DATE => SYSDATE
    , INTERVAL  => 'TRUNC(SYSDATE+1)'
    );
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('jos_user_delete : ' || jos_user_delete);
END;
/

/*

SYSDATE + 1/60/24 : 매 1분마다 한번 씩 job 수행

SYSDATE+7 : 7일에 한번 씩 job 수행

SYSDATE+1/24 : 1시간에 한번 씩 job 수행

SYSDATE+30/ : 30초에 한번 씩 job 수행(24: 시간 당, 1440(24x60):분 당, 86400(24x60x60):초 당 )

TRUNC(SYSDATE, 'MI')+8/24 : 최초 job 수행시간이 12:29분 일 경우 매시 12:29분에 job 수행

TRUNC(SYSDATE+1) : 매일 밤 12시에 job 수행

TRUNC(SYSDATE+1)+3/24 : 매일 오전 3시 job 수행

NEXT_DAY(TRUNC(SYSDATE),'MONDAY')+15/25 : 매주 월요일 오후 3시 정각에 job 수행

TRUNC(LAST_DAY(SYSDATE))+1 : 매월 1일 밤 12시에 job 수행

TRUNC(LAST_DAY(SYSDATE))+1+8/24+30/1440 : 매월 1일 오전 8시 30분

*/