use sakila;

select * from actor
order by first_name;

select * from actor
where first_name like '%a%' -- 어떤 문자열이던지 상관없이 그 안에 'a'가 포함된 경우와 일치하는 모든 값을 검색합니다.
order by first_name;

select * from actor
where first_name like '_a%' -- 두번째 문자가 a인 모든 값을 검색한다.
order by first_name;

-- 'a%a' : 첫 글자가 a로 시작하고 a로 끝나는 모든 데이터 검색

-- a로 시작하며 글자수가 적어도 2자이상인 모든 값들을 검색한다.
select * from actor
where first_name like 'a_%' 
order by first_name;

-- a로 시작하며 글자수가 적어도 3자이상인 모든 값들을 검색한다.
select * from actor
where first_name like 'a__%' 
order by first_name;


show tables;

-- 특정 필드의 값이 null인 데이터만 검색
select * from address
where address2 is null;

-- 검색된 레코드를 10개(제한된 갯수)만 가져오기
select * from address
limit 10;


select * from rental;

select * from inventory;

select * from film;

select min(length) from film;
select max(length) from film;
select avg(length) from film;
select sum(length) from film;

select count(*) from film;

-- length 필드의 값이 가장 작은 레코드를 검색하기
select * from film
order by `length` asc
limit 1;


select * from film
where rating in ('pg', 'pg-13', 'g');

select * from film
where rating not in ('pg', 'pg-13', 'g');

select film_id from film where rating in ('R', 'NC-17');

-- 영화등급이 R, NC-17인 영화의 인벤토리 검색
select inventory_id from inventory
where film_id in (select film_id from film where rating in ('R', 'NC-17'));

-- 등급이 R, NC-17인 인벤토리(제품)를 렌탈한 고객의 아이디 검색
select customer_id from rental
where inventory_id in 
(select inventory_id from inventory
where film_id in (select film_id from film where rating in ('R', 'NC-17')));

-- 등급이 R, NC-17인 인벤토리(제품)를 렌탈한 고객의 아이디로부터 이름 검색
select first_name, last_name from customer
where customer_id in 
(select customer_id from rental
where inventory_id in 
(select inventory_id from inventory
where film_id in (select film_id from film where rating in ('R', 'NC-17'))));


select count(first_name) from customer
where customer_id in 
(select customer_id from rental
where inventory_id in 
(select inventory_id from inventory
where film_id in (select film_id from film where rating in ('R', 'NC-17'))));


select * from payment
where amount between 3 and 5;

select * from film
where title between 'BABY HALL' and 'BUTTERFLY CHOCOLAT';

select * from film
where title like 'b%';

-- 컬럼의 별칭 사용하기
select avg(amount) as `금액 평균` from payment;


-- table의 별칭을 이용하여 문장을 간결하게 만들기
select f.title 
from film as f, inventory as i
where i.film_id = f.film_id;


-- 2개의 테이블 이너 조인
select r.rental_id, r.inventory_id, c.first_name, c.last_name
from rental as r
inner join customer as c on r.customer_id=c.customer_id
where r.inventory_id=2346;


-- 2개의 테이블 inner 조인
SELECT
    f.film_id,
    f.title AS film_title,
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name
    
FROM film_actor as fa

inner JOIN film as f ON f.film_id = fa.film_id

inner JOIN actor as a ON fa.actor_id = a.actor_id

order by film_title;



-- 2개의 테이블 left 조인
SELECT
    f.film_id,
    f.title AS film_title,
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name
FROM
    film_actor as fa
LEFT JOIN film as f ON fa.film_id = f.film_id
LEFT JOIN actor as a ON fa.actor_id = a.actor_id;


-- 2개의 테이블 right 조인
SELECT
    film.film_id,
    film.title AS film_title,
    actor.actor_id,
    CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name
FROM
    film_actor
RIGHT JOIN
    film ON film_actor.film_id = film.film_id
LEFT JOIN
    actor ON film_actor.actor_id = actor.actor_id;


SELECT
    concat(customer.first_name, ' ', customer.last_name) as customer_name,
    film.title
FROM rental

inner JOIN inventory ON rental.inventory_id = inventory.inventory_id
inner JOIN film ON inventory.film_id = film.film_id
inner JOIN customer ON rental.customer_id = customer.customer_id

WHERE rental.inventory_id = 2346;



-- 배우 아이디가 1인 배우의 이름과 출연작들 가져오기
select a.actor_id, a.first_name, a.last_name, f.film_id, f.title 
from film_actor as fa
inner join film as f on f.film_id = fa.film_id
inner join actor as a on a.actor_id = fa.actor_id
where fa.actor_id=1;


select r.rental_id, 
concat(c.first_name, ' ', c.last_name) as customer_name
from rental as r
cross join customer as c
where c.customer_id=r.customer_id;


-- 등급 그룹으로 묶어서 해당 그룹의 통계정보를 구할때 사용한다.
SELECT
    rating,
    AVG(length) AS average_length,
    COUNT(film_id) AS movie_count
FROM film
GROUP BY rating;
    
    
    
-- 배우별로 출연작들의 갯수와 출연작들의 평균 러닝타임을 구한다
SELECT
    actor.actor_id,
    CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name,
    COUNT(film.film_id) AS movie_count,
    AVG(film.length) AS average_length
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name;
    
    
-- 고객별로 렌탈횟수와 총이용 금액을 구한다
SELECT
    customer.customer_id,
    CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
    COUNT(rental.rental_id) AS rental_count,
    SUM(payment.amount) AS total_amount
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name;
    

-- 각 카테고리별 영화의 갯수를 구한다
select count(fc.film_id) as film_count, c.name 
from film_category as fc
inner join category as c on c.category_id=fc.category_id
group by c.name;
-- order by film_count desc
-- limit 1;

-- having 절을 이용하여 그룹핑한 결과를 필터링하기
select count(fc.film_id) as film_count, c.name 
from film_category as fc
inner join category as c on c.category_id=fc.category_id
group by c.name
having film_count > 70;


-- rating의 종류 구하기
select distinct rating
from film;









