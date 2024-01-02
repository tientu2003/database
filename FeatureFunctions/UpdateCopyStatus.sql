-- 
-- Feature update copy status
-- 
CREATE OR REPLACE FUNCTION feature_update_copy_status(_copy_id int, _status int, _copy_position varchar)
RETURNS TABLE (copy_id int, status int, copy_position varchar)
AS
$$
	BEGIN
		UPDATE material_copies
		SET status = _status, copy_position = _copy_position
		WHERE copy_id = _copy_id
		RETURNING copy_id, status, copy_position;
	END;
$$
LANGUAGE plpgsql;