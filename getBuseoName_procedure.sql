CREATE DEFINER=`root`@`localhost` PROCEDURE `getBuseoName`()
BEGIN	
	select distinct buseo_name from employee_view;
END