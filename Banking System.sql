CREATE DATABASE BankingSystem;
use BankingSystem;
CREATE TABLE Customers (
CustomerID INT AUTO_INCREMENT PRIMARY KEY,
FirstName VARCHAR(50),
LastName  VARCHAR(50),
Address VARCHAR(50),
PhoneNumber VARCHAR(15),
Email VARCHAR(100),
DateOfBirth DATE,
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

USE BankingSystem;
CREATE TABLE Accounts (
AccountID INT AUTO_INCREMENT PRIMARY KEY,
CustomerID INT,
AccountType ENUM('Savings' , 'Checkings'),
Balance Decimal(15,2) DEFAULT 0,
Status ENUM('Active', 'Inactive'),
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

USE BankingSystem;
CREATE TABLE Transactions (
TransactionID INT AUTO_INCREMENT PRIMARY KEY,
AccountID int,
TransactionType ENUM ('Deposit','Withdrawal', 'Transfer'),
Amount Decimal (15,2),
TransactionDate timestamp default current_timestamp,
Foreign key (AccountID) REFERENCES Accounts(AccountID)
);

use bankingSystem;
Create Table Loans (
LoanID INT Auto_increment primary key,
CustomerID INT,
LoanAmount decimal(15,2),
InterestRate decimal(5,2),
LoanStatus ENUM('Pending',  'Apporved', 'Rejected', 'Paid'),
StartDate DATE,
EndDate DATE,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
use bankingsystem;
Select * from Customers;
ALTER TABLE Customers
ADD COLUMN DateOfBirth Date;


USE BANKINGSYSTEM;
INSERT INTO Customers( FirstName, LastName, Address, PhoneNumber, Email, DateOfBirth)
VALUES('John', 'Doe', '123 Main St', '678-822-1109', 'john.doe@yahoo.com', '1980-01-01');

INSERT INTO Accounts (CustomerID, AccountType, Balance, Status)
VALUES(1, 'Savings', 1000.0,'Active');

DELIMITER // 
CREATE PROCEDURE Deposits(IN accID INT, IN amount DECIMAL(15,2))
BEGIN
UPDATE Accounts set Balance = Balance + amount WHERE AccountID = accID;
INSERT INTO Transaction (AccountID, TransactionType, Amount) VALUES (accID, 'Deposit', amount);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Withdraw(IN accID INT, IN amount DECIMAL(15,2))
BEGIN
IF( SELECT Balance FROM Accounts Where AccountID = accID) >= Amount Then
   UPDATE Accounts SET Balance = Balance - amount WHERE AccountID = accID;
   INSERT INTO Transactions (AccountID, TransactionType, Amount) Values (accID, 'Withdrawal', amount);
   ELSE 
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient funds';
   END IF;
   END //
   DELIMITER ;
