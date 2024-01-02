-- 
-- Feature check in 
-- 
CREATE OR REPLACE FUNCTION feature_check_in(_payment_id int)
RETURNS VOID
AS
$$
	DECLARE
		_copy_id int;
	BEGIN
		UPDATE books_borrowing
		SET priority = '1', payment_status = true
		WHERE payment_id = _payment_id
		RETURNING copy_id INTO _copy_id;
		
		UPDATE material_copies
		SET status = '1'
		WHERE copy_id = _copy_id;
	END;
$$
LANGUAGE plpgsql;