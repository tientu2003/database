-- 
-- Feature check out
-- 
CREATE OR REPLACE FUNCTION function_check_out(_user_id int, _copy_id int, _book_id int, _staff_id int, _borrow_date date, _time_for_borrowing int)
RETURNS VOID
AS
$$
	SELECT addBorrowRecord(_user_id, _copy_id, _book_id, _staff_id, _borrow_date, _borrow_date + _time_for_borrowing, '0');
$$
LANGUAGE sql;