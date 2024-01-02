DROP TABLE staffs CASCADE;
DROP TABLE materials CASCADE;
DROP TABLE material_copies CASCADE;
DROP TABLE magazines CASCADE;
DROP TABLE material_importations CASCADE;
DROP TABLE newspapers CASCADE;
DROP TABLE users CASCADE;
DROP TABLE books CASCADE;
DROP TABLE reading_histories CASCADE;
DROP TABLE books_borrowing CASCADE;
-- 1
CREATE TABLE staffs
(
	staff_id SERIAL PRIMARY KEY,
	full_name varchar(80) NOT NULL,
	gender char,
	staff_location varchar(60),
	salary float,
	email varchar(80),
	dob date,
	CONSTRAINT chk_gender CHECK (gender IN ('f', 'm')),
	CONSTRAINT chk_salary CHECK (salary > 0),
	CONSTRAINT chk_email CHECK (email LIKE '%_@_%._%')
);
-- 2
CREATE TABLE materials
(
	material_id int PRIMARY KEY,
	material_name varchar(80) NOT NULL,
	material_type int NOT NULL,
	publisher varchar(80),
	publish_date date,
	total_quantity int DEFAULT '0',
	available_quantity int DEFAULT '0',
	price float,
	CONSTRAINT chk_type CHECK (material_type between 1 and 3),
	CONSTRAINT chk_total_quantity CHECK(total_quantity >= 0),
	CONSTRAINT chk_available_quantity CHECK (available_quantity >=0 AND available_quantity <= total_quantity),
	CONSTRAINT chk_price CHECK (price >= 0)
);
-- book, newspaper, magazine
-- 3
CREATE TABLE material_copies
(
	copy_id SERIAL PRIMARY KEY,
	material_id int NOT NULL,
	status int,
	copy_position varchar(30),
	CONSTRAINT fk_materialcopies_materialid FOREIGN KEY (material_id) REFERENCES materials(material_id),
	CONSTRAINT chk_status CHECK (status between 1 and 5)
);
-- ('available', 'borrowing', 'lost', 'damaged', 'removed')
-- 4
CREATE TABLE material_importations
(
	staff_id SERIAL,
	copy_id SERIAL,
	acquisition_date date,
	supplier varchar(60),
	CONSTRAINT fk_materialimportation_staffid FOREIGN KEY (staff_id) REFERENCES staffs(staff_id),
	CONSTRAINT fk_materialimportation_copyid FOREIGN KEY (copy_id) REFERENCES material_copies(copy_id),
	CONSTRAINT material_importations_pk PRIMARY KEY (staff_id, copy_id)
);
-- 5
CREATE TABLE users
(
	user_id SERIAL,
	full_name varchar(80) NOT NULL,
	dob date,
	gender char,
	phone_number int,
	address varchar(35),
	email varchar(80),
	payment_method varchar(20),
	username varchar(80) UNIQUE NOT NULL,
	user_password varchar(80) NOT NULL,
	CONSTRAINT users_pk PRIMARY KEY (user_id),
	CONSTRAINT chk_gender CHECK (gender IN ('m', 'f')),
	CONSTRAINT chk_email CHECK (email LIKE '%_@_%._%')
);
-- 6
CREATE TABLE newspapers
(
	newspaper_id int PRIMARY KEY,
	newspaper_language varchar(60),
	reporter varchar(80),
	CONSTRAINT fk_newspaper_newspaperid FOREIGN KEY (newspaper_id) REFERENCES materials(material_id)
);
-- 7
CREATE TABLE magazines
(
	magazine_id int PRIMARY KEY,
	topic varchar(80),
	issue_number varchar(50),
	CONSTRAINT fk_magazine_magazineid FOREIGN KEY (magazine_id) REFERENCES materials(material_id)
);
-- 8
CREATE TABLE books
(
	book_id int PRIMARY KEY,
	genre varchar(40),
	author varchar(80),
	isbn int,
	CONSTRAINT fk_book_bookid FOREIGN KEY (book_id) REFERENCES materials(material_id)
);
-- 9
CREATE TABLE reading_histories
(
	user_id SERIAL,
	read_time timestamp,
	material_id int NOT NULL,
	CONSTRAINT fk_readinghistory_userid FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT readinghistory_pk PRIMARY KEY (user_id, read_time),
	CONSTRAINT fk_readinghistory_materialid FOREIGN KEY (material_id) REFERENCES materials(material_id)
);
-- 10
CREATE TABLE books_borrowing
(
	payment_id SERIAL PRIMARY KEY,
	user_id SERIAL NOT NULL,
	book_id int NOT NULL,
	copy_id SERIAL NOT NULL,
	staff_id SERIAL NOT NULL,
	priority int,
	borrow_date date,
	due_date date,
	payment_status boolean,
	CONSTRAINT fk_booksborrowing_userid FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT fk_bookborrowing_bookid FOREIGN KEY (book_id) REFERENCES books(book_id),
	CONSTRAINT fk_booksborrowing_copyid FOREIGN KEY (copy_id) REFERENCES material_copies(copy_id),
	CONSTRAINT fk_booksborrowing_staffid FOREIGN KEY (staff_id) REFERENCES staffs(staff_id),
	CONSTRAINT chk_priority CHECK (priority between 1 and 5),
	CONSTRAINT chk_borrow_date CHECK (borrow_date < due_date)
);