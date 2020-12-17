/*ȸ�� ���̺�*/

create table jobs_user(
	idx number(4) primary key,--ȸ����ȣ
	userid varchar2(20) unique,--id
	pwd varchar2(256) not null,--password
	name varchar2(30) not null,--�̸� (ȸ��, ���)
	imagename varchar2(200) default 'noimage.png',--ȸ������ or ����ΰ�
	info varchar2(4000), --��� ����
	state number(1) default 0, --ȸ������ (�Ϲ�ȸ��:0, ���ȸ��:1, ������:2, ����ȸ��:3, Ż��ȸ��:4)
  	indate date default sysdate, --������
  	outdate date --Ż����
);

create sequence jobs_user_seq nocache;

--------------------------------------------

/* ä������ ���̺� */

create table jobs_recruitboard(
	num number(8) primary key,--�۹�ȣ
	type varchar2(20),--��ä or ���
	career varchar2(20),--��� or ����
  	subject varchar2(2000),--����
	content varchar2(4000),--����
	wdate date default sysdate,--�ۼ���
	readnum number(8) default 0, --��ȸ��
	filename varchar2(200),--÷�����ϸ�
	filesize number(8), --÷������ ũ��
  	idx_fk number(4),
  	constraint jobs_recruitboard_idx_fk foreign key (idx_fk) references jobs_user(idx)
);


create sequence jobs_recruitboard_seq nocache;

--------------------------------------------

/* �������� ���̺� */

create table jobs_hunterboard(
	num number(8) primary key,--�۹�ȣ
	type varchar2(20),--���� or ���
	career varchar2(20),--��� or ����
  	subject varchar2(2000),--����
	content varchar2(4000),--����
	wdate date default sysdate,--�ۼ���
	readnum number(8) default 0, --��ȸ��
	filename varchar2(200),--÷�����ϸ�
	filesize number(8), --÷������ ũ��
  	idx_fk number(4),
  	constraint jobs_hunterboard_idx_fk foreign key (idx_fk) references jobs_user(idx)
);

create sequence jobs_hunterboard_seq nocache;

--------------------------------------------

/* �������� ���̺�*/

create table jobs_newsletter(
  	idx number(8) primary key,--��Ϲ�ȣ
  	email varchar2(4000) not null --�̸��� �ּ�
);

create sequence jobs_newsletter_seq nocache;

--------------------------------------------

--state�� 4�̰� Ż������ 1���� ������ ȸ�������� �����ϰ� ���ִ� ���ν���

SET SERVEROUTPUT ON--developer�� �����

CREATE OR REPLACE PROCEDURE DEL_USER
IS
BEGIN
  DELETE FROM jobs_user WHERE state=4 and outdate < ADD_MONTHS(SYSDATE, -1);
  DBMS_OUTPUT.PUT_LINE('ȸ�� ������ �����Ǿ����ϴ�');
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('������ ������ �������� �ʽ��ϴ�.');
END;
/

EXECUTE DEL_USER;--�׽�Ʈ �Ҷ� ���

--------------------------------------------

--ȸ������ �������ִ� ���ν����� ���� 00�ø��� �ڵ����� ��������ִ� ���ν��� (DBMS �����ٷ�)

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

SYSDATE + 1/60/24 : �� 1�и��� �ѹ� �� job ����

SYSDATE+7 : 7�Ͽ� �ѹ� �� job ����

SYSDATE+1/24 : 1�ð��� �ѹ� �� job ����

SYSDATE+30/ : 30�ʿ� �ѹ� �� job ����(24: �ð� ��, 1440(24x60):�� ��, 86400(24x60x60):�� �� )

TRUNC(SYSDATE, 'MI')+8/24 : ���� job ����ð��� 12:29�� �� ��� �Ž� 12:29�п� job ����

TRUNC(SYSDATE+1) : ���� �� 12�ÿ� job ����

TRUNC(SYSDATE+1)+3/24 : ���� ���� 3�� job ����

NEXT_DAY(TRUNC(SYSDATE),'MONDAY')+15/25 : ���� ������ ���� 3�� ������ job ����

TRUNC(LAST_DAY(SYSDATE))+1 : �ſ� 1�� �� 12�ÿ� job ����

TRUNC(LAST_DAY(SYSDATE))+1+8/24+30/1440 : �ſ� 1�� ���� 8�� 30��

*/