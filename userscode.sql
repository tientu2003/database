CREATE OR REPLACE FUNCTION addUserFromFile(_file varchar)
RETURNS VOID
AS
$$
BEGIN
	SET datestyle = 'ISO, DMY';
	EXECUTE format('COPY users(full_name, dob, gender, phone_number,address, email,payment_method, username, user_password) FROM %L DELIMITER '','' CSV HEADER', _file);
END;
$$
LANGUAGE plpgsql;
Select * from addUserFromFile('C:\Users\acer\Downloads\UserData.csv');

CREATE OR REPLACE FUNCTION addUser(_name users.full_name%TYPE, _dob users.dob%TYPE, _gender users.gender%TYPE, 
_phone users.phone_number%TYPE, _address users.address%TYPE,_email users.email%TYPE,_payment users.payment_method%TYPE,
_username users.username%TYPE, _password users.user_password%TYPE)
RETURNS VOID
AS
$$
	INSERT INTO users(full_name, dob, gender, phone_number, address, email, payment_method,username,user_password)
	VALUES(_name, _dob, _gender, _phone, _address, _email,_payment,_username,_password);
$$
LANGUAGE sql;
-- test add
Select * from addUser('Nguyen Van A','25 12 2000','m','01122334','123 Le Thanh Nghi','A@gmail.com','1','Anv1234','asdfgfgfgf');
-- check
Select * from users where full_name Like 'Nguyen Van A';
