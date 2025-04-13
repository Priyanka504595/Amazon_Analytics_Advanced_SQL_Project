-- ---------------------------
-- Schema creation
-- ---------------------------
CREATE TABLE category 
(category_id int primary key,
category_name varchar(20));

create table customers
(customer_id int primary key,
first_name varchar(20),
last_name varchar(20),
state varchar(20),
address varchar(5) default('xxxx'));

create table sellers(
seller_id int primary key	,
seller_name	varchar(25),
origin varchar(15)
);
--Updating data types of sellers table-
-- ALTER TABLE sellers
-- ALTER COLUMN origin VARCHAR(20);


create table products(
product_id int primary key,
product_name varchar(50),
price float,
cogs float,
category_id int, --FK
constraint product_fk_category foreign key(category_id) references category(category_id)
);

create table orders(
order_id int primary key,	
order_date date,
customer_id	int, --FK 
seller_id int, --FK
order_status varchar(15),
constraint orders_fk_customers foreign key(customer_id) references customers(customer_id),
constraint orders_fk_sellers foreign key(seller_id) references sellers(seller_id)
);

create table order_items(
order_item_id int primary key,	
order_id int, --FK
product_id int, --FK
quantity int,
price_per_unit float,
constraint order_items_fk_orders foreign key(order_id) references orders(order_id),
constraint order_items_fk_products foreign key(product_id) references products(product_id)
);

create table payments(
payment_id int primary key,
order_id int, --FK
payment_date date,
payment_status varchar(20)
constraint payments_fk_orders foreign key(order_id) references orders(order_id)
);

create table shipping(
shipping_id	int primary key,
order_id int, --FK
shipping_date date,
return_date	date, 
shipping_providers	varchar(15),
delivery_status varchar(20)
constraint shipping_fk_orders foreign key(order_id) references orders(order_id)
);

Alter table shipping
alter column return_date varchar(25);


create  table inventory(
inventory_id int primary key,
product_id int, --FK
stock int,
warehouse_id int,
last_stock_date date,
constraint inventory_fk_products foreign key(product_id) references products(product_id)
);

-- ---------------------------
-- Data Import Order
-- ---------------------------
--Follow below hirearary to import the data
-- 1st import to category table
-- 2nd Import to customers
-- 3rd Import to sellers
-- 4th Import to Products
-- 5th Import to orders
-- 6th Import to order_items
-- 7th Import to payments
-- 8th Import to shippings table
-- 9th Import to Inventory Table