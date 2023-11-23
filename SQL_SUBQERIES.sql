CREATE DATABASE Subqueries;
USE Subqueries;
CREATE TABLE Internships(
Intern_Id int PRIMARY KEY,
Intern_Name varchar(16),
Company varchar(16),
City varchar(16),
Monthly_Stipend int
);

INSERT INTO Internships
VALUES 
(1, "George Mathews", "Microsoft", "Pune", 50000),
 (2, "Abhay Pal", "Google", "Mumbai", 55000),
 (3, "Neena Patel", "Microsoft", "Pune", 47000),
 (4, "Vikram Singh", "Amazon", "Bengaluru", 48000),
 (5, "Parvati Shinde", "Amazon", "Pune", 47000),
 (6, "Rita Gupta", "Microsoft", "Mumbai", 50000);
 CREATE TABLE More_Internships(
Intern_Id int PRIMARY KEY,
Intern_Name varchar(16),
Company varchar(16),
City varchar(16),
Monthly_Stipend int
);

INSERT INTO More_Internships
VALUES (7, "Ahmed Khan", "Microsoft", "Bengaluru", 50000),
 (8, "Shivani Roy", "Amazon", "Chennai", 55000),
 (9, "Angelica Thomas", "Google", "Pune", 47000);


CREATE TABLE Top_Interns(
Intern_Id int PRIMARY KEY,
Intern_Name varchar(16)
);

INSERT INTO Top_Interns
VALUES (1, "George Mathews"),
 (3, "Neena Patel"),
 (4, "Vikram Singh");


CREATE TABLE Completed_Internships(
Intern_Id int PRIMARY KEY,
Intern_Name varchar(16),
Completion_Date date
);

INSERT INTO Completed_Internships
VALUES (2, "Abhay Pal", "2022-02-11"),
 (6, "Rita Gupta", "2022-05-03");

 #Q1-Get the name of the highest earning intern. 
 SELECT Intern_name FROM Internships
 WHERE Monthly_Stipend=(SELECT MAX(Monthly_Stipend) FROM Internships);
 
 #Q2-Insert the rows of more_internships into internships.
 INSERT INTO Internships 
 SELECT * FROM more_internships;
 
 SELECT * FROM Internships;
 
 #Q3-Update the monthly stipend values in Internships for each of the top interns by adding Rs.1000 to their stipend.
 SET SQL_SAFE_UPDATES=0;
 UPDATE Internships 
 SET Monthly_Stipend=Monthly_Stipend+1000
 WHERE Intern_Id IN( SELECT Intern_Id FROM top_interns);
 SELECT * FROM Internships;
 
 #Q4-Delete rows of internships for those that already completed their internships.
 DELETE FROM Internships
 WHERE Intern_id IN (SELECT Intern_Id FROM completed_internships);
 
 #Q5-Get the proportion of count of interns working in each company
 SELECT Company ,COUNT(Intern_Id)/(SELECT COUNT(Intern_Id) FROM Internships )AS Proportion_Count
 FROM Internships 
 GROUP BY Company;
 
 #Q6-Get the proportion of monthly stipend of interns working in each company.
 SELECT Company ,SUM(Monthly_Stipend)/(SELECT SUM(Monthly_Stipend) FROM Internships )AS Proportion_Monthly_Stipend
 FROM Internships 
 GROUP BY Company;
 
 #Q7-Find interns who are working at the same company as George Mathews:
 SELECT Intern_Name, Company
FROM Internships
WHERE Company = (SELECT Company FROM Internships WHERE Intern_Name = 'George Mathews');

#Q8-List interns who have a monthly stipend greater than the average monthly stipend:
SELECT Intern_Name,Monthly_Stipend
FROM Internships
WHERE Monthly_Stipend>(SELECT AVG(Monthly_stipend) FROM Internships);

#Q9-Identify interns who have not completed an internship:
SELECT Intern_Name
FROM Internships
WHERE Intern_Id NOT IN (SELECT Intern_Id FROM Completed_Internships);

#Q10-Retrieve interns from the Top_Interns table along with their company information:
SELECT T.Intern_Name, I.Company
FROM Top_Interns T
INNER JOIN Internships I ON T.Intern_Id = I.Intern_Id;

#Q11-List interns who have not been included in the Top_Interns table:
SELECT Intern_Name
FROM Internships
WHERE Intern_Id NOT IN (SELECT Intern_Id FROM Top_Interns);





