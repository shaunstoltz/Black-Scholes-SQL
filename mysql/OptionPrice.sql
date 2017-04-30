delimiter //
create Function OptionPrice (_CallPut int, _S0 double, _q double, _t double, _X double, _r double, _s double) 
returns double
begin
	if _CallPut = 0 then
		set @_p = CallPrice(_S0, _q, _t, _X, _r, _s);
	else
		set @_p = PutPrice(_S0, _q, _t, _X, _r, _s);
	end if;
	return @_p;
end //
delimiter ;
