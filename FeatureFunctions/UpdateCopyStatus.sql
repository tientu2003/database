-- 
-- Feature update copy status
-- 
CREATE OR REPLACE FUNCTION feature_update_copy_status(_copy_id int, _status int, _copy_position varchar)
RETURNS SETOF book_copies
AS
$$
	BEGIN
		RETURN QUERY
			UPDATE book_copies
			SET status = _status, copy_position = _copy_position
			WHERE copy_id = _copy_id
			RETURNING book_copies.*;
	END;
$$
LANGUAGE plpgsql;