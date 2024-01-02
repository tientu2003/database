CREATE OR REPLACE FUNCTION addCopiesFromFile(_file varchar)
RETURNS VOID
AS
$$
BEGIN
	EXECUTE format('COPY material_copies(material_id, status, copy_position) FROM %L DELIMITER '','' CSV HEADER', _file);
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION addCopies(_mid material_copies.material_id%TYPE, _status int,_position material_copies.copy_position%TYPE)
RETURNS VOID
AS
$$
BEGIN
	INSERT INTO material_copies VALUES ((select count(material_copies.copy_id) from material_copies) + 1,_mid,_status,_position);
END;
$$
LANGUAGE plpgsql;

Select * from addCopies(3,1,'1234');