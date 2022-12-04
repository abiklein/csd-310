-- drop database user if exists 
DROP USER IF EXISTS 'Blythe_Timmerson'@'localhost';
DROP USER IF EXISTS 'Jim_Ford'@'localhost';
DROP USER IF EXISTS 'John_MacNell'@'localhost';
DROP USER IF EXISTS 'D.B._Marland'@'localhost';
DROP USER IF EXISTS 'Anita_Gallegos'@'localhost';
DROP USER IF EXISTS 'Dimitrios_Stravopolous'@'localhost';
DROP USER IF EXISTS 'Mei_Wong'@'localhost';


-- create users and grant them all privileges to the movies database 
CREATE USER 'Blythe_Timmerson'@'localhost' IDENTIFIED WITH mysql_native_password BY '#####';
CREATE USER 'Jim_Ford'@'localhost' IDENTIFIED WITH mysql_native_password BY '#####';

CREATE USER 'John_MacNell'@'localhost' IDENTIFIED WITH mysql_native_password BY '#####';
CREATE USER 'D.B._Marland'@'localhost' IDENTIFIED WITH mysql_native_password BY '#####';
CREATE USER 'Anita_Gallegos'@'localhost' IDENTIFIED WITH mysql_native_password BY '#####';
CREATE USER 'Dimitrios_Stravopolous'@'localhost' IDENTIFIED WITH mysql_native_password BY '#####';
CREATE USER 'Mei_Wong'@'localhost' IDENTIFIED WITH mysql_native_password BY '#####';

-- grant all privileges to the CEOs on localhost 
GRANT ALL PRIVILEGES ON outlandadventures.* TO 'Blythe_Timmerson'@'localhost';
GRANT ALL PRIVILEGES ON outlandadventures.* TO 'Jim_Ford'@'localhost';

/* grant all privileges to other employees until 
we figure out how to give each of them permissions. */
GRANT ALL PRIVILEGES ON outlandadventures.* TO 'John_MacNell'@'localhost';
GRANT ALL PRIVILEGES ON outlandadventures.* TO 'D.B._Marland'@'localhost';
GRANT ALL PRIVILEGES ON outlandadventures.* TO 'Anita_Gallegos'@'localhost';
GRANT ALL PRIVILEGES ON outlandadventures.* TO 'Dimitrios_Stravopolous'@'localhost';
GRANT ALL PRIVILEGES ON outlandadventures.* TO 'Mei_Wong'@'localhost';



-- drop tables if they are present
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS supplier;
/*DROP TABLE IF EXISTS customerOrder;
DROP TABLE IF EXISTS customerBooking;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS supplyOrder;
DROP TABLE IF EXISTS trip_location;
DROP TABLE IF EXISTS visa_requirements;
DROP TABLE IF EXISTS inoculations;
DROP TABLE IF EXISTS airfare;*/


-- create the department table 
CREATE TABLE department (
    department_id     INT             NOT NULL        AUTO_INCREMENT,
    department_name   VARCHAR(75)     NOT NULL,
     
  --  PRIMARY KEY(department_id)
); 

-- create the employee table 
CREATE TABLE employee (
    employee_id     	  INT             NOT NULL        AUTO_INCREMENT,
    employee_first_name   VARCHAR(75)     NOT NULL,
    employee_last_name	  VARCHAR(75)	  NOT NULL,
    employee_address	  VARCHAR(75)	  NOT NULL,
    employee_phone		  VARCHAR(75)	  NOT NULL,
    employee_email		  VARCHAR(75)	  NOT NULL,
    department_id		  --INT             NOT NULL,  
    
    PRIMARY KEY(employee_id),
   /* CONSTRAINT fk_department
    FOREIGN KEY(department_id)
        REFERENCES department(department_id),*/
);

-- create the customer table 
CREATE TABLE customer (
    customer_id     	  INT             NOT NULL        AUTO_INCREMENT,
    customer_first_name   VARCHAR(75)     NOT NULL,
    customer_last_name    VARCHAR(75)     NOT NULL,
    customer_phone		  VARCHAR(75)     NOT NULL,
    customer_email		  VARCHAR(75)     NOT NULL,
    customer_address	  VARCHAR(75)     NOT NULL,
     
    PRIMARY KEY(customer_id)
); 

-- create customer booking table
CREATE TABLE customerBooking (
	customer_booking_id	 INT             NOT NULL        AUTO_INCREMENT,
	customer_id			 INT			 NOT NULL,
	trip_location_id     INT             NOT NULL,
    -- INT or CARCHAR?
    -- Dates as: 10/26 - 11/6 or October - November?
    customer_trip_date   VARCHAR(75)    NOT NULL,
    airfare_id		     INT     		NOT NULL,
    employee_id	         INT     		NOT NULL,
    
    PRIMARY KEY(customer_booking_id),

    /* CONSTRAINT fk_customer
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),*/
    
    CONSTRAINT fk_trip_location
    FOREIGN KEY(trip_location_id)
    	REFERENCES trip_location(trip_location_id),
    	
    CONSTRAINT fk_airfare
    FOREIGN KEY(airfare_id)
    	REFERENCES airfare(airfare_id),
    	
    CONSTRAINT fk_employee
    FOREIGN KEY(employee_id)
    	REFERENCES employee(employee_id)
    	
);

-- create equipment table
CREATE TABLE Equipment (
	equipment_id	 		 INT             NOT NULL        AUTO_INCREMENT,
	equipment_name			 VARCHAR(75)     NOT NULL,
	equipment_rent_price     INT             NOT NULL,
    equipment_buy_price   	 INT		     NOT NULL,
    equipment_quantity	     INT     		 NOT NULL,
 -- employee_id	         	 INT     		 NOT NULL,	
    
    PRIMARY KEY(equipment_id),
    
    /*CONSTRAINT fk_employee_id    in the ERD WE DO NOT HAVE FK IN equipment??
    FOREIGN KEY(employee_id)
    	REFERENCES employee_id(employee_id)*/
);

-- create the supplier table 
CREATE TABLE supplier (
    supplier_id     	INT             NOT NULL        AUTO_INCREMENT,
    supplier_name   	VARCHAR(75)     NOT NULL,
    supplier_address    VARCHAR(75)     NOT NULL,
    supplier_phone   	VARCHAR(75)     NOT NULL,
    supplier_email   	VARCHAR(75)     NOT NULL,
    supplier_rep_name	VARCHAR(75)     NOT NULL,
     
    PRIMARY KEY(supplier_id)
); 

-- create SupplyOrder table
CREATE TABLE supplyOrder (
	supply_order_id	 		 INT             NOT NULL        AUTO_INCREMENT,
	equipment_id			 VARCHAR(75)     NOT NULL,
	equipment_unit_price     INT             NOT NULL,
    equipment_quantity   	 INT		     NOT NULL,
    supply_order_date	     INT     		 NOT NULL,
    supplier_id	         	 INT     		 NOT NULL,	
    
    --PRIMARY KEY(supply_order_id),
    
    CONSTRAINT fk_supplier
    FOREIGN KEY(supplier_id)
    	REFERENCES supplier(supplier_id)
);

-- create CustomerOrder table
CREATE TABLE customerOrder (
	customer_order_id	 	 		INT             NOT NULL        AUTO_INCREMENT,
	customer_id				 		INT		     	NOT NULL,
	equipment_id     		 		INT             NOT NULL,
    customer_equipment_quantity   	INT		        NOT NULL,
    customer_order_date	     		VARCHAR(75)     NOT NULL,
    rented_or_bought	         	VARCHAR(75)     NOT NULL,	
    
    --PRIMARY KEY(customer_order_id),
    
    CONSTRAINT fk_customer
    FOREIGN KEY(customer_id)
    	REFERENCES customer(customer_id)
    	
    /*CONSTRAINT fk_equipment
    FOREIGN KEY(equipment_id)
    	REFERENCES equipment(equipment_id)*/
);

-- create the trip_location table 
CREATE TABLE trip_location (
    trip_location_id     INT             NOT NULL        AUTO_INCREMENT,
    trip_location_name   VARCHAR(75)     NOT NULL,
     
    PRIMARY KEY(trip_location_id)
); 


-- create the visa_requirements table 
CREATE TABLE visa_requirements (
    visa_requirements_id     INT             NOT NULL        AUTO_INCREMENT,
    visa_requirements_name   VARCHAR(75)     NOT NULL,
    trip_location_id		 INT     NOT NULL,
     
    PRIMARY KEY(visa_requirements_id),
    
    CONSTRAINT fk_trip_location
    FOREIGN KEY(trip_location_id)
    	REFERENCES trip_location(trip_location_id)
); 

-- create the inoculations table 
CREATE TABLE inoculations (
    inoculations_id     INT             NOT NULL        AUTO_INCREMENT,
    inoculations_name   VARCHAR(75)     NOT NULL,
    trip_location_id	INT             NOT NULL,
     
    PRIMARY KEY(inoculations_id),
    
    CONSTRAINT fk_trip_location
    FOREIGN KEY(trip_location_id)
    	REFERENCES trip_location(trip_location_id)
); 

-- create the airfare table 
CREATE TABLE airfare (
    airfare_id          INT             NOT NULL        AUTO_INCREMENT,
  /*  airfare_price	    INT     NOT NULL,
    season              VARCHAR(75)     NOT NULL,
    trip_location_id	INT     NOT NULL,*/-- According to the ERD
     
    PRIMARY KEY(airfare_id),
    
    CONSTRAINT fk_trip_location
    FOREIGN KEY(trip_location_id)
    	REFERENCES trip_location(trip_location_id)
); 

-- insert to department table
INSERT INTO department(department_name) VALUES('CEO');
INSERT INTO department(department_name) VALUES('Planning');
INSERT INTO department(department_name) VALUES('Marketing');
INSERT INTO department(department_name) VALUES('Supplier');
INSERT INTO department(department_name) VALUES('IT');

--insert into employee table
INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('Blythe', 'Timmerson', '2333 9th Street Moline', '309 429 0642', 'BlytheTimmerson@gmail.com', (SELECT department_id FROM department WHERE department_name = 'CEO'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('Jim', 'Ford', '4252 11th Street Moline', '309 463 0609', 'JimFord@gmail.com', (SELECT department_id FROM department WHERE department_name = 'CEO'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('John', 'MacNell', '5620 6th Street Moline', '309 565 0609', 'JohnMacNell@gmail.com', (SELECT department_id FROM department WHERE department_name = 'Planning'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('D.B.', 'Marland', '4020 6th Street Moline', '309 222 1709', 'dbMarlandl@gmail.com', (SELECT department_id FROM department WHERE department_name = 'Planning'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('Anita', 'Gallegos', '5110 6th Street Moline', '309 429 1709', 'anitaGallegos@gmail.com', (SELECT department_id FROM department WHERE department_name = 'Marketing'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('Dimitrios', 'Stravopolous', '3695 3rd Street Moline', '309 632 1709', 'dimitriosStravopolous@gmail.com', (SELECT department_id FROM department WHERE department_name = 'Supplier'));

INSERT INTO employee(employee_first_name, employee_last_name,employee_address,employee_phone,employee_email,department_id) 
VALUES('Mei', 'Wong', '1110 17th Avenue Moline', '309 632 0001', 'MeiWong@gmail.com', (SELECT department_id FROM department WHERE department_name = 'IT'));
   
--Insert into customer table
INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('James', 'Smith','309 632 0832', 'JamesSmith@yahoo.com', '2221 22th Avenue Davenport');

INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('Michael', 'Garcia','309 492 4132', 'MichaelGarcia@yahoo.com', '2005 17th Avenue Moline');

INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('David', 'Martina ','309 501 4452', 'DavidMartina@gmail.com', '1111 17th Avenue Missourie');
 
INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('Maria', 'Martinez','309 305 1142', 'MariaMartinez@gmail.com', '5523 8th Avenue Texas');
 
INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('James', 'Johnson','855 606 3056', 'Jamesjohnson@gmail.com', '2031 8th Street Moline');

INSERT INTO customer(customer_first_name, customer_last_name, customer_phone,customer_email, customer_address)
VALUES('Bob', 'Workman','855 633 3456', 'Bobworkman@gmail.com', '1129 15th Street Moline');
 
--insert into supplier table 
INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('Active Enddeavors', '3950 Elmore Avenue, Davenport, IA 52807', '563 441 9488', 'Activeenddeavors@gmail.com','Roberta');

INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('Field & Stream', '5511 Elmore Avenue Ste B, Davenport, IA 52807', '563 355 7042', 'Field@Stream.com','Smith' );

INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('REI','7483 W Towne Way, Madison, WI 53719', '608 833 6680', 'rei@capimg.com', 'Roberta');

INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('Jacks Camp','809 N 25th Rd, Oglesby, IL 61348', '815 667 4506', 'Jackscamp@gmail.com', 'Hernandez');

INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('Dark Night','11618 6th St, Milan, IL 61264', '309 781 8421', 'Darknight@gmail.com', 'Hartman');

INSERT INTO supplier(supplier_name, supplier_address, supplier_phone, supplier_email, supplier_rep_name)
VALUES('Cabela,s', ' 5225 Prairie Stone Pkwy, Hoffman Estates, IL 60192','847 645 0400', 'Cabela@gmail.com','Winner');