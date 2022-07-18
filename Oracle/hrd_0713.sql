create table book_member(
mem_idx number(5,0) not null primary key,
name varchar2(20) not null,
email varchar2(20) not null,
tel varchar2(20),
password varchar2(10),
unique(email, tel)
);

create table tbl_book(
bcode char(5) not null primary key,
title varchar2(30) not null,
writer varchar2(20),
publisher varchar2(20),
pdate date);

create table tbl_bookrent(
rent_no number(5,0) not null primary key,
mem_idx number(5,0) not null,
bcode char(5) not null,
rent_date date not null,
exp_date date not null,
return_date date,
delay_days number(3,0),
foreign key(mem_idx) references book_member(mem_idx),
foreign key(bcode) references tbl_book(bcode));

create sequence tbl_seq1 start with 10001;

create sequence tbl_seq2 start with 1;

insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '이하니', 'honey@naver.com', '010-9889-0567', '1122');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '이세종', 'jong@daum.net', '010-2354-6773', '2345');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '최행운', 'lucky@korea.com', '010-5467-8792', '9876');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '나길동', 'nadong@kkk.net', '010-3456-8765', '3456');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '강감찬', 'haha@korea.net', '010-3987-9087', '1234');

insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('A1101', '코스모스', '칼세이건', '사이언스북스', '2006-12-01');
insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('B1101', '해커스토익', '이해커', '해커스랩', '2018-07-10');
insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('C1101', '푸른사자 와니니', '이현', '창비', '2015-06-20');
insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('A1102', '페스트', '알베르트 까뮈', '민음사', '2011-03-01');

insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10001, 'B1101', '2021-09-01', '2021-09-15', '2021-09-14', null);
insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10002, 'C1101', '2021-09-12', '2021-09-26', '2021-09-29', null);
insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10003, 'B1101', '2021-09-03', '2021-09-17', '2021-09-17', null);
insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10004, 'C1101', '2022-06-30', '2022-07-14', null, null);
insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10001, 'A1101', '2022-07-04', '2022-07-18', null, null);
insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10003, 'A1102', '2021-07-06', '2022-07-20', '2022-07-13', null);




