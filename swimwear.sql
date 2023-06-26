create temp table customer2 as
SELECT ses.session_id as sessionid1, ses.session_date, cus.customer_id, cus.start_year, cus.birth_year, cus.last_order_date, cus.sex
FROM public.session ses
LEFT JOIN public.customer cus ON ses.customer_id=cus.customer_id
order by sessionid1;

/* we use min channel because one session can have multiple channels, we will be using the one where the session started*/
create temp table customer_orders as
select
session_id as sessionid2,
sum (sales_amount) as sales€, sum (items) as salesN,
min (channel) as channel2,
sum (delivered) as delivereditems, sum (returned) as returneditems from public.order
group by session_id;

-- I dont need this table
create temp table ProductViews as SELECT session_id as sessionid3, COUNT(*) AS ProductViews FROM public.articleevents WHERE article_event_type='10' GROUP BY session_id
order by session_id;

/* in this one Productsales returns null when sales 0*/ create temp table ProductSales as
SELECT session_id as sessionid4,
count (*) as ProductSales
from public.articleevents where article_event_type='40' group by session_id
order by session_id;

/*In this one Sales returns 0 when no sales*/
create temp table salesandviews as
SELECT session_id as sessionid5,
COUNT(CASE WHEN article_event_type='40' THEN 1 ELSE NULL END) AS Sales, COUNT(CASE WHEN
article_event_type='10' THEN 1 ELSE NULL END) AS ProductViews FROM public.articleevents
GROUP BY session_id
 ORDER BY session_id;
create temp table conversionrate as
SELECT session_id as sessionid6,
COUNT(CASE WHEN article_event_type='40' THEN 1 ELSE NULL END) AS Sales, COUNT(CASE WHEN article_event_type='10' THEN 1 ELSE NULL END) AS ProductViews,
CAST(100.0 * COUNT(CASE WHEN article_event_type='40' THEN 1 ELSE NULL END) / nullif
(COUNT(CASE WHEN article_event_type='10' THEN 1 ELSE NULL END),0) AS DECIMAL(6,2)) AS
Conversion
FROM public.articleevents
GROUP BY session_id
ORDER BY Conversion;
create temp table PercReturned as
SELECT session_id as sessionid7,
COUNT(CASE WHEN returned = 1 THEN 1 ELSE NULL END) AS Returned, COUNT(CASE WHEN delivered = 1 THEN 1 ELSE NULL END) AS Delivered, CAST(100.0 * COUNT(CASE WHEN returned = 1 THEN 1 ELSE NULL END) / nullif (COUNT(CASE WHEN
delivered = 1 THEN 1 ELSE NULL END),0) AS DECIMAL(5,2)) AS PercReturned FROM public.order
GROUP BY session_id
ORDER BY session_id;
create temp table weekday1 as
select extract (isodow from session.session_date) as dayoftheweek, session_id as sessionid8
from public.session
group by session_id;

/*two options for conversion rate 1/0 or sales/productview, also do we need to add group by sessionid if all
tables have been already group by it */
create temp table finaltable as
select sessionid1 , session_date, start_year, birth_year,dayoftheweek ,last_order_date, sex, Returned, Delivered, PercReturned, conversionrate.Sales, conversionrate.ProductViews, Conversion, delivereditems, returneditems, salesN, sales€ from customer2
left join customer_orders on sessionid1=sessionid2 left join conversionrate on sessionid1=sessionid6 left join PercReturned on sessionid1=sessionid7 left join weekday1 on sessionid1=sessionid8;
select count (*) from finaltable

/*126375*/
select sum (productviews) as sumviews, sum (sales) as sumsales

from finaltable
/* 561349 and 35251 respectively therefore overall conversion rate is 6.28%*/