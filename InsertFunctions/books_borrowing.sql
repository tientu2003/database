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

CREATE OR REPLACE FUNCTION addBorrowRecordFromFile(_file varchar)
RETURNS VOID
AS
$$
BEGIN
	SET datestyle = 'ISO, DMY';
	EXECUTE format('COPY books_borrowing(user_id, book_id , copy_id , staff_id ,borrow_date,due_date,payment_status) FROM %L DELIMITER '','' CSV HEADER', _file);
END;
$$
LANGUAGE plpgsql;

-- 
-- Funtion reset all priority 
-- 
CREATE OR REPLACE FUNCTION reset_all_priority() 
RETURNS VOID 
AS 
$$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT * FROM books_borrowing
    LOOP
        UPDATE books_borrowing 
		SET priority = CASE 
            WHEN payment_status = true THEN 1
			WHEN now()::date > due_date THEN 5
			WHEN now()::date - borrow_date > (due_date - borrow_date) / 4 THEN 2
			WHEN now()::date - borrow_date > (due_date - borrow_date) / 2 THEN 3
			WHEN now()::date - borrow_date > 3 * (due_date - borrow_date) / 4 THEN 4
			ELSE 1
        END
        WHERE books_borrowing.payment_id = rec.payment_id;
    END LOOP;
END;
$$ 
LANGUAGE plpgsql;

-- 
-- Trigger to change borrow priority
-- 
CREATE OR REPLACE FUNCTION resetPriority()
RETURNS TRIGGER
AS
$$
	BEGIN
		UPDATE books_borrowing
		SET priority = CASE 
			WHEN payment_status = true THEN 1
			WHEN now() > due_date THEN 5
			WHEN (now()::date - borrow_date) > (due_date - borrow_date) / 4 THEN 2
			WHEN (now()::date - borrow_date) > (due_date - borrow_date) / 2  THEN 3
			WHEN (now()::date - borrow_date) > 3 * (due_date - borrow_date) / 4 THEN 4
			ELSE 4
		END
		WHERE payment_id = NEW.payment_id;
		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER borrowPriority
AFTER INSERT OR UPDATE ON books_borrowing
FOR EACH ROW EXECUTE PROCEDURE resetPriority();