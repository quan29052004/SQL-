CREATE DATABASE EmployeeDB 
GO
USE EmployeeDB
GO
CREATE TABLE Department(
Departld INT PRIMARY KEY,
DepartName VARCHAR(50) not null ,
DESCRIPTION VARCHAR(100) not null,
)

GO
CREATE TABLE Employee(
EmpCode CHAR(6) PRIMARY KEY,
FirstName VARCHAR(30) not null,
LastName VARCHAR(30) not null,
Birthday SMALLDATETIME not null,
Gender BIT DEFAULT 1 ,
ADDRESS VARCHAR(100) ,
DepartlID INT FOREIGN KEY REFERENCES Department,
Salary MONEY ,
)

--4
CREATE TRIGGER tg_chkBirthday
ON Employee
AFTER INSERT, UPDATE
AS
BEGIN
	IF EXISTS (SELECT 1 FROM inserted WHERE Birthday <= 23)
	BEGIN
		RAISERROR('value of birthday column must be greater than 23', 16, 1);
		ROLLBACK TRANSACTION;
	END
END
--7

create procedure sp_getAllEmp(@departId int)
as
	begin
		select * 
		from employee
		where departId = @departId
	end
go

--8
create proc sp_delDept @EmpCode char(6)
as
BEGIN
DELETE FROM Employee 
WHERE EmpCode=@EmpCode
end

exec sp_getAllEmp 03