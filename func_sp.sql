-- 함수와 스토어드 프로시져

/*
MySQL에서 함수와 스토어드 프로시저(Stored Procedure)는 둘 다 데이터베이스에서 사용자가 정의한 작업을 수행하는 데 사용되는 객체입니다. 그러나 두 객체 간에는 몇 가지 중요한 차이점이 있습니다.

1. 반환 값:
함수 (Function): 함수는 값을 반환할 수 있습니다. 
따라서 함수를 호출한 쿼리나 다른 프로시저에서 함수의 결과 값을 사용할 수 있습니다.
ex)
CREATE FUNCTION getAveragePrice() RETURNS DECIMAL
BEGIN
  DECLARE avg_price DECIMAL;
  -- 계산 로직...
  RETURN avg_price;
END;

스토어드 프로시저 (Stored Procedure): 스토어드 프로시저는 값을 반환할 수 있지만, 
반드시 OUT 매개변수나 결과 집합을 통해 반환됩니다. 
즉, 일반적으로 SELECT문으로 직접 값을 반환하지는 않습니다.
ex)
CREATE PROCEDURE getAveragePrice(OUT avg_price DECIMAL)
BEGIN
  -- 계산 로직...
END;


2. 사용 시점:
함수 (Function): 함수는 SELECT 문이나 WHERE 절 등의 표현식에서 사용할 수 있습니다. 
함수는 값을 반환하므로 표현식 내에서 사용할 수 있습니다.
ex)
SELECT getAveragePrice() AS average_price;

스토어드 프로시저 (Stored Procedure): 스토어드 프로시저는 CALL 문을 사용하여 호출됩니다. 
스토어드 프로시저는 일련의 SQL 문들을 포함하며, 결과를 반환하거나 다른 프로시저를 호출할 수 있습니다.
ex)
CALL getAveragePrice(@result);


3. 사용 목적:
함수 (Function): 주로 값을 계산하고 반환하기 위해 사용됩니다. 재사용 가능한 코드 블록을 정의할 때 유용합니다.
스토어드 프로시저 (Stored Procedure): 주로 여러 SQL 문을 묶어서 하나의 프로시저로 실행할 때 사용됩니다. 
복잡한 비즈니스 로직이나 트랜잭션 로직을 처리하는 데에 유용합니다.

4. 트랜잭션 관리:
함수 (Function): 함수는 일반적으로 트랜잭션을 관리하지 않습니다. 
따라서 COMMIT 또는 ROLLBACK 문을 사용할 수 없습니다.
스토어드 프로시저 (Stored Procedure): 스토어드 프로시저는 트랜잭션을 관리할 수 있습니다. 
BEGIN, COMMIT, ROLLBACK과 같은 트랜잭션 관리 명령을 사용할 수 있습니다.

이러한 차이점들을 고려하여 함수와 스토어드 프로시저를 선택하는 것이 중요합니다. 필요한 기능과 목적에 따라 둘 중 적절한 것을 선택하면 됩니다.
*/