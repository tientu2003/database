CREATE OR REPLACE FUNCTION insertHistory(_file1 varchar)
RETURNS void
AS
$$
BEGIN
	SET datestyle = 'ISO, DMY';
	EXECUTE format('COPY reading_histories(user_id, read_time, material_id) FROM %L DELIMITER '','' CSV HEADER', _file1);
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insertReadingHistory(_uid reading_histories.user_id%TYPE, _date reading_histories.read_time%TYPE,
											   _mid reading_histories.material_id%TYPE)
RETURNS void
AS
$$
BEGIN
	INSERT INTO reading_histories VALUES (_uid,_date,_mid);
END;
$$
LANGUAGE plpgsql;