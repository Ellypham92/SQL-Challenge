
-- Enter new staff information 
INSERT INTO STAFF(fName, lName, DOB, phone, email, position) VALUES
('Pham', 'El', '1989-12-01','832-123-4113','elpham@foc.org','Program Analyst');

-- Update staff information
UPDATE STAFF
SET phone = "832-789-6566"
WHERE fName = "El";


-- Delete staff information
DELETE FROM STAFF
WHERE fName = "El"
AND lName = "Pham";


-- Enter a new department information
INSERT INTO DEPARTMENT (departmentName) VALUES
("Senior Job");

-- Update department information
UPDATE DEPARTMENT
SET departmentName = "Benefits Enrollment Center"
WHERE departmentName = "Public Benefits";

-- Delete department information
DELETE FROM DEPARTMENT
WHERE departmentName = "Senior Job";

-- Enter a new funding information
INSERT INTO FUNDING(start_date, end_date, amount, funderID) VALUES
('2018-01-03', '2021-04-18', '416421.00', '2');


-- Update a new funding information
UPDATE FUNDING
SET amount = "416421.00"
WHERE fundingID = 8;

-- Delete funding information
DELETE FROM FUNDING
WHERE fundingID = 8;

-- Enter a new funder information
INSERT INTO FUNDER (funderName, status) VALUES
('Robo AI', 'Inactive');


-- Update a new funder information
UPDATE FUNDER
SET status = "Active"
WHERE funderName = "robo ai";

-- Delete funder information
DELETE FROM FUNDER
WHERE funderName = "Robo AI";

-- Enter a new service information
INSERT INTO SERVICE (serviceID, serviceType, departmentID) VALUES
(1011,'Truck Driver Training', 1);

-- Update a new service information
UPDATE SERVICE
SET serviceType = "Driving Class"
WHERE serviceType = "Truck Driver Training";

-- Delete the current service information
DELETE FROM SERVICE
WHERE serviceType = "Driving Class";

-- Enter a new client information
INSERT INTO CLIENT(fName, lName, DOB, phone, email) VALUES
('Smith', 'Amith', '1976-01-09','732-980-5791', "smith@aoc.com");

-- Update a new client information
UPDATE CLIENT
SET email = "smith.amith@gmail.com"
WHERE fName = "Smith"
AND lName = "Amith";

-- Delete the current client information
DELETE FROM CLIENT
WHERE fName = "Smith"
AND lName = "Amith";

-- Enter a new client case information
INSERT INTO CLIENT_CASE(start_date, end_date, staffID, serviceID, clientID) VALUES
('2021-08-26', '2022-04-01', 2, 1012, 123);

-- Update a new client case information
UPDATE CLIENT_CASE
SET end_date = "2022-04-16"
WHERE caseID = 511;

-- Delete the existing client case information
DELETE FROM CLIENT_CASE
WHERE caseID = 511;

-- Generate a report for the total number of clients each
-- department serves in a given time
-- DROP PROCEDURE tol_client_per_department;
delimiter $$
CREATE PROCEDURE tol_client_per_department (report_start_date date, report_end_date date)
BEGIN
SELECT report_start_date, report_end_date, d.departmentName, count(cc.caseID) as total_clients
FROM department d
INNER JOIN service s ON d.departmentID = s.departmentID
INNER JOIN CLIENT_CASE cc ON cc.serviceID = s.serviceID
WHERE cc.start_date BETWEEN report_start_date AND report_end_date
GROUP BY d.departmentName;
END$$
delimiter $$

CALL tol_client_per_department("2021-01-01",  "2021-03-31");

-- Generate a report for the number of client cases each staff
-- provided in a given time
DROP PROCEDURE tol_client_per_staff;
delimiter $$
CREATE PROCEDURE tol_client_per_staff (report_start_date date, report_end_date date)
BEGIN
SELECT report_start_date, report_end_date, s.fName, s.lName, count(c.caseID)
FROM staff s
INNER JOIN client_case c ON s.staffID = c.staffID
WHERE c.start_date BETWEEN report_start_date AND report_end_date
GROUP BY s.fName, s.lName;
END$$
delimiter $$;

-- CALL tol_client_per_staff ("2021-01-01",  "2021-12-31");


-- Generate a report for the minimum, the maximum,
-- the average number of services provided in a given time.
SELECT max(total) max_services, min(total) min_services, avg(total) avg_services
FROM (SELECT count(caseID) AS total
FROM Client_Case
WHERE start_date BETWEEN "2021-01-01" AND "2021-12-31"
GROUP BY clientID) table1;


-- Generate a report for the total number of grants receives by the department and 
-- total amount in a given time period.
SELECT d.departmentName, count(f.fundingID), sum(f.amount)
FROM department d
INNER JOIN funding_department fd ON d.departmentID = fd.departmentID
INNER JOIN funding f ON f.fundingID = fd.fundingID
WHERE start_date BETWEEN "2021-01-01" AND "2021-12-31"
GROUP BY departmentName;


-- Generate a report of the amount of grants group by each funder in a given time period 
-- and sort by the grant amount.
SELECT f.funderName, fg.start_date, fg.end_date, sum(fg.amount)
FROM funder f
INNER JOIN funding fg ON f.funderID = fg.funderID
WHERE DATE(fg.start_date) > "2020-01-03"
GROUP BY f.funderName, fg.start_date, fg.end_date
ORDER BY sum(fg.amount);

-- Generate a report of the service types with a higher number of clients in a given time period
SELECT s.serviceType, count(cc.caseID)
FROM Service s
INNER JOIN Client_Case cc ON s.serviceID = cc.serviceID
WHERE YEAR(cc.start_date) >  "2005"
GROUP BY s.serviceType
ORDER BY count(cc.caseID) DESC;

-- Total number of staff per department
SELECT  d.departmentName, count(s.staffID)
FROM staff s
INNER JOIN staff_department sd ON s.staffID = sd.staffID
INNER JOIN department d ON d.departmentID = sd.departmentID 
GROUP BY d.departmentName;

-- Generate a report for total number of clients that received service in a given time
SELECT  s.serviceType, count(c.clientID)
FROM service s
INNER JOIN service_client sc ON sc.serviceID = s.serviceID
INNER JOIN client c ON sc.clientID = c.clientID
GROUP BY s.serviceType
ORDER BY count(c.clientID) desc;





