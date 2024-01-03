-- order of execution
--1 CreateTable.sql
--2 add all trigger and functions EXCEPT TriggerBooksBorrowing
--3 import data
-- Staff Data
ALTER SEQUENCE staffs_staff_id_seq RESTART WITH 1;
ALTER SEQUENCE users_user_id_seq RESTART WITH 1;
ALTER SEQUENCE material_copies_copy_id_seq RESTART WITH 1;
ALTER SEQUENCE material_importations_copy_id_seq RESTART WITH 1;
SELECT * FROM addStaffFromFile('D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\StaffData.csv');
-- Users Data
SELECT * FROM addUserFromFile('D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\UserData.csv');
-- insert book
SELECT * FROM insertNewMaterial(1,'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\BookMaterial.csv',
							   'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\Book.csv');
-- insert newspaper
SELECT * FROM insertNewMaterial(2,'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\NewspaperMaterial.csv',
							   'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\Newspaper.csv');
-- insert magazine
SELECT * FROM insertNewMaterial(3,'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\MagazineMaterial.csv',
							   'D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\Magazine.csv');
SELECT * FROM addNewBook(6667,'A','CAM','01 02 2022', 9.01,'Fiction','JON','123213213');
SELECT * FROM addNewBook(3334,'ABC','CAM','01 02 2022', 9.01,'Fiction','LEY','123673213');
SELECT * FROM addNewBook(1,'AASDF','CAM','01 02 2022', 10.01,'Fiction','JONSHO','15613213');
SELECT * FROM addNewBook(0,'Zero','Zero','01 02 2022', 13.01,'Fiction','AGD','23476767');
INSERT INTO users VALUES (0,'nguyen van A','23 12 2023','f','123213213','Hai Ba Trung', 'A@gmail.com',1,'A123','1asdasdsad');
-- insertHistoryRecord
SELECT * FROM insertHistory('D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\ReadingHistory.csv');

-- insertMaterialsCopies
SELECT * FROM addCopiesFromFile('D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\Copies.csv');

INSERT INTO staffs VALUES (0,'nguyen van A','f','Hai Ba Trung', 123.02, 'A@gmail.com','23 12 2023');
-- add data into ImportationTable
SELECT * FROM importImportationTable('D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\ImportationTable.csv');

-- add data into Borrowing Table
SELECT * FROM addBorrowRecordFromFile('D:\1. Tai lieu\2023-1\5. Database lab\Project\database\Data\Borrow.csv');

-- add TriggerBooksBorrowing