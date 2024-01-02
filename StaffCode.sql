CREATE OR REPLACE FUNCTION addStaff(_name staffs.full_name%TYPE, _gender staffs.gender%TYPE, _staff_location staffs.staff_location%TYPE, _salary staffs.salary%TYPE, _email staffs.email%TYPE, _dob staffs.dob%TYPE)
RETURNS VOID
AS
$$
	INSERT INTO staffs(full_name, gender, staff_location, salary, email, dob)
	VALUES(_name, _gender, _staff_location, _salary, _email, _dob);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION addStaffFromFile(_file varchar)
RETURNS VOID
AS
$$
BEGIN
	SET datestyle = 'ISO, DMY';
	EXECUTE format('COPY staffs(full_name,gender, staff_location,salary, email,dob) FROM %L DELIMITER '','' CSV HEADER', _file);
END;
$$
LANGUAGE plpgsql;