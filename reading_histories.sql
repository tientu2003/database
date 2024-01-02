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

select * from insertHistory('D:\1. Tai lieu\2023-1\5. Database lab\Project\database\ReadingHistory.csv');