-- 
-- Add book borrowing record
-- 
CREATE OR REPLACE FUNCTION addBorrowRecord(_user_id int, _copy_id int, _book_id int, _staff_id int, _borrow_date date, _due_date date, _payment_status bool)
RETURNS VOID
AS
$$
	INSERT INTO books_borrowing(user_id, book_id, copy_id, staff_id, borrow_date, due_date, payment_status)
	VALUES(_user_id, _book_id, _copy_id, _staff_id, _borrow_date, _due_date, _payment_status);
$$
LANGUAGE sql;