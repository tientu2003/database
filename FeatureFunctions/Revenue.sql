--  show revenue in a period of time
CREATE OR REPLACE FUNCTION show_revenue_in_period(_start_time date, _end_time date)
RETURNS TABLE(start_time date, end_time date, revenue float)
AS
$$
	SELECT _start_time, _end_time, SUM(m.price)
	FROM books_borrowing AS bb
		INNER JOIN book_copies AS bc ON bb.copy_id = bc.copy_id
		INNER JOIN materials AS m ON bc.book_id = m.material_id
	WHERE bb.borrow_date >= _start_time AND bb.borrow_date <= _end_time AND bb.payment_status = true
$$
LANGUAGE sql;

-- Testing
SELECT * FROM show_revenue_in_period('2000-01-01', '2023-01-01')