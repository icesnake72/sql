call employee.getBuseoName();

-- mysql에서 함수를 정상적으로 생성하기 위하여 아래와 같은 처리를 해주어야 한다
show global variables like 'log_bin_trust_function_creators';
SET GLOBAL log_bin_trust_function_creators = 1; 
