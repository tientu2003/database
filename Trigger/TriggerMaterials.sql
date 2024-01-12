CREATE OR REPLACE FUNCTION increaseQuantityOfMagazineAndNewsPaper() 
RETURNS TRIGGER 
AS 
$$
	BEGIN
		UPDATE materials
		SET total_quantity = total_quantity+1
		WHERE material_id = NEW.material_id;
		UPDATE materials
		SET available_quantity = available_quantity+1
		WHERE material_id = NEW.material_id;
		RETURN NEW;
	END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER TriggerQuantityOfMagazineAndNewsPaper
AFTER INSERT ON materials
FOR EACH ROW EXECUTE PROCEDURE increaseQuantityOfMagazineAndNewsPaper();