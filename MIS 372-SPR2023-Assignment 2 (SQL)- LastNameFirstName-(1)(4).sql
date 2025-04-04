


/* MIS 372, SPR 2023, Applied Assignment 2 

Submission from: <Aldo Cruz-Ramos> */

/*Tasks 1 – 3: Use the data definition language component of SQL to: */ 

/* Task 1:Write the CREATE table statements to implement the tables as defined above.

Statements for dropping and creating the tables
Don't forget to define all primary keys
Implement all foreign key constraints
Be sure that each attribute has the proper data type and constraints (e.g., UNIQUE, NULL, CHECK)
Don't forget to include the two necessary CHECK constraints */

 /* Drop tables

 < Insert Drop table statements >

 /* Create tables  */ */ 
 
 CREATE TABLE Ship (
Ship_ID NUMERIC PRIMARY KEY,
Ship_Name VARCHAR(100),
Ship_Size NUMERIC (3,0) CHECK (Ship_Size > 0),
Ship_Registry VARCHAR(50) CHECK (Ship_Registry IN ('United States', 'The Netherlands', 'Jamaica', 'Bahamas', 'Britain')),
Ship_ServEntryDate NUMERIC (4,0), CHECK (Ship_ServEntryDate > 1980),
Ship_PassCapacity NUMERIC(5,0),
Ship_CrewCapacity NUMERIC(3,0),
Ship_Lifestyle VARCHAR(40) DEFAULT 'Contemporary' CHECK (Ship_Lifestyle IN('Contemporary', 'Premium', 'Freestyle')),
Ship_Class VARCHAR(40) DEFAULT 'Oasis' CHECK (Ship_Class IN('Freedom', 'Voyager', 'Oasis'))
);

ALTER TABLE Ship
ALTER COLUMN Ship_Size NUMERIC (10,0);

Create Table Passenger (
Pass_ID NUMERIC PRIMARY KEY,
Pass_Name VARCHAR(100) NOT NULL,
Pass_City Varchar(80),
Pass_State VARCHAR(2),
Pass_Telephone VARCHAR(15),
Pass_NOK_Telephone VARCHAR(15),
Pass_NextOfKin VARCHAR(100)
);

CREATE TABLE Cruise (
Cruise_ID NUMERIC PRIMARY KEY,
Ship_ID Numeric NOT NULL,
Cruise_DeptDate DATE NOT NULL,
Cruise_DeptCity VARCHAR(80) NOT NULL,
Cruise_DeptCounty VARCHAR(80) NOT NULL,
Cruise_Duration INTEGER Default 5
);

ALTER TABLE Cruise
ADD CONSTRAINT fk_Ship_ID FOREIGN KEY (Ship_ID) REFERENCES Ship(Ship_ID);

CREATE TABLE Reservation (
Pass_ID Numeric NOT NULL,
Cruise_ID Numeric NOT NULL,
Res_TotalCost Numeric(8,2) Check(Res_TotalCost > 0),
Res_BalanceDue Numeric(8,2),
Res_SpecialRequest VARCHAR(30) Check(Res_SpecialRequest IN('Null', 'Vegetarian', 'Low Salt', 'Kosher')),
Res_Room VARCHAR(10),
Res_Deposit NUMERIC(8,2) Check(Res_Deposit > 0)
);

ALTER TABLE Reservation
ADD CONSTRAINT fk_Pass_ID FOREIGN KEY (Pass_ID) REFERENCES Passenger(Pass_ID);

ALTER TABLE Reservation
ADD CONSTRAINT fk_Cruise_ID FOREIGN KEY (Cruise_ID) REFERENCES Cruise(Cruise_ID);

 
/*Task 2: Populate the tables: Write INSERT statements to insert data into the tables as shown above.

Insert the data shown in each table.  */

-- Insert into table tblShip */

  INSERT INTO Ship VALUES ('1', 'Adventure of the Seas', 100000, 'Bahamas', 2005, 1884, 680, 'Contemporary', 'Voyager');
INSERT INTO Ship VALUES ('2', 'Freedom of the Seas', 150000, 'United States', 2006, 2400, 800, 'Freestyle', 'Freedom');
INSERT INTO Ship VALUES ('3', 'Mariner of the Seas', 55000, 'United States', 2010, 600, 200, 'Premium', 'Voyager');
INSERT INTO Ship VALUES ('4', 'Allure of the Seas', 95000, 'Bahamas', 2005, 950, 250, 'Freestyle', 'Oasis');

SELECT *
FROM Ship

-- Insert into table tblPassenger

 INSERT INTO Passenger VALUES (12345, 'Terry Smith', 'Omaha', 'NE', '(402)123-4567', 'Joe Smith', '(402)123-4567');
INSERT INTO Passenger VALUES (12346, 'Joe Smith', 'Omaha', 'NE', '(402)123-4567', 'Terry Smith', '(402)123-4567');
INSERT INTO Passenger VALUES (13232, 'Timothy Jefferson', 'Salem', 'OR', '(503)456-1234', 'Jenny Jefferson', '(503)444-4444');
INSERT INTO Passenger VALUES (22456, 'Michael Simpson', 'Denver', 'CO', '(970)789-4343', 'Sherri Simpson', '(970)333-3333');
INSERT INTO Passenger VALUES (22457, 'Zoe Jefferson', 'Denver', 'CO', '(970)789-4343', 'Michael Johnson', '(970)555-5555');
INSERT INTO Passenger VALUES (35466, 'Marcus Myers', 'San Diego', 'CA', '(858)987-7654', 'Tim Myers', '(858)666-6666');

SELECT *
FROM Passenger

-- Insert into table tblCruise

 INSERT INTO Cruise VALUES (1, 1, '05-Aug-20', 'Boston', 'United States', 3);
INSERT INTO Cruise VALUES (2, 1, '06-Oct-20', 'Baltimore', 'United States', 5);
INSERT INTO Cruise VALUES (3, 2, '19-Nov-20', 'Port Canaveral', 'United States', 3);
INSERT INTO Cruise VALUES (4, 3, '02-Dec-20', 'Rio De Janeiro', 'Brazil', 8);
INSERT INTO Cruise VALUES (5, 3, '12-Jan-21', 'Vancouver', 'Canada', 9);

SELECT * 
FROM Cruise

-- Insert into table tblReservation

  INSERT INTO Reservation Values(12345, 1, $615.00, $500.00, 'Vegetarian', 'B323', $115.00);
INSERT INTO Reservation Values(12345, 4, $999.99, $499.99, 'Kosher', 'H144', $500.00);
INSERT INTO Reservation Values(12346, 4, $999.99, $349.99, 'Low Salt', 'H144', $550.00);
INSERT INTO Reservation Values(13232, 2, $750.00, $250.00, 'Null' , 'C132', $500.00);
INSERT INTO Reservation Values(22456, 2, $800.00, $300.00, 'Null' , 'F908', $500.00);
INSERT INTO Reservation Values(22456, 3, $550.00, $200.00, 'Vegetarian', 'A800', $350.00);
INSERT INTO Reservation Values(22456, 4, $900.00, $400.00, 'Null' , 'H900', $500.00);
INSERT INTO Reservation Values(22457, 4, $900.00, $300.00, 'Null' , 'H900', $600.00);
INSERT INTO Reservation Values(35466, 5, $1200.00, $500.00, 'Null' , 'C235', $700.00);

SELECT *
FROM Reservation


-- Hint: Don't forget to add your foreign key columns

  -- < Insert Insert statements >


/* Task 3: 3.	ALTER the check constraint in the Reservation table 
so that possible values for the Res_SpecialRequest column are: “Vegetarian”, “Gluten Free”, “Low Salt”, “Kosher” and “Low Carb”.  */

  ALTER TABLE Reservation
DROP CONSTRAINT CK__Reservati__Res_S__245D67DE;

ALTER TABLE Reservation
ADD CONSTRAINT CK__Reservati__Res_S__245D67DE CHECK (Res_SpecialRequest IN('NULL', 'Vegetarian', 'Gluten Free', 'Low Salt', 'Kosher', 'Low Carb'));


SELECT 
	CONSTRAINT_NAME,
	CONSTRAINT_TYPE
FROM
	INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE
	TABLE_NAME = 'Reservation';


/* Task 4 - 10: Use the data manipulation language component of SQL to: */

-- 4.  Create a query to list the passenger name, phone number and their next of kin.  
          -- Save this query as Passengers Contact Information. --

  SELECT
    Pass_Name AS 'Passenger Name',
    Pass_Telephone AS 'Phone Number',
    Pass_NextOfKin AS 'Next of Kin'
FROM
    Passenger;


-- 5.	Create a query to list the names and telephone numbers of all passengers with a reservation on Cruise #2.  
--Save this query as Cruise 2 Passengers.

  SELECT
	P.Pass_Name AS 'Passenger Name',
	P.Pass_Telephone AS 'Passenger Telephone'
FROM
	Passenger P
JOIN
	Reservation R ON P.Pass_ID = R.Pass_ID
JOIN
	Cruise C ON R.Cruise_ID = C.Cruise_ID
WHERE 
	C.Cruise_ID = 2;

-- 6.	Pick one of your Passengers.  Design a query to list the cruise ship, the departure date, the city of departure, 
       -- the deposit amount, and the outstanding balance for each of that passenger's reservations. 
       -- The choice of passenger may be hard coded into the query.-- 

  SELECT
	C.Ship_ID AS 'Cruise Ship',
	C.Cruise_DeptDate AS 'Departure Date',
	C.Cruise_DeptCity AS 'City of Departure',
	R.Res_Deposit AS 'Deposit Amount',
	R.Res_BalanceDue AS 'Outstanding Balance'
FROM 
	Passenger P
JOIN
	Reservation R ON P.Pass_ID = R.Pass_ID
JOIN 
	Cruise C ON R.Cruise_ID = C.Cruise_ID
Where
	P.Pass_ID = 12345

-- 7.	Some of the food picked up by cruise ships departing from Boston might have been carrying a rare virus. 
       -- Develop a query to list the names, next of kin, and telephone numbers of all passengers who have had a reservation on a ship departing from Boston. -- 

  SELECT
	DISTINCT P.Pass_ID,
	P.Pass_Name AS 'Passenger Name',
	P.Pass_NextOfKin AS 'Next Of Kin',
	P.Pass_Telephone AS 'Passenger Telephone'
FROM 
	Passenger P
JOIN
	Reservation R ON P.Pass_ID = R.Pass_ID
JOIN
	Cruise C ON R.Cruise_ID = C.Cruise_ID
WHERE
	C.Cruise_DeptCity = 'Boston';

-- 8.	Save the query you created in task 7 as a view with the name “vw_bostonPassengers”.

  CREATE VIEW vw_bostonPassengers AS
SELECT
	DISTINCT P.Pass_ID,
	P.Pass_Name AS 'Passenger Name',
	P.Pass_NextOfKin AS 'Next Of Kin',
	P.Pass_Telephone AS 'Passenger Telephone'
FROM 
	Passenger P
JOIN
	Reservation R ON P.Pass_ID = R.Pass_ID
JOIN
	Cruise C ON R.Cruise_ID = C.Cruise_ID
WHERE
	C.Cruise_DeptCity = 'Boston';

	SELECT * FROM vw_bostonPassengers

-- 9.	Create a query that prompts the user for a cruise number and for a special request type 
       -- and lists the names of passengers with reservation on that cruise who have that special request.   
      -- In other words, if the user inputs '1' for the cruise and 'Vegetarian' for the special request, 
       --then the query should return all passengers who have a reservation on cruise 1 and wish to have vegetarian meals.  --

  CREATE PROCEDURE GetPassengersWithSpecialRequest
	@CruiseNumber NUMERIC,
	@SpecialRequest VARCHAR(30)
AS
BEGIN
	SELECT
		P.Pass_Name AS 'Passenger Name',
		P.Pass_NextOfKin AS 'Next Of Kin',
		P.Pass_Telephone AS 'Passenger Telephone'
	FROM
		Passenger P
	JOIN
		Reservation R ON P.Pass_ID = R.Pass_ID
	JOIN
		Cruise C ON R.Cruise_ID = C.Cruise_ID
	Where
		C.Cruise_ID = @CruiseNumber
		AND R.Res_SpecialRequest = @SpecialRequest;
END;

EXEC GetPassengersWithSpecialRequest @CruiseNumber = 1, @SpecialRequest = 'Vegetarian';

-- 10.	Save the query you created in task 9 as a view with the name vw_cruiseSpeciallRequests.” --
  
  CREATE VIEW vw_cruiseSpeciallRequests AS
SELECT
		P.Pass_Name AS 'Passenger Name',
		P.Pass_NextOfKin AS 'Next Of Kin',
		P.Pass_Telephone AS 'Passenger Telephone'
	FROM
		Passenger P
	JOIN
		Reservation R ON P.Pass_ID = R.Pass_ID
	JOIN
		Cruise C ON R.Cruise_ID = C.Cruise_ID
	Where
		C.Cruise_ID = 1
		AND R.Res_SpecialRequest = 'Vegetarian';

SELECT * FROM vw_cruiseSpeciallRequests




/* Reflection on Assignment (Down Below)


/*
Coming from the learning homework, I was able to retain some elements from it. That being said, I still had a little bit of struggle with it, 
especially towards the end. I was sought out support to help me finish. I learned that it is crucial that you look closely over the code and
ensuring that you don't misspell a word or symbol because one little typo can make or break the whole code. 
  

