CREATE OR REPLACE FUNCTION number_of_reads_each_materials()
RETURNS TABLE(material_id INT,number_of_reads INT)
AS
$$
	SELECT material_id,COUNT(material_id)
	FROM reading_histories
	GROUP BY material_id
	ORDER BY COUNT(material_id) DESC
$$
LANGUAGE sql;