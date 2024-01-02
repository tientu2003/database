CREATE OR REPLACE TRIGGER check_insert_import 
	AFTER UPDATE ON material_copies
	FOR EACH ROW 
	EXECUTE FUNCTION check_copy_exists(ROW.copy_id);
-- INSERT INTO staffs Values(1,'Amanda Lesch','f','42 Metz Mills','1952.66','Terrence.Towne96@hotmail.com','07  04 2023');

INSERT INTO material_importations Values(
	1,1,'02 02 2003','A'
)