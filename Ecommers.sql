create table tags(
    Id int IDENTITY(1,1) primary key,
    tag_name VARCHAR(255),
    icon text,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
)

CREATE TABLE categories(
    Id int IDENTITY(1,1) PRIMARY KEY,
    parent_id int FOREIGN key references product_categories(id),
    category_name VARCHAR(255),
    category_description text,
    icon text,
    image_path text,
    active boolean,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
)

CREATE TABLE staff_accounts(
    Id int IDENTITY(1,1) PRIMARY KEY,
    first_name varchar(100),
    last_name VARCHAR(100),
    phone_number VARCHAR(100),
    email VARCHAR(255),
    password_hash text,
    active boolean,
    profile_img text,
    registered_at TIMESTAMP,
    update_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
)

CREATE TABLE notifications(
    Id int IDENTITY(1,1) PRIMARY KEY,
    account_id INT FOREIGN KEY REFERENCES staff_accounts(Id),
    title VARCHAR(100),
    content text,
    seen boolean,
    created_at TIMESTAMP,
    recelve_time TIMESTAMP,
    notification_expiry_date DATE
)

create TABLE variant_values(
    Id int IDENTITY(1,1) PRIMARY KEY,
    variant_id int FOREIGN KEY REFERENCES variants(Id),
    price NUMERIC,
    quantity INTEGER
)

CREATE TABLE product_tags(
    Id int IDENTITY(1,1) PRIMARY KEY,
    tag_id int FOREIGN KEY REFERENCES tags(Id),
    product_id int FOREIGN KEY REFERENCES products(Id),
)

CREATE TABLE product_categories(
    Id int IDENTITY(1,1) PRIMARY KEY,
    category_id int FOREIGN KEY references categories(Id),
    product_id int FOREIGN KEY REFERENCES products(Id)
)


CREATE TABLE staff_roles(
    Id int IDENTITY(1,1) PRIMARY KEY,
    staff_id int FOREIGN KEY REFERENCES staff_accounts(Id),
    role_id int FOREIGN KEY REFERENCES roles(Id)
)

CREATE TABLE sllideshows(
    Id int IDENTITY(1,1) PRIMARY KEY,
    destination_url text,
    image_url text,
    clicks SMALLINT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
)

CREATE TABLE variants(
    Id int IDENTITY(1,1) PRIMARY KEY,
    variant_attribute_value_id INT FOREIGN KEY REFERENCES variant_values(Id),
    product_id int FOREIGN KEY REFERENCES products(Id)
)

CREATE TABLE products(
    Id int IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(255),
    SKU VARCHAR(255),
    regular_price NUMERIC,
    discount_price NUMERIC,
    quantity INTEGER,
    short_description varchar(255),
    product_weight NUMERIC,
    product_note VARCHAR(255),
    published BIT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
)

CREATE TABLE roles(
    Id int IDENTITY(1,1) PRIMARY KEY,
    role_name VARCHAR(255),
    privleges text,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER 
)

CREATE TABLE product_shippings(
    Id int IDENTITY(1,1) PRIMARY KEY,
    shipping_id INTEGER,
    ship_charge NUMERIC,
    free BIT,
    estimated_days NUMERIC
)

CREATE TABLE variant_attribute_values(
    Id int IDENTITY(1,1) PRIMARY KEY,
    attribute_value_id INT FOREIGN KEY REFERENCES attribute_values(Id)
)

CREATE TABLE product_attributes(
    Id int IDENTITY(1,1) PRIMARY KEY,
    product_id int FOREIGN KEY REFERENCES products(Id),
    attribute_id int FOREIGN KEY REFERENCES attributes(Id)
)

CREATE TABLE galleries(
    Id int IDENTITY(1,1) PRIMARY KEY,
    product_id int FOREIGN KEY REFERENCES products(Id),
    image_path text,
    thumbnail BIT,
    display_order SMALLINT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
)

CREATE TABLE sells(
    Id int IDENTITY(1,1) PRIMARY KEY,
    product_id int FOREIGN KEY REFERENCES products(Id),
    price FLOAT,
    quantity SMALLINT
)

CREATE TABLE card_items(
    Id int IDENTITY(1,1) PRIMARY KEY,
    card_id int FOREIGN KEY REFERENCES cards(Id),
    product_id int FOREIGN KEY REFERENCES products(Id),
    quantity SMALLINT
)

CREATE TABLE shippings(
    Id int IDENTITY(1,1) PRIMARY KEY,
    name text,
    active BIT,
    icon_path text,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
)

CREATE TABLE attribute_values(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    attribute_id int FOREIGN KEY REFERENCES attributes(Id),
    attribute_value VARCHAR(255),
    color VARCHAR(255)
)

CREATE TABLE attributes(
    Id int IDENTITY(1,1) PRIMARY KEY,
    attribute_name VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
)

CREATE TABLE product_coupons(
    Id int IDENTITY(1,1) PRIMARY KEY,
    coupon_id int FOREIGN KEY REFERENCES coupons(Id),
    product_id INT FOREIGN KEY REFERENCES product(Id)
)


CREATE TABLE order_items(
    Id int IDENTITY(1,1) PRIMARY KEY,
    product_id INT FOREIGN KEY REFERENCES products(Id),
    order_id int FOREIGN KEY REFERENCES orders(Id),
    price NUMERIC,
    quantity INTEGER,
    shipping_id int FOREIGN KEY REFERENCES shippings(Id)
)

CREATE TABLE orders(
    Id int IDENTITY(1,1) PRIMARY KEY,
    coupon_Id int FOREIGN KEY REFERENCES coupons(Id),
    customer_id int FOREIGN KEY REFERENCES customers(Id),
    order_status_id INT FOREIGN KEY REFERENCES order_statuses(Id),
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    created_at TIMESTAMP
)

CREATE TABLE order_statuses(
    Id int IDENTITY(1,1) PRIMARY KEY,
    status_name VARCHAR(255),
    color VARCHAR(255),
    privacy VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    updated_by UNIQUEIDENTIFIER
)

CREATE TABLE cards(
    Id int IDENTITY(1,1) PRIMARY KEY,
    customer_id int FOREIGN KEY REFERENCES customers(Id)
)

CREATE TABLE customer_addresses(
    Id int IDENTITY(1,1) PRIMARY key,
    customer_id int FOREIGN KEY REFERENCES customers(Id),
    address_line1 text,
    address_line2 text,
    postal_code VARCHAR(255),
    country VARCHAR(255),
    city VARCHAR(255),
    phone_number VARCHAR(255)
)

CREATE TABLE coupons(
    Id int IDENTITY(1,1) PRIMARY KEY,
    code VARCHAR(255),
    coupon_description text,
    discount_value NUMERIC,
    discount_type VARCHAR(50),
    times_used INTEGER,
    max_usage integer,
    coupon_start_date TIMESTAMP,
    coupon_end_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by UNIQUEIDENTIFIER,
    created_by UNIQUEIDENTIFIER
)

CREATE TABLE customeres(
    Id int IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone_number VARCHAR(255),
    email text,
    password_hash text,
    active BIT,
    registered_at TIMESTAMP,
    created_at TIMESTAMP
)