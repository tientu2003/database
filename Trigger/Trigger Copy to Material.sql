-- (1 :'available', 2: 'borrowing',3: 'lost', 4: 'damaged', 5: 'removed')

CREATE OR REPLACE FUNCTION public.updateMaterialsWhenInsertCopy()
RETURNS TRIGGER 
AS 
$$
BEGIN
	if(NEW.status = 1 OR NEW.status = 2 OR NEW.status = 4) then 
	update materials set total_quantity = total_quantity + 1
	where material_id = NEW.book_id;
		if (NEW.status = 1 )then 
		update materials set available_quantity = available_quantity + 1
		where material_id = NEW.book_id;
		end if;
	end if;
	return NEW;
END; 
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_insert_copy 
	AFTER INSERT ON book_copies
	FOR EACH ROW
	EXECUTE FUNCTION public.updateMaterialsWhenInsertCopy();
	
CREATE OR REPLACE FUNCTION public.updateMaterialsWhenUpdateCopy()
RETURNS TRIGGER 
AS 
$$
BEGIN
	if (NEW.status = 1 OR NEW.status = 2 OR NEW.status = 4) then 
		if (NEW.status = 1 )then 
		update materials set available_quantity = available_quantity + 1
		where material_id = NEW.book_id;
		else  
		update materials set available_quantity = available_quantity - 1
		where material_id = NEW.book_id;
		end if;
	else  
		update materials set total_quantity = total_quantity - 1
		where material_id = NEW.book_id;
		update materials set available_quantity = available_quantity - 1
		where material_id = NEW.book_id;
	end if;
	return NEW;
END; 
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_update_copy 
	AFTER UPDATE OF status ON book_copies
	FOR EACH ROW
	EXECUTE FUNCTION public.updateMaterialsWhenUpdateCopy();


		