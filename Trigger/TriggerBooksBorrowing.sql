-- 
-- Trigger change copy status
-- 
CREATE OR REPLACE FUNCTION update_material_copies_status() 
RETURNS TRIGGER 
AS 
$$
	BEGIN
		UPDATE material_copies
		SET status = '2'
		WHERE copy_id = NEW.copy_id;
		RETURN NEW;
	END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_add_book_borrow_record
AFTER INSERT ON books_borrowing
FOR EACH ROW EXECUTE PROCEDURE update_material_copies_status();