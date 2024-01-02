CREATE OR REPLACE FUNCTION searchReadingHistoryByUserID(_id reading_histories.user_id%TYPE)
RETURNS VOID
AS
$$
	SELECT * FROM reading_histories
	WHERE (user_id = _id);
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION searchReadingHistoryByMaterialID(_id reading_histories.material_id%TYPE)
RETURNS VOID 
AS
$$
	SELECT * FROM reading_histories
	WHERE (material_id = _id);

$$
LANGUAGE sql;