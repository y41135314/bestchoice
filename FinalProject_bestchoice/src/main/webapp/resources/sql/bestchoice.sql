show user;

create table tbl_here_member
( member_idx            number   not null                --  회원번호
, email                 varchar2(200) not null     --  회원아이디(이메일로함)
, pwd                   varchar2(200) not null     --  비밀번호(암호화)
, name 	                varchar2(30) not null	               --  이름 
, nickname                  varchar2(30)                   --  닉네임(별명)
, hp1                            char(3)                   --  핸드폰(암호화/복호화)
, hp2                            varchar2(200)   
, hp3                            varchar2(200) 
, gender                       char(1)                            --   성별 ( 1남,2여 )
, birthday                      varchar2(8)                    --   생일 ex)940715
, mstatus                         number(1) default 1       --   회원상태 (1가입, 0탈퇴 )
, registerday                 date default sysdate      --   가입일자
, lastLoginDate             date default sysdate      --   마지막로그인 날짜
, lastpwdChangeDate  date default sysdate      --    비밀번호 변경날짜
, constraint      PK_bestchoice_member_idx primary key(member_idx)
, constraint      UQ_bestchoice_email unique(email)
, constraint      CK_bestchoice_status check( status in(0,1) ) 
, constraint      CK_bestchoice_member_gender check( gender in('1','2') ) 
);

ALTER TABLE tbl_here_member DROP COLUMN clientIP;

commit;

select *
from tbl_here_member;
insert into tbl_here_member(member_idx, email, pwd, name, nickname, hp1, hp2, hp3, gender, birthday, registerday, lastLoginDate, lastpwdChangeDate)
values(seq_here_member.nextval, 'luck7118@naver.com','qwer1234$','송민하','minha','010','2645','7116','2','940715',sysdate,sysdate,sysdate);

commit;
select * 
from tbl_here_member;

delete from tbl_here_member
where email = 'luck7118@naver.com';


create sequence seq_here_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
