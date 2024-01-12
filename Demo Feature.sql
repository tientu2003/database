-- INSERT FUNCTION EXAMPLE
SELECT * FROM book_copies WHERE book_id = 330; ---check current copies of book_id
SELECT addCopies(330,1,'D1234');				--- add new copies (book_id, status, "location")
SELECT * FROM book_copies WHERE book_id = 330; ---check result 
-- Another INSERT FUNCTION in INSERT FUNCTION folder

-- search history
SELECT * FROM searchReadingHistoryByUserID(12);

SELECT * FROM searchReadingHistoryByMaterialID(1000);

-- check out
SELECT copy_id, book_id FROM book_copies 		-- find book_id of copy_id
ALTER SEQUENCE books_borrowing_payment_id_seq RESTART WITH 1001; -- because when run execution.sql we dont use InsertFuction so seq not inscrease
SELECT * FROM feature_check_out(1,997,10,'03/01/2024',7); -- if it false because the available quantity constraint ensure it >=0
-- (user_id, copy_id, staff_id, borrow_date, time for borrowing)

-- check in
SELECT * FROM books_borrowing WHERE payment_status = false;	-- find the payment_id you and to send back borrowed book
-- payment_status means that borrower havent sent back book.
SELECT * FROM feature_check_in(2);							-- because of data generator is not consistent, so set it = 4

-- update copy_status
SELECT * FROM book_copies LIMIT 100; -- find book_id of copy_id
SELECT * FROM materials WHERE material_id = 990; -- find book_id of copy_id to proof trigger
SELECT * FROM feature_update_copy_status(1,1,'D1234');
SELECT * FROM materials WHERE material_id = 990; -- check trigger

-- revenue feature
SELECT * FROM show_revenue_in_period('2000-01-01', '2023-01-01');
-- number of reads each materials

SELECT * FROM number_of_reads_each_materials();