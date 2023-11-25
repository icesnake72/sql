CREATE DEFINER=`root`@`localhost` PROCEDURE `actors_film_procedure`(in id_actor smallint, out result int)
BEGIN
	-- 배우 아이디가 1인 배우의 이름과 출연작들 가져오기
	select a.actor_id, a.first_name, a.last_name, f.film_id, f.title 
	from film_actor as fa
	inner join film as f on f.film_id = fa.film_id
	inner join actor as a on a.actor_id = fa.actor_id
	where fa.actor_id=id_actor;
    
    select count(*)
    from film_actor as fa
	inner join film as f on f.film_id = fa.film_id
	inner join actor as a on a.actor_id = fa.actor_id
	where fa.actor_id=id_actor
    into result;
END