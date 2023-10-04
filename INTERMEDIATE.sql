SELECT * FROM EmployeeDemographics
SELECT * FROM EmployeeSalary


-- USE CASES 

SELECT JobTitle, AVG(Salary) AS AverageSalary, COUNT(JobTitle) AS PersonPerDesignation
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

-- UNION JOIN

-- SELECT *
-- FROM EmployeeDemographics
-- UNION 
-- SELECT *
-- FROM WareHouseEmployeeDemographics

-- HOW CAN TWO NON SIMILAR TABLE JOIN AND RENDER TOGETHER 
--  THEY JOIN AND GET RENDERED DUE TO THE SIMILARITY OF DATA TYPE IN SELECT QUERY AND THE NUMBER OF COLUMNS WE CHOOSE AS WELL AS, THE SEQUENCE IN BOTH THE DATA TYPES MATTERS
-- EXAMPLE

SELECT * FROM EmployeeDemographics

SELECT EmployeeID, FirstName, Age 
FROM EmployeeDemographics
UNION
SELECT EmployeeID,JobTitle, Salary
FROM EmployeeSalary
ORDER BY EmployeeID

-- CASE STATEMENT 
SELECT FirstName, LastName, Jobtitle, Salary,
CASE 
    WHEN Jobtitle = 'Salesman' THEN Salary + (Salary * .10)
    WHEN Jobtitle = 'Accountant' THEN Salary + (Salary * .05)
    ELSE Salary + (Salary * .03)
END AS NewSalary
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
ORDER BY Salary DESC

-- UPDATING NULL ROWS IN EMPLOYEEDEMOGRAPHICS

SELECT * 
FROM EmployeeDemographics;

UPDATE EmployeeDemographics
SET EmployeeID = 1010
WHERE FirstName = 'Keanu' AND LastName = 'Reeve'

UPDATE EmployeeDemographics
SET EmployeeID = 1012, Age = 20, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax';

-- HAVING CLAUSE 

SELECT JobTitle, COUNT(JobTitle) AS PersonPerPosition
FROM EmployeeSalary
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

-- ALIASING TO ADVANCE 

SELECT Demo.EmployeeID, Demo.FirstName +' '+Demo.LastName AS FullName, Sal.Salary
FROM EmployeeDemographics AS Demo
INNER JOIN EmployeeSalary AS Sal
    ON Demo.EmployeeID = Sal.EmployeeID;

SELECT Demo.FirstName+ ' '+ Demo.LastName AS FullName, Sal.Salary,WareHouseEmp.Age
FROM EmployeeDemographics AS Demo
LEFT JOIN EmployeeSalary AS Sal
    ON Demo.EmployeeID = Sal.EmployeeID
RIGHT JOIN WareHouseEmployeeDemographics AS WareHouseEmp
    ON Demo.EmployeeID = WareHouseEmp.EmployeeID

SELECT * FROM WareHouseEmployeeDemographics

-- PARTIION BY
SELECT Demo.FirstName+' '+Demo.LastName, Sal.JobTitle, Sal.Salary, 
AVG(Sal.Salary) OVER (PARTITION BY Sal.JobTitle) AS AvgSalary
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
    ON Demo.EmployeeID = Sal.EmployeeID;

