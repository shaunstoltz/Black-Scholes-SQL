DELIMITER //
CREATE FUNCTION ImpliedVolatility(_CallPut int, _S0 double, _q double, _t double, _X double, _r double, _P double)
RETURNS double
BEGIN
	set @_s = 0.4;
	set @_count = 0;
	set @_increment = 0.30;
	set @_bigger = 0;
	WHILE (@_count < 200) DO
		if _CallPut = 0 then
			set @_GuessP = CallPrice(_S0, _q, _t, _X, _r, @_s);
		else
			set @_GuessP = PutPrice(_S0, _q, _t, _X, _r, @_s);
		END if;
		if @_GuessP > _P -0.01 and @_GuessP < _P +0.01 then
			RETURN @_s;
		END if;
		
		if @_GuessP > _P then
			if @_bigger = 0 AND @_increment >= 0.0001 then
				set @_increment = @_increment*3/4;
			END if;
			set @_s = @_s - @_increment;
			set @_bigger = 1;
		else
			if @_bigger = 1 AND @_increment >= 0.0001 then
				set @_increment = @_increment*3/4;
			END if;
			set @_s = @_s + @_increment;
			set @_bigger = 0;
		END if;
		set @_count = @_count + 1;
	END WHILE;
    RETURN @_s;
END //
DELIMITER ;