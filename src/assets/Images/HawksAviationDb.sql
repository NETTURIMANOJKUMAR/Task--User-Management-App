set nocount on
set dateformat mdy

USE master

declare @dttm varchar(55)
select  @dttm=convert(varchar,getdate(),113)
raiserror('Beginning FlightDb.SQL at %s ....',1,1,@dttm) with nowait
GO

CHECKPOINT
go

raiserror('Creating Flight database....',0,1)
go

go
use master
go
CREATE DATABASE [FlightDb]
go
use [FlightDb]
go
CHECKPOINT

create table Airports
(
	AirportID varchar(10) primary key not null,
	Name varchar(20) not null,
	City varchar(10) not null,
	Country varchar(10) not null
)
go

create table Flights
(
	FlightNo int not null primary key IDENTITY(11021,5),
	FlightID varchar(10) not null,
	Name varchar(20) not null,
	Start varchar(10) not null Foreign key references Airports,
	Destination varchar(10) not null Foreign key references Airports,
	Arrival DateTime not null default CURRENT_TIMESTAMP,
	Departure DateTime not null default CURRENT_TIMESTAMP,
	TotalSeats int default 0,
	AvailableSeats int default 0,
	Fare float default 1500.00
)
go



create table Customer
(
	CustomerID int not null primary key IDENTITY(451275,6),
	FirstName varchar(50) not null, 
	LastName varchar(50) not null, 
	Age int not null default 18,
	Gender varchar(10) not null,
	EmailID varchar(25) unique not null,
	MobileNumber varchar(10) unique not null, 
	Username varchar(15) not null unique,
	[Password] varchar(16) not null
)

CREATE NONCLUSTERED INDEX NCI_Cust_Email
ON dbo.Customer(EmailID)

CREATE NONCLUSTERED INDEX NCI_Cust_MobNum
ON dbo.Customer(MobileNumber)

CREATE NONCLUSTERED INDEX NCI_Cust_UsNa
ON dbo.Customer(Username)
go

create table [Admin]
(
	AdminID int not null primary key IDENTITY(11101,3),
	Username varchar(15) not null,
	[password] varchar(16) not null,
	[Role] varchar(20) not null
)
go

create table [Login]
(
	Username varchar(15) not null primary key,
	[Password] varchar(16) not null,
	[Role] varchar(20) not null
)
go

create table Bookings
(
	BookingID int not null primary key IDENTITY(104515545,6),
	FlightNo int not null Foreign key references Flights,
	CustomerID int not null Foreign key references Customer,
	Seats int not null,
	BookingAmount float not null,
	Arrival DateTime,
	Departure DateTime,
	[Status] varchar(20) default 'Pending'
)