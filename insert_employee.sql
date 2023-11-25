use employee;

select * from buseo;
select * from jikgup;
select * from employee;

alter table buseo
add column manager bigint unsigned not null,
add constraint fk_manager foreign key (manager) references employee(id);

alter table buseo
drop constraint fk_manager;

desc buseo;



INSERT INTO employee (emp_name, buseo, jikgup, email) VALUES ('유재석', 2, 1, 'master@testcomp.com');

-- 2번
INSERT INTO employee (emp_name, buseo, jikgup, email) VALUES ('이광수', 2, 2, 'kwangsoo@testcomp.com');

-- 3번
INSERT INTO employee (emp_name, buseo, jikgup, email) VALUES ('박명수', 3, 3, 'myungsoo@testcomp.com');

-- 4번
INSERT INTO employee (emp_name, buseo, jikgup, email) VALUES ('하하', 4, 4, 'haha@testcomp.com');

-- 5번
INSERT INTO employee (emp_name, buseo, jikgup, email) VALUES ('정형돈', 5, 5, 'hyungdon@testcomp.com');

-- 6번
INSERT INTO employee (emp_name, buseo, jikgup, email) VALUES ('양세형', 3, 2, 'sehyung@testcomp.com');

-- 7번
INSERT INTO employee (emp_name, buseo, jikgup, email) VALUES ('노홍철', 2, 3, 'hongchul@testcomp.com');

-- 8번
INSERT INTO employee (emp_name, buseo, jikgup, email) VALUES ('지석진', 3, 4, 'seokjin@testcomp.com');

-- 9번
INSERT INTO employee (emp_name, buseo, jikgup, email) VALUES ('양배추', 4, 5, 'baechu@testcomp.com');

-- 10번
INSERT INTO employee (emp_name, buseo, jikgup, email) VALUES ('김태호', 5, 1, 'taeho@testcomp.com');

-- 11번부터 20번까지의 INSERT 문을 반복해서 작성하십시오.



-- 1번
INSERT INTO buseo (buseo_name, manager) VALUES ('인사부', 1);

-- 2번
INSERT INTO buseo (buseo_name, manager) VALUES ('마케팅부', 2);

-- 3번
INSERT INTO buseo (buseo_name, manager) VALUES ('개발부', 3);

-- 4번
INSERT INTO buseo (buseo_name, manager) VALUES ('영업부', 4);

-- 5번
INSERT INTO buseo (buseo_name, manager) VALUES ('재무부', 5);


insert into jikgup (jikgup_name) values ("사장");
insert into jikgup (jikgup_name) values ("부장");
insert into jikgup (jikgup_name) values ("차장");
insert into jikgup (jikgup_name) values ("과장");
insert into jikgup (jikgup_name) values ("대리");
insert into jikgup (jikgup_name) values ("사원");

