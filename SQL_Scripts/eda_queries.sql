-- ---------------------------
-- EDA
-- ---------------------------
Select * from category;
Select * from customers;
Select * from inventory;
Select * from order_items;
Select * from orders;
Select * from payments;
Select distinct payment_status from payments;
Select * from products;
Select * from sellers;
Select * from shipping;
Select distinct delivery_status from shipping;
Select * from orders where order_id = 6747;
Select * from payments where order_id = 6747;
Select * from shipping where return_date = '';
Select * from shipping WHERE return_date IS NOT NULL AND return_date <> '';