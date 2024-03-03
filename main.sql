SELECT
  *
FROM
  "Australia_dataset"
LIMIT
  90;

select * from "Australia_dataset";

-- modefying and deleting null columns
select * from "Australia_dataset" where estimated_price is not null;
alter table "Australia_dataset" drop column estimated_price;

select * from "Australia_dataset" where estimated_price_confidence is not null;
alter table "Australia_dataset" drop column estimated_price_confidence;

select * from "Australia_dataset" where listing_type is not null;
alter table "Australia_dataset" drop column listing_type;

select * from "Australia_dataset" where estimated_value is not null;
alter table "Australia_dataset" drop column estimated_value;

select * from "Australia_dataset" where estimated_value_high is not null;
alter table "Australia_dataset" drop column estimated_value_high;

select * from "Australia_dataset" where estimated_value_low is not null;
alter table "Australia_dataset" drop column estimated_value_low;

select * from "Australia_dataset" where availability is not null;
alter table "Australia_dataset" drop column availability;

select * from "Australia_dataset" where rent_price is not null;
alter table "Australia_dataset" drop column rent_price;


select * from "Australia_dataset" where rent_bond is not null;
alter table "Australia_dataset" drop column rent_bond;



-- adding last_sold at column from values given in sales_history
select sales_history:price from "Australia_dataset" limit 10;

alter table "Australia_dataset" add column last_sold_at varchar(255); 

update "Australia_dataset"
set last_sold_at = (select substring(sales_history, position('"price":"' in sales_history) + 9, 
    position('"' in substring(sales_history, position('"price":"' in sales_history) + 9)) - 1)::varchar(255))
where sales_history is not null;


-- adding last_sold_date column from values given in sales_history
select substring(
    sales_history, position('"date":"' in sales_history) + 8, position('00:' in substring(sales_history, position('"date":"' in sales_history) + 8)) - 1) as last_sold_date
from "Australia_dataset";

alter table "Australia_dataset"
drop column last_sold_date;

alter table "Australia_dataset"
add column last_sold_date date;

update "Australia_dataset"
set last_sold_date = to_date(substring(sales_history, position('"date":"'in sales_history) + 8, position('00:' in substring(sales_history, position('"date":"' in sales_history) + 8)) - 1),'DY MON DD YYYY')
where sales_history is not null;


--adding age_of_property column using year_built column
alter table "Australia_dataset"
add column age_of_property int;

update "Australia_dataset"
set age_of_property = extract(year from current_date) - year_built
where year_built is not null;

--adding last_sold_date column from the json value of sales_history
select substring(
    sales_history, position('"date":"' in sales_history) + 8, position('00:' in substring(sales_history, position('"date":"' in sales_history) + 8)) - 1) as last_sold_date
from "Australia_dataset";

--deleting unwanted columns after temporary transformations
alter table "Australia_dataset" drop column without_dollor;
alter table "Australia_dataset" add column without_dollor varchar(15);

update "Australia_dataset"
set without_dollor = replace(last_sold_at, '$');

alter table "Australia_dataset" add column without_comma int;

update "Australia_dataset"
set without_comma = replace(without_dollor, ',');

alter table "Australia_dataset"
rename column without_comma to price;

alter table "Australia_dataset" drop column without_dollar;

alter table "Australia_dataset"
drop column without_dollar;

--adding price_per_sqm column by deviding the price column with floor_are_num
alter table "Australia_dataset"
add column price_per_sqm decimal(10,2);

update "Australia_dataset"
set price_per_sqm = (
                    case when floor_area_num is not null and price is not null then cast (price/floor_area_num as decimal(10,2)
                    ) else null
                    end);

--distinct states in australia
select distinct fullsuburb from "Australia_dataset";

select * from "Australia_dataset"
limit 10;
