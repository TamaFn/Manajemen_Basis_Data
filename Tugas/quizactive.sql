
Select * from customers

INSERT INTO customers VALUES
(7,'Omar',28, 'Mumbai',3000.00)

UPDATE customers
SET Salary = 
CASE 
	WHEN salary <= 3000 THEN 3000
	ELSE salary
	END;
	
CREATE VIEW Highest_Salary_Max_30 AS
SELECT name,salary
FROM customers
Where salary = (
	SELECT max(salary)
	FROM customers
)

CREATE OR REPLACE VIEW Salary_3000 AS
SELECT name,salary
FROM Customers
WHERE Salary > 3000

SELECT * FROM Salary_3000
SELECT * FROM Highest_Salary_Max_30



CREATE OR REPLACE PROCEDURE show_customers()
AS $$
BEGIN
    SELECT * FROM customers;
END;
$$ LANGUAGE plpgsql;


call show_customers();

select * from accounts

-- PROCEDURE
create or replace procedure transfer(
   sender int,
   receiver int, 
   amount dec
)
language plpgsql    
as $$
begin
    -- subtracting the amount from the sender's account 
    update accounts 
    set balance = balance - amount 
    where id = sender;

    -- adding the amount to the receiver's account
    update accounts 
    set balance = balance + amount 
    where id = receiver;

    commit;
end;$$

call transfer(1,2,5000)

select * from accounts


-- Function 

select * from customers

CREATE OR REPLACE FUNCTION get_person_salary_3000(first_id integer, end_id integer)
returns integer
AS $$
declare person_count integer;
begin 
	select count(*)
	into person_count
	from customers
	where id between first_id and end_id and salary = 3000;
	return person_count;
end;
$$ LANGUAGE plpgsql;


SELECT get_person_salary_3000(1,7);


CREATE OR REPLACE FUNCTION get_person_name_3000(f_id integer, l_id integer)
returns table (Nama_Orang varchar(100))
AS $$
begin 
	return query
    Select name
    From customers
    where id between f_id and l_id and salary = 3000
    order by id ASC;
end;
$$ LANGUAGE plpgsql;

Select get_person_name_3000(1,7)


-- Trigger

select * from customers

Create or replace function salary_above_2000()
returns trigger 
language plpgsql
as $$
begin 
	IF NEW.salary < 2000 THEN NEW.salary = 2000;
	ELSIF NEW.salary > 8500 THEN NEW.salary = 8500;
	END IF;
	RETURN NEW;
END $$;

create or replace trigger salary_fixed
before insert or update on customers
for each row
execute function salary_above_2000()

 
DELETE FROM customers WHERE ID IN (8, 9);

INSERT INTO customers VALUES
(8,'Khalid',24, 'Bangladesh',9000),
(9,'Lathfi',26, 'Mumbai',1500)

select * from customers

========================================

create table customer_log(
	id_log INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Date_change DATE NOT NULL,
	Previous_salary DECIMAL(6,2) NOT NULL,
	Next_salary DECIMAL(6,2) NOT NULL
);


Create or replace function salary_change()
returns trigger 
language plpgsql
as $$
begin 
	IF OLD.salary != NEW.salary THEN
	INSERT INTO customer_log(Date_change,Previous_salary,Next_salary)
	VALUES (NOW(),OLD.salary,NEW.salary);
	END IF;
	RETURN NEW;
END $$;

create or replace trigger salary_fixed2
after update on customers
for each row
execute function salary_change()

UPDATE Customers SET salary = 6000 where id = 1

select * from customers




