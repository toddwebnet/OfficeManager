insert into company (company_id, company_name, is_provider)
  values (1, 'T-Best Office Service', 1);

insert into address(address_id, address1, address2, city, state, zip)
  values (1, '1313 Mockingbird Lane', '', 'Houston', 'TX', '77080');

insert into company_address (company_id, address_id) values (1,1);

insert into person (person_id, first_name, last_name, gender, dob)
  values (1, 'Admin', 'User', 'male', '1955-11-05');

insert into email (email_id, email) values (1, 'hotmale@gmail.com');

insert into user(user_id, user_name, company_id, person_id, email_id) values
  (1, 'admin', 1, 1, 1);

insert into user_credentials (user_id, password, reset_flag_date)
  values (1, '$2y$12$BumK3TG9bruNAjjkTcJ4mevo7riPL1XMPLcE9.a.FDokXfeeri0l.', '1955-11-05');


