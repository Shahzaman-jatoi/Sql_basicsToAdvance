SELECT * FROM EmployeeDemographics;
SELECT * FROM EmployeeSalary;

-- Performing JOINS 

-- INNER JOIN

-- THIS TABLE TAKES ALL THE COMMON VALUES AND RENDER IT

SELECT  EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics  -- TABLE A 
INNER JOIN EmployeeSalary  -- TABLE B
ON EmployeeSalary.EmployeeID = EmployeeDemographics.EmployeeID

-- FULL OUTER JOIN

-- THIS TABLE TAKES ALL THE VALUES EITHER COMMON OR NOT AND RENDER IT

SELECT  EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeSalary
FULL OUTER JOIN EmployeeDemographics
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- LEFT OUTER JOIN 

-- THIS TABLES RETURNS ALL THE DATA PRESENT IN TABLE A AND THE DATA OVERLAPPING WITH TABLE B, EXCEPT THE DATA JUST IN TABLE B

SELECT  EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics
LEFT OUTER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT  EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeSalary
LEFT OUTER JOIN EmployeeDemographics
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- RIGHT OUTER JOIN 

-- THIS TABLES RETURNS ALL THE DATA PRESENT IN TABLE B AND THE DATA OVERLAPPING WITH TABLE A, EXCEPT THE DATA JUST IN TABLE A
-- OPPOSITE OF LEFT OUTER JOIN

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics
RIGHT OUTER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
