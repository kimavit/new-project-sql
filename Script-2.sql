select *
from products p 
where unit_price between 20 and 30 and supplier_id = 2
or units_in_stock > 100 and supplier_id = 3 