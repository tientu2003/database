CREATE OR REPLACE FUNCTION importMaterial(_material_id int, _material_name varchar, _material_type int, _publisher varchar, _publish_date date, _price float, _staff_id int, _date date, _supplier varchar)
RETURNS VOID 
AS
$$
	INSERT INTO materials(material_id, material_name, material_type, publisher, publish_date, price)
	VALUES (_material_id, _material_name, _material_type, _publisher, _publish_date, _price);
	
	INSERT INTO material_importations
	VALUES(_staff_id, _material_id, _date, _supplier);
$$
LANGUAGE sql;

-- OLD CODE
-- 	

-- 	DECLARE
-- 		_copy_id INT;
-- 	BEGIN	
-- 		INSERT INTO material_copies(material_id, status, copy_position)
-- 		VALUES(_material_id, _status, _copy_position)
-- 		RETURNING copy_id INTO _copy_id;

-- 		INSERT INTO material_importations
-- 		VALUES(_staff_id, _copy_id, _date, _supplier);
-- 	END;
-- $$
-- LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION importImportationTable(_file varchar)
RETURNS VOID 
AS
$$
BEGIN	
	EXECUTE format('COPY material_importations(staff_id, material_id, acquisition_date, supplier) FROM %L DELIMITER '','' CSV HEADER', _file);
END;
$$
LANGUAGE plpgsql;

