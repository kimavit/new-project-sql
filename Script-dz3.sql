SELECT DISTINCT c.name 
FROM analysis a 
INNER JOIN orderitems o ON o.id_an = a.id_an
RIGHT JOIN category_an c ON c.id_cat_an = a.id_cat_an
WHERE o.id_an IS NULL
