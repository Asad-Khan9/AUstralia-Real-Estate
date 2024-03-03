create table "AUSTRALIA_PROPERTIES"."PUBLIC"."Australia_dataset"(
    rea_property_id INT,
    property_type VARCHAR(50),
    state VARCHAR(50),
    postcode VARCHAR(10),
    year_built INT,
    last_sold_date DATE,
    last_sold_agency VARCHAR(100),
    bedrooms INT,
    bathrooms INT,
    findAgentsURI VARCHAR(255),
    -- floor_area FLOAT,
    fullSuburb VARCHAR(100),
    house_type VARCHAR(50),
    lat FLOAT,
    lon FLOAT,
    photo_count INT,
    images_urls TEXT,
    street_address VARCHAR(255),
    suburb VARCHAR(100),
    url VARCHAR(255),
    sales_history TEXT,
    -- land_size FLOAT,
    land_size_num FLOAT,
    land_size_unit VARCHAR(20),
    floor_area_num FLOAT,
    -- avm_estimate_lastUpdated DATE,
    estimated_price FLOAT,
    estimated_price_confidence FLOAT,
    estimated_value FLOAT,
    estimated_value_high FLOAT,
    estimated_value_low FLOAT,
    offMarket BOOLEAN,
    parking INT,
    listing_type VARCHAR(50),
    availability VARCHAR(50),
    rent_price FLOAT,
    rent_bond FLOAT
)
create or replace file format "AUSTRALIA_PROPERTIES"."PUBLIC"."Australia_dataset_ff2"
    type = 'csv'
    compression = 'none'
    field_delimiter = ','
    field_optionally_enclosed_by = '\042'
    skip_header = 1;


truncate table "AUSTRALIA_PROPERTIES"."PUBLIC"."Australia_dataset";


create or replace file format "AUSTRALIA_PROPERTIES"."PUBLIC"."Australia_dataset_ff2"
type = 'csv'
field_optionally_enclosed_by = '"'
skip_header = 1
null_if = ('null', 'NULL', 'Unavailable', '', 'undefined - undefined')
date_format = 'YYYY-MM-DD"T"HH24:MI:SS.FF3"Z"'
timestamp_format = 'DD Month, YYYY';
