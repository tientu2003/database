CREATE OR REPLACE FUNCTION addCopiesFromFile(_file varchar)
RETURNS VOID
AS
$$
BEGIN
	EXECUTE format('COPY book_copies(book_id, status, copy_position) FROM %L DELIMITER '','' CSV HEADER', _file);
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION addCopies(_mid book_copies.book_id%TYPE, _status int,_position book_copies.copy_position%TYPE)
RETURNS VOID
AS
$$
BEGIN
	INSERT INTO book_copies VALUES ((select count(book_copies.copy_id) from book_copies) + 1,_mid,_status,_position);
END;
$$
LANGUAGE plpgsql;
