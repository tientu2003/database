-- (1 :'available', 2: 'borrowing',3: 'lost', 4: 'damaged', 5: 'removed')

CREATE OR REPLACE FUNCTION public.updateMaterialsWhenInsertCopy()
RETURNS TRIGGER 
AS 
$$
BEGIN
	if(NEW.status <> 5 OR NEW.status <> 3) then 
	update materials set total_quantity = total_quantity + 1
	where material_id = NEW.material_id;
		if (NEW.status = 1) then 
		update materials set available_quantity = available_quantity + 1
		where material_id = NEW.material_id;
		end if;
	end if;
	return NEW;
END; 
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_insert_copy 
	AFTER INSERT ON material_copies
	FOR EACH ROW
	EXECUTE FUNCTION public.updateMaterialsWhenInsertCopy();
	
	
CREATE OR REPLACE FUNCTION public.updateMaterialsWhenUpdateCopy()
RETURNS TRIGGER 
AS 
$$
BEGIN
	if(NEW.status <> 5 OR NEW.status <> 3) then 
		if (NEW.status = 1) then 
		update materials set available_quantity = available_quantity + 1
		where material_id = NEW.material_id;
		else  
		update materials set available_quantity = available_quantity - 1
		where material_id = NEW.material_id;
		end if;
	else  
		update materials set total_quantity = total_quantity - 1
		where material_id = NEW.material_id;
		update materials set available_quantity = available_quantity - 1
		where material_id = NEW.material_id;
	end if;
	return NEW;
END; 
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_insert_copy 
	AFTER UPDATE OF status ON material_copies
	FOR EACH ROW
	EXECUTE FUNCTION public.updateMaterialsWhenUpdateCopy();


		