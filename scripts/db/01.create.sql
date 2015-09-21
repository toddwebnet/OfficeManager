create table zip_info (
  zip varchar(16),
  state varchar(2),
  lat varchar(16),
  lon varchar(16),
  city varchar(64) character set utf8,
  state_name varchar(32) character set utf8,
  primary key (zip)
);

create table state
(
  state varchar(2),
  state_name varchar(32) character set utf8,
  primary key (state)
);
create table email
(
  email_id int AUTO_INCREMENT,
  email varchar(255),
  primary key (email_id)
);

create table phone
(
  phone_id int AUTO_INCREMENT,
  phone_type ENUM('home', 'work', 'mobile', 'fax', 'other'),
  number varchar(16),
  ext varchar(16),
  primary key (phone_id)
);

create table address
(
  address_id int AUTO_INCREMENT,
  address_type enum ('home', 'work', 'other'),
  address1 varchar(64) character set utf8,
  address2 varchar(64) character set utf8,
  city varchar(64) character set utf8,
  state varchar(2),
  zip varchar(16),
  primary key (address_id)
);

create table person
(
  person_id int auto_increment,
  first_name varchar(32) character set utf8,
  last_name varchar(32) character set utf8,
  gender ENUM('male', 'female'),
  dob DATE,
  PRIMARY KEY (person_id)
);



create table company
(
  company_id int AUTO_INCREMENT,
  company_name varchar(64),
  is_provider TINYINT DEFAULT 0,
  primary key (company_id)
);

create table company_address
(
  company_id int,
  address_id int,
  PRIMARY KEY (company_id, address_id)
);
ALTER TABLE company_address
ADD CONSTRAINT fk_company_address_company
FOREIGN KEY (company_id)
REFERENCES company(company_id);


ALTER TABLE company_address
ADD CONSTRAINT fk_company_address_address
FOREIGN KEY (address_id)
REFERENCES address(address_id);

create table user
(
  user_id int AUTO_INCREMENT,
  user_name varchar(32) CHARACTER SET utf8,
  company_id int,
  person_id int,
  email_id int,
  primary key(user_id)
);
ALTER TABLE user
ADD CONSTRAINT fk_users_company
FOREIGN KEY (company_id)
REFERENCES company(company_id);

ALTER TABLE user
ADD CONSTRAINT fk_users_person
FOREIGN KEY (person_id)
REFERENCES person(person_id);

ALTER TABLE user
ADD CONSTRAINT fk_users_email
FOREIGN KEY (email_id)
REFERENCES email(email_id);

create table user_credentials
(
  user_id int,
  password varchar(64),
  reset_flag_date datetime,
  PRIMARY KEY (user_id)
);

ALTER TABLE user_credentials
ADD CONSTRAINT fk_user_credentials_user
FOREIGN KEY (user_id)
REFERENCES user(user_id);


create table service
(
  service_id int AUTO_INCREMENT,
  service varchar(32),
  service_descr text,
  primary key (service_id)
);

create table service_type
(
  service_type_id int AUTO_INCREMENT,
  service_type varchar(32),
  active_ind TINYINT DEFAULT 1,
  primary key (service_type_id)
);

create table service_type_service
(
  service_type_id int not null,
  service_id int not null,
  PRIMARY KEY (service_type_id, service_id)
);

ALTER TABLE service_type_service
ADD CONSTRAINT fk_service_type_service_service
FOREIGN KEY (service_id)
REFERENCES service(service_id);

ALTER TABLE service_type_service
ADD CONSTRAINT fk_service_type_service_service_type
FOREIGN KEY (service_type_id)
REFERENCES service_type(service_type_id);

create table service_provider
(
  service_provider_id int AUTO_INCREMENT,
  person_id int,
  PRIMARY KEY (service_provider_id)
);

ALTER TABLE service_provider
ADD CONSTRAINT fk_service_provider_person
FOREIGN KEY (person_id)
REFERENCES person(person_id);

create table service_provider_service_type
(
  service_provider_id int not null,
  service_type_id int not null,
  PRIMARY KEY (service_provider_id, service_type_id)
);

ALTER TABLE service_provider_service_type
ADD CONSTRAINT fk_service_provider_service_type_service_provider
FOREIGN KEY (service_provider_id)
REFERENCES service_provider(service_provider_id);

ALTER TABLE service_provider_service_type
ADD CONSTRAINT fk_service_provider_service_type_service_type
FOREIGN KEY (service_type_id)
REFERENCES service_type(service_type_id);


create table service_company
(
  service_id int,
  company_id int,
  price_per_unit DECIMAL(8,2) not null,
  primary key (service_id, company_id)
);

ALTER TABLE service_company
ADD CONSTRAINT fk_service_company_service
FOREIGN KEY (service_id)
REFERENCES service(service_id);

ALTER TABLE service_company
ADD CONSTRAINT fk_service_company_company
FOREIGN KEY (company_id)
REFERENCES company(company_id);