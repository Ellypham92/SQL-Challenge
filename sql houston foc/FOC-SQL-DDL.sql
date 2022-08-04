
/*------------------------------
FOC Database Management
*/--

CREATE SCHEMA foc;
USE foc;
SET FOREIGN_KEY_CHECKS=0; -- to disable them
SET FOREIGN_KEY_CHECKS=1; -- to re-enable them

DROP TABLE service;
DROP TABLE service_client;
DROP TABLE client;
DROP TABLE client_case;
DROP TABLE funding_department; 
DROP TABLE client; 

-- DDL for STAFF relation 

DROP TABLE Staff; 

CREATE TABLE STAFF (
  staffID INT AUTO_INCREMENT PRIMARY KEY,
  fName VARCHAR(45) NOT NULL,
  lName VARCHAR(45) NOT NULL,
  DOB DATE,
  phone VARCHAR(45) UNIQUE NOT NULL,
  email VARCHAR(45),
  position VARCHAR(45)
);

INSERT INTO STAFF(fName, lName, DOB, phone, email, position) VALUES
('Pama', 'La', '1988-01-01','832-445-5567','pama@foc.org','Director'),
('Cin', 'Dy', '1983-07-01','832-445-5564','cin@foc.org','Data Specialist'),
('He', 'Len', '1968-11-01','832-445-5569','he@foc.org','Program Analyst'),
('Rash', 'Mi', '1988-01-01','832-445-5367','rash@foc.org','HR Manager'),
('Siv', 'Ian', '1998-01-11','832-445-5467','Siv@foc.org','Case Manager'),
('Val', 'Rie', '1983-12-01','832-445-5264','val@foc.org','Program Coordinator'),
('Kev', 'In', '1968-01-12','832-445-3367','kev@foc.org','Case Manager'),
('Derek', 'Ho', '1993-01-21','832-445-1267','derek@foc.org','FOC Program Manager'),
('Lulu', 'Lu', '1983-11-21','832-445-6267','lulu@foc.org','Program Coordinator'),
('Tao', 'Yue', '1958-01-21','832-445-1260','tao@foc.org','CEAP Program Manager');


-- DDL for DEPARTMENT relation 

DROP TABLE department; 

CREATE TABLE DEPARTMENT (
  departmentID INT AUTO_INCREMENT PRIMARY KEY,
  departmentName VARCHAR(45) NOT NULL
);

INSERT INTO DEPARTMENT(departmentName) VALUES
('Financial Opportunity'),
('Public Benefits'),
('Human Resource');

-- DDL for STAFF_DEPARTMENT relation 

DROP TABLE STAFF_DEPARTMENT;

CREATE TABLE STAFF_DEPARTMENT (
  staffID INT NOT NULL,
  departmentID INT NOT NULL,
  FOREIGN KEY (staffID) 
        REFERENCES STAFF(staffID),
  FOREIGN KEY (departmentID) 
		REFERENCES DEPARTMENT(departmentID)
);

INSERT INTO STAFF_DEPARTMENT(staffID, departmentID) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 3),
(5, 2),
(6, 1),
(7, 2),
(8, 1),
(9, 1),
(10, 2);

-- DDL for FUNDING relation 
DROP TABLE FUNDING;

CREATE TABLE FUNDING (
  fundingID INT AUTO_INCREMENT PRIMARY KEY,
  start_date DATE NOT NULL,
  end_date DATE,
  amount DECIMAL(10,2),
  funderID INT,
  FOREIGN KEY (funderID) 
        REFERENCES FUNDER(funderID)
);

INSERT INTO FUNDING(start_date, end_date, amount, funderID) VALUES
('1998-01-03', '2022-04-18', '923456.78', '1'),
('2008-05-03', '2021-04-18', '1923456.78', '1'),
('2018-11-03', NULL, '11923456.78', '3'),
('2020-01-23', NULL, '2923456.78', '4'),
('1998-01-13', '2020-01-03', '3923456.78', '5'),
('2015-01-10', NULL, '21923456.78', '2'),
('2021-01-06', NULL, '3923456.78', '3');

-- DDL for FUNDING_DEPARTMENT relation
DROP TABLE FUNDING_DEPARMENT;
CREATE TABLE FUNDING_DEPARTMENT (
  fundingID INT NOT NULL,
  departmentID INT NOT NULL,
  FOREIGN KEY (fundingID) 
        REFERENCES FUNDING(fundingID),
  FOREIGN KEY (departmentID) 
		REFERENCES DEPARTMENT(departmentID)
);

INSERT INTO FUNDING_DEPARTMENT(fundingID, departmentID) VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,2),
(6,2),
(7,2);

-- DDL for FUNDER relation 
DROP TABLE FUNDER;

CREATE TABLE FUNDER (
  funderID INT AUTO_INCREMENT PRIMARY KEY,
  funderName VARCHAR(45) NOT NULL,
  status VARCHAR(10)
);

INSERT INTO FUNDER (funderName, status) VALUES
('United Sky', 'Active'),
('Harris Love', 'Active'),
('Baker Cake', 'Active'),
('Napka', 'Active'),
('Oil Llc', 'Inactive');

-- DDL for FUNDING relation 
DROP TABLE FUNDING;

CREATE TABLE FUNDING (
  fundingID INT AUTO_INCREMENT PRIMARY KEY,
  start_date DATE NOT NULL,
  end_date DATE,
  amount DECIMAL(10,2),
  funderID INT,
  FOREIGN KEY (funderID) 
        REFERENCES FUNDER(funderID)
);

INSERT INTO FUNDING(start_date, end_date, amount, funderID) VALUES
('1998-01-03', '2022-04-18', '923456.78', '1'),
('2008-05-03', '2021-04-18', '1923456.78', '1'),
('2018-11-03', NULL, '11923456.78', '3'),
('2020-01-23', NULL, '2923456.78', '4'),
('1998-01-13', '2020-01-03', '3923456.78', '5'),
('2015-01-10', NULL, '21923456.78', '2'),
('2021-01-06', NULL, '3923456.78', '3');

-- DDL for SERVICE relation 
DROP TABLE SERVICE;

CREATE TABLE SERVICE (
  serviceID INT PRIMARY KEY,
  serviceType VARCHAR(45) NOT NULL,
  departmentID INT,
  FOREIGN KEY (departmentID) 
        REFERENCES DEPARTMENT(departmentID)
);

INSERT INTO SERVICE (serviceID, serviceType, departmentID) VALUES
(1001,'Utility', 2),
(1002,'Food', 2),
(1003,'Rent', 2),
(1004,'Job', 1),
(1005,'Resume', 1),
(1006,'Training', 1),
(1007,'Information', 1),
(1008,'Education', 1),
(1009,'Credit', 1),
(1010,'Emergency Assistance', 2);

-- DDL for SERVICE_CLIENT relation 
DROP TABLE SERVICE_CLIENT;

CREATE TABLE SERVICE_CLIENT(
   serviceID INT NOT NULL,
   clientID INT NOT NULL,
   FOREIGN KEY (clientID) 
        REFERENCES CLIENT(clientID),
   FOREIGN KEY (serviceID) 
	    REFERENCES SERVICE(serviceID)
);

INSERT INTO SERVICE_CLIENT(serviceID, clientID) VALUES
(1001, 102),
(1002, 102),
(1003, 102),
(1009, 100),
(1010, 101),
(1001, 102),
(1006, 103),
(1007, 102),
(1005, 106),
(1010, 102),
(1007, 107),
(1004, 109),
(1004, 108),
(1001, 108),
(1006, 103),
(1008, 105),
(1002, 105),
(1006, 101);

-- DDL for CLIENT relation 
DROP TABLE CLIENT;

CREATE TABLE CLIENT (
  clientID INT AUTO_INCREMENT PRIMARY KEY,
  fName VARCHAR(45) NOT NULL,
  lName VARCHAR(45) NOT NULL,
  DOB DATE,
  phone VARCHAR(45) UNIQUE NOT NULL,
  email VARCHAR(45)
);

ALTER TABLE CLIENT auto_increment = 100;

INSERT INTO CLIENT(fName, lName, DOB, phone, email) VALUES
('Abe', 'Laa', '1938-11-01','733-440-5517', NULL),
('Bbe', 'Lab', '1948-01-22','712-245-5047', NULL),
('Cbe', 'Lac', '1958-07-01','735-408-1567', '1kay@gmail.com'),
('Dbe', 'Lad', '1988-12-17','732-845-8568', 'o5y12@gmail.com'),
('Ebe', 'Lae', NULL,'732-445-4567', NULL),
('Fbe', 'Laf', '1973-01-05','792-445-5567', NULL),
('Gbe', 'Lag', '1962-03-14','332-345-3564', '23kay55@gmail.com'),
('Hbe', 'Lah', NULL ,'732-445-5560', 'erkay@yahoo.com'),
('Ibe', 'Lai', '2001-09-12','632-245-0560', '4kay@yahoo.com'),
('Jbe', 'Laj', '1995-02-08','735-545-5261', NULL);

-- DDL for CLIENT_CASE relation 

DROP TABLE CLIENT_CASE;

CREATE TABLE CLIENT_CASE (
  caseID INT AUTO_INCREMENT PRIMARY KEY,
  start_date DATE NOT NULL,
   end_date DATE,
   staffID INT, 
   FOREIGN KEY (staffID) 
        REFERENCES STAFF(staffID),
   serviceID INT,
   FOREIGN KEY (serviceID) 
        REFERENCES SERVICE(serviceID),
   clientID INT, 
   FOREIGN KEY (clientID) 
        REFERENCES CLIENT(clientID)
);

ALTER TABLE CLIENT_CASE auto_increment = 510;

INSERT INTO CLIENT_CASE(start_date, end_date, staffID, serviceID, clientID) VALUES
('2020-01-01', '2021-12-18', 5, 1001, 100),
('2021-03-01', NULL, 5, 1002, 101),
('2022-01-01', NULL, 5, 1003, 102),
('2021-01-01', NULL, 7, 1003, 103),
('2018-01-01', '2022-04-18', 5, 1004, 104),
('2020-07-01', NULL, 5, 1005, 105),
('2020-08-11', NULL, 7, 1006, 106),
('2021-11-12', NULL, 7, 1007, 107),
('2021-01-01', '2021-11-28', 5, 1008, 108),
('2022-02-01', NULL, 5, 1009, 109),
('2005-01-01', '2021-05-18', 7, 1010, 103),
('1997-01-01', '2005-10-10', 5, 1005, 108);

