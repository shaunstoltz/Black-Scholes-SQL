delimiter //
create Function Colour(_S0 double, _q double, _t double, _X double, _r double, _s double) 
returns double
begin
	set @_d1 = D1(_S0, _X, _t, _r, _q, _s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	set @_d2 = D2(@_d1, _s, _t);
	return (1/365.0)* (Exp(-1*_q*_t) * @_dd1 / ( _s * _S0 * Sqrt(_t)) * (_q + (1-@_d1*@_d2)/(2*_t) - @_d1*(_r-_q)/(_s* Sqrt(_t))));
end //
delimiter ;