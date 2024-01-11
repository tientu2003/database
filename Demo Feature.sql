-- SELECT COUNT(u.user_id) AS Users, COUNT(s.staff_id) AS Staffs, COUNT(m.material_id) AS Materials, 
-- COUNT(r.read_time) AS Reading_history, COUNT(mc.copy_id) AS Copies, COUNT(mi.copy_id) AS Material_Importations
-- FROM users u,staffs s, materials as m, reading_histories r, material_copies mc, material_importations mi;

-- search history
SELECT * FROM searchReadingHistoryByUserID(12);

SELECT * FROM searchReadingHistoryByMaterialID(5555);

-- check out
SELECT * FROM function_check_out(1,2,1888,120,'03 01 2024',7);
-- (user_id, copy_id, book_id, staff_id, borrow_date, time for borrowing)

-- check in
SELECT * FROM books_borrowing WHERE payment_id = 1001;
SELECT * FROM feature_check_in(1001);

-- update copy_status
SELECT * FROM material_copies LIMIT 100;
SELECT * FROM material_copies WHERE copy_id = 1;
SELECT * FROM materials WHERE material_id = 1888;
SELECT * FROM feature_update_copy_status(1,1,'D1234');
SELECT * FROM materials WHERE material_id = 1888;

-- insert FUNCTION
SELECT * FROM material_copies WHERE material_id = 330;
SELECT addCopies(330,1,'D1234');
SELECT * FROM material_copies WHERE material_id = 330;