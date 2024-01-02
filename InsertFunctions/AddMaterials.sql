-- 
-- Add new materials
-- 

CREATE OR REPLACE FUNCTION addNewBook(_material_id int, _name materials.material_name%TYPE, _publisher materials.publisher%TYPE, _publish_date materials.publish_date%TYPE, _price materials.price%TYPE, _genre books.genre%TYPE, _author books.author%TYPE, _isbn books.isbn%TYPE)
RETURNS VOID 
AS
$$
	INSERT INTO materials(material_id, material_name, material_type, publisher, publish_date, price)
	VALUES(_material_id, _name, '1', _publisher, _publish_date, _price);

	INSERT INTO books
	VALUES(_material_id , _genre, _author, _isbn);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION addNewNewspaper(_material_id int, _name materials.material_name%TYPE, _publisher materials.publisher%TYPE, _publish_date materials.publish_date%TYPE, _price materials.price%TYPE, _newspaper_language varchar, _reporter varchar)
RETURNS VOID 
AS
$$
	INSERT INTO materials(material_id, material_name, material_type, publisher, publish_date, price)
	VALUES(_material_id, _name, '2', _publisher, _publish_date, _price);

	INSERT INTO newspapers
	VALUES(_material_id , _newspaper_language, _reporter);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION addNewMagazine(_material_id int, _name materials.material_name%TYPE, _publisher materials.publisher%TYPE, _publish_date materials.publish_date%TYPE, _price materials.price%TYPE, _topic varchar, _issue_number varchar)
RETURNS VOID 
AS
$$
	INSERT INTO materials(material_id, material_name, material_type, publisher, publish_date, price)
	VALUES(_material_id, _name, '3', _publisher, _publish_date, _price);

	INSERT INTO books
	VALUES(_material_id, _topic, _issue_number);
$$
LANGUAGE sql;