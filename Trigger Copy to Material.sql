CREATE OR REPLACE FUNCTION public.updateMaterials()
RETURNS TRIGGER 
AS 
$$
BEGIN
	update materials set total_quantity = total_quantity + 1
	where material_id = NEW.material_id;
	update materials set available_quantity = available_quantity + 1
	where material_id = NEW.material_id;
	return NEW;
END; 
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_insert_copy 
	AFTER INSERT OR UPDATE ON material_copies
	FOR EACH ROW
	EXECUTE FUNCTION public.updateMaterials();
