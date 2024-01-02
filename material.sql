CREATE OR REPLACE FUNCTION insertNewMaterial(_mode int,_file1 varchar,_file2 varchar)
RETURNS void
AS
$$
BEGIN
	SET datestyle = 'ISO, DMY';
	EXECUTE format('COPY materials(material_id, material_name, material_type, publisher,publish_date, total_quantity,available_quantity, price) FROM %L DELIMITER '','' CSV HEADER', _file1);
	IF(_mode = 1) THEN
		EXECUTE format('COPY books(book_id, genre, author, isbn) FROM %L DELIMITER '','' CSV HEADER', _file2);
	END IF;
	IF(_mode = 2) THEN
		EXECUTE format('COPY newspapers(newspaper_id, newspaper_language, reporter) FROM %L DELIMITER '','' CSV HEADER', _file2);
	END IF;
	IF(_mode = 3) THEN
		EXECUTE format('COPY magazines(magazine_id, topic, issue_number) FROM %L DELIMITER '','' CSV HEADER', _file2);
	END IF;
END;
$$
LANGUAGE plpgsql;
-- add book
Select * from insertNewMaterial(1,
'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\BookMaterial.csv'
 ,'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Book.csv');
-- add newspaper
Select * from insertNewMaterial(2,
'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\NewspaperMaterial.csv'
 ,'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Newspaper.csv');
-- add magazine
Select * from insertNewMaterial(3,
'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\MagazineMaterial.csv'
 ,'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Magazine.csv');
 
 
INSERT INTO Materials VALUES 
(0,'TEST0',1,'ACDW','02-11-2022',NULL,NULL,NULL),
(1,'TEST',3,'IPM','02-11-2022',NULL,NULL,NULL),
(3334, 'A', 2, 'CAM', '01-12-2023', NULL, NULL, NULL),
(6667, 'Abc', 1, 'KIMDONG', '01-12-2023', NULL, NULL, NULL)
;
 