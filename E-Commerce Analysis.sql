use SalesRevenue

------ RENAME TABLE:
exec sp_rename 'olist_customers_dataset', 'customers'
exec sp_rename 'olist_geolocation_dataset','geolocation'
exec sp_rename 'olist_order_items_dataset','order_items'
exec sp_rename 'olist_order_payments_dataset','order_payments'
exec sp_rename 'olist_order_reviews_dataset','order_reviews'
exec sp_rename 'olist_orders_dataset','orders'
exec sp_rename 'olist_products_dataset','products'
exec sp_rename 'olist_sellers_dataset','sellers'
exec sp_rename 'product_category_name_translation','translation'

select * from customers
select * from geolocation
select * from order_items
select * from order_payments
select * from order_reviews
select * from orders
select * from products
select * from sellers
select * from translation


------ ADD PRIMARY KEY:
alter table customers 
add constraint PK_customer_id
primary key (customer_id)

alter table orders
add constraint PK_order_id
primary key (order_id)

alter table products
add constraint PK_product_id
primary key (product_id)

alter table sellers
add constraint PK_pseller_id
primary key (seller_id)


------ ADD FOREIGN KEY:
alter table orders
add constraint FK_customer_id
foreign key (customer_id) references customers (customer_id)

alter table order_items
add constraint FK_order_item_id
foreign key (order_id) references orders (order_id)

alter table order_items
add constraint FK_seller_id
foreign key (seller_id) references sellers (seller_id)

alter table order_items
add constraint FK_product_id
foreign key (product_id) references products(product_id)

alter table order_payments
add constraint FK_order_payment_id
foreign key (order_id) references orders (order_id)

alter table order_reviews
add constraint FK_order_review_id
foreign key (order_id) references orders (order_id)


------ CHECK IS NULL: 
select  
	sum(case when customer_id is null then 1 else 0 end) as missing_customer_id,
    sum(case when customer_city is null then 1 else 0 end) as missing_customer_city,
    sum(case when customer_state is null then 1 else 0 end) as missing_customer_state
from customers

select 
	sum(case when order_id is null then 1 else 0 end) as missing_order_id,
	sum(case when product_id is null then 1 else 0 end) as missing_product_id,
	sum(case when seller_id is null then 1 else 0 end) as missing_seller_id,
	sum(case when shipping_limit_date is null then 1 else 0 end) as missing_shippingdate,
	sum(case when price is null then 1 else 0 end) as missing_price,
	sum(case when freight_value is null then 1 else 0 end) as missing_freight_value
from order_items

select
	sum(case when order_id is null then 1 else 0 end) as missing_order_id,
	sum(case when payment_sequential is null then 1 else 0 end) as missing_payment_sequential,
	sum(case when payment_type is null then 1 else 0 end) as missing_payment_type,
	sum(case when payment_installments is null then 1 else 0 end) as missing_payment_installment,
	sum(case when payment_value is null then 1 else 0 end) as missing_payment_value
from order_payments

select count(*) - count(order_id) as missing_count 
from order_reviews

select 
	sum(case when order_id is null then 1 else 0 end) as missing_order_id,
	sum(case when customer_id is null then 1 else 0 end) as missing_customer_id,
	sum(case when order_status is null then 1 else 0 end) as missing_order_status_id,
	sum(case when order_purchase_timestamp is null then 1 else 0 end) as missing_order_purchase_timestamp,
	sum(case when order_approved_at is null then 1 else 0 end) as missing_order_approved_at,
	sum(case when order_delivered_carrier_date is null then 1 else 0 end) as missing_order_delivered_carrier_date,
	sum(case when order_delivered_customer_date is null then 1 else 0 end) as missing_order_delivered_customer_date,
	sum(case when order_estimated_delivery_date is null then 1 else 0 end) as missing_order_estimated_delivery_date
from orders

select *
from orders
where order_approved_at is null
or order_delivered_carrier_date is null 
or order_delivered_customer_date is null 


select 
	sum(case when product_id is null then 1 else 0 end) as missing_product_id,
	sum(case when product_category_name is null then 1 else 0 end) as missing_product_category_name,
	sum(case when product_photos_qty is null then 1 else 0 end) as missing_product_photo_qty
from products

select *
from products
where product_category_name is null

select 
	sum(case when seller_id is null then 1 else 0 end) as missing_seller_id,
	sum(case when seller_city is null then 1 else 0 end) as missing_seller_city,
	sum(case when seller_state is null then 1 else 0 end) as missing_seller_state
from sellers

select 
	sum(case when column1 is null then 1 else 0 end) as missing_cl1,
	sum(case when column2 is null then 1 else 0 end) as missing_cl2
from translation


------ CHECK FOR DUPLICATE: 
select customer_id, count(*) as duplicates_count
from customers
group by customer_id
having count(*) > 1

select order_id, count(*) as duplicates_count
from orders
group by order_id
having count(*) > 1

select product_id, count(*) as duplicates_count
from products
group by product_id
having count(*) > 1

select seller_id, count(*) as duplicates_count
from sellers
group by seller_id
having count(*) > 1


------ TRANSLATE PRODUCT CATEGORIES NAME TO ENGLISH:
create index idx_product_category_name on products(product_category_name);
create index idx_translation_column1 on translation(column1);

update p
set p.product_category_name = t.column2
from products p
join translation t
on p.product_category_name = t.column1


------ CREATE INDEX:
create index idx_order_id on orders(order_id);
create index idx_order_id_items on order_items(order_id);
create index idx_order_id_reviews on order_reviews(order_id);
create index idx_order_id_payments on order_payments(order_id);


------ CREATE TEMPORARY TABLES
select order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, 
		order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date
into #temp_orders
from orders;

select order_id, product_id, seller_id, price, freight_value
into #temp_order_items
from order_items;

select order_id, review_score
into #temp_order_reviews
from order_reviews;

select order_id, payment_type, payment_value, payment_sequential, payment_installments
into #temp_order_payments
from order_payments;


------ JOIN TABLE: 
select o.order_id, o.customer_id, o.order_status, o.order_purchase_timestamp, o.order_approved_at, 
       o.order_delivered_carrier_date, o.order_delivered_customer_date, o.order_estimated_delivery_date, 
       i.product_id, i.seller_id, i.price, i.freight_value,
       r.review_score,
       p.payment_type, p.payment_value, p.payment_sequential, p.payment_installments
into orders_full
from #temp_orders o
left join #temp_order_items i on o.order_id = i.order_id
left join #temp_order_reviews r on o.order_id = r.order_id
left join #temp_order_payments p on o.order_id = p.order_id;

select * from orders_full


------ ADD COLUMN:
alter table orders_full
add time_approved int
update orders_full
set time_approved = datediff(hour, order_purchase_timestamp, order_approved_at)

alter table orders_full
add time_delivered_carrier int
update orders_full
set time_delivered_carrier = datediff(hour, order_approved_at, order_delivered_carrier_date)

alter table orders_full
add time_delivered_customer int
update orders_full
set time_delivered_customer = datediff(day, order_delivered_carrier_date, order_delivered_customer_date)

alter table orders_full
add time_estimated int
update orders_full
set time_estimated = datediff(day, order_purchase_timestamp, order_estimated_delivery_date)

alter table orders_full
add time_all int
update orders_full
set time_all = datediff(day, order_purchase_timestamp, order_delivered_customer_date)

alter table orders_full
add time_approved_hour Nvarchar(20)
update orders_full
set time_approved_hour = case
	when time_approved >= 0 and time_approved <= 1 then N'Trong 1 giờ'
	when time_approved >= 2 and time_approved <= 12 then N'Trong nửa ngày'
	when time_approved >= 13 and time_approved <= 24 then N'Trong 1 ngày'
	when time_approved >= 25 and time_approved < = 36 then N'Trong 36 tiếng'
	when time_approved >= 37 and time_approved <= 48 then N'Trong 2 ngày'
	when time_approved >= 49 and time_approved <= 60 then N'Trong 60 tiếng'
	when time_approved >= 61 and time_approved <= 72 then N'Trong 3 ngày'
	when time_approved >= 73 and time_approved <= 99999999 then N'Sau 3 ngày'
end
where time_approved is not null 

alter table orders_full
add time_delivered_carrier_hour Nvarchar(20)
update orders_full
set time_delivered_carrier_hour = case
	when time_delivered_carrier >= 0 and time_delivered_carrier <= 1 then N'Trong 1 giờ'
	when time_delivered_carrier >= 2 and time_delivered_carrier <= 12 then N'Trong nửa ngày'
	when time_delivered_carrier >= 13 and time_delivered_carrier <= 24 then N'Trong 1 ngày'
	when time_delivered_carrier >= 25 and time_delivered_carrier < = 36 then N'Trong 36 tiếng'
	when time_delivered_carrier >= 37 and time_delivered_carrier <= 48 then N'Trong 2 ngày'
	when time_delivered_carrier >= 49 and time_delivered_carrier <= 60 then N'Trong 60 tiếng'
	when time_delivered_carrier >= 61 and time_delivered_carrier <= 72 then N'Trong 3 ngày'
	when time_delivered_carrier >= 73 and time_delivered_carrier <= 99999999 then N'Sau 3 ngày'
end
where time_delivered_carrier is not null 

alter table orders_full 
add time_delivered_customer_day Nvarchar(20)
update orders_full
set time_delivered_customer_day = case
	when time_delivered_customer >= 0 and time_delivered_customer <= 3 then N'Từ 1 đến 3 ngày'
	when time_delivered_customer >= 4 and time_delivered_customer <= 7 then N'Từ 4 đến 7 ngày'
	when time_delivered_customer >= 8 and time_delivered_customer <= 14 then N'Trong 2 tuần'
	when time_delivered_customer >= 15 and time_delivered_customer <= 21 then N'Trong 3 tuần'
	when time_delivered_customer >= 22 and time_delivered_customer <= 28 then N'Trong 1 tháng'
	when time_delivered_customer >= 29 and time_delivered_customer <= 35 then N'Trong 5 tuần'
	when time_delivered_customer >= 36 and time_delivered_customer <= 42 then N'Trong 6 tuần'
	when time_delivered_customer >= 43 and time_delivered_customer <= 49 then N'Trong 7 tuần'
	when time_delivered_customer >= 50 and time_delivered_customer <= 56 then N'Trong 2 tháng'
	when time_delivered_customer >= 57 and time_delivered_customer <= 99999999 then N'Sau 2 tháng'
end
where time_delivered_customer is not null

alter table orders_full 
add time_estimated_day Nvarchar(20)
update orders_full
set time_estimated_day = case
	when time_estimated >= 0 and time_estimated <= 3 then N'Từ 1 đến 3 ngày'
	when time_estimated >= 4 and time_estimated <= 7 then N'Từ 4 đến 7 ngày'
	when time_estimated >= 8 and time_estimated <= 14 then N'Trong 2 tuần'
	when time_estimated >= 15 and time_estimated <= 21 then N'Trong 3 tuần'
	when time_estimated >= 22 and time_estimated <= 28 then N'Trong 1 tháng'
	when time_estimated >= 29 and time_estimated <= 35 then N'Trong 5 tuần'
	when time_estimated >= 36 and time_estimated <= 42 then N'Trong 6 tuần'
	when time_estimated >= 43 and time_estimated <= 49 then N'Trong 7 tuần'
	when time_estimated >= 50 and time_estimated <= 56 then N'Trong 2 tháng'
	when time_estimated >= 57 and time_estimated <= 99999999 then N'Sau 2 tháng'
end
where time_estimated is not null

alter table orders_full 
add time_all_day Nvarchar(20)
update orders_full
set time_all_day = case
	when time_all >= 0 and time_all <= 3 then N'Từ 1 đến 3 ngày'
	when time_all >= 4 and time_all <= 7 then N'Từ 4 đến 7 ngày'
	when time_all >= 8 and time_all <= 14 then N'Trong 2 tuần'
	when time_all >= 15 and time_all <= 21 then N'Trong 3 tuần'
	when time_all >= 22 and time_all <= 28 then N'Trong 1 tháng'
	when time_all >= 29 and time_all <= 35 then N'Trong 5 tuần'
	when time_all >= 36 and time_all <= 42 then N'Trong 6 tuần'
	when time_all >= 43 and time_all <= 49 then N'Trong 7 tuần'
	when time_all >= 50 and time_all <= 56 then N'Trong 2 tháng'
	when time_all >= 57 and time_all <= 99999999 then N'Sau 2 tháng'
end
where time_all is not null


alter table orders_full
add ship_late Nvarchar(10)
update orders_full
set ship_late = case
	when time_estimated - time_all < 0 then N'Trễ hẹn'
	when time_estimated - time_all >= 0 then N'Đúng hẹn'
end
where time_all is not null and time_estimated is not null

alter table orders_full
add time_ship_late Nvarchar(20)
update orders_full
set time_ship_late = case
	when time_estimated - time_all < 0 and time_estimated - time_all >= -3 then N'Trong 3 ngày'
	when time_estimated - time_all <= -4 and time_estimated - time_all >= -7 then N'Trong 1 tuần'
	when time_estimated - time_all <= -8 and time_estimated - time_all >= -14 then N'Trong 2 tuần'
	when time_estimated - time_all <= -15 and time_estimated - time_all >= -28 then N'Trong 1 tháng'
	when time_estimated - time_all <= -29 and time_estimated - time_all >= -999999999999 then N'Sau 1 tháng'
end
where time_all is not null and time_estimated is not null
