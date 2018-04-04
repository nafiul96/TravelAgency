DROP DATABASE IF EXISTS Travel_agency;
CREATE DATABASE Travel_agency;
USE Travel_agency;

CREATE TABLE Location (
  Location_ID INT NOT NULL AUTO_INCREMENT,
  Street_Address Varchar(6),
  City Varchar (50),
  State Varchar(50),
  Country Varchar(50),
  PRIMARY KEY (Location_ID)
);
ALTER TABLE Location AUTO_INCREMENT=10001; 



CREATE TABLE PaymentAccount (
  PaymentAccount_Number INT,
  Payment_Type Varchar(50),
  Card_Expirary_Date date NOT NULL,
  PRIMARY KEY (PaymentAccount_Number, Payment_Type),
  CHECK ( PaymentAccount_Number>=1000000000000000 AND PaymentAccount_Number<=1000000000000000 ),                        
  CONSTRAINT Payment_Type_Const CHECK (Payment_Type IN ('Credit', 'Debit', 'PayPal', 'Other'))
);

CREATE TABLE Employee (
  Employee_ID INT NOT NULL AUTO_INCREMENT,
  Date_Joined DATETIME DEFAULT CURRENT_TIMESTAMP,
  Employee_Name Varchar(50) NOT NULL,
  Contact Varchar(50),
  Salary FLOAT NOT NULL,
  Supervisor_ID INT,
  PRIMARY KEY (Employee_ID),
  CHECK( Employee_ID>10000 AND Employee_ID<100000),
  CHECK(Salary>0),
  CHECK( Supervisor_ID>10000 AND Supervisor_ID<100000)
);

ALTER TABLE Employee AUTO_INCREMENT=10001;

CREATE TABLE Trip (
  Reservation_Number INT  NOT NULL AUTO_INCREMENT,
  Employee_ID INT,
  Date_Reserved DATETIME DEFAULT CURRENT_TIMESTAMP ,
  Date_Departure DATETIME DEFAULT CURRENT_TIMESTAMP,
  Date_Return DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (Reservation_Number),
  FOREIGN KEY (Employee_ID) references Employee(Employee_ID),
  CHECK(Date_Departure>=Date_Reserved),
  CHECK(Date_Departure<Date_RETURN)
  
);
ALTER TABLE Trip AUTO_INCREMENT = 10000000000000;



CREATE TABLE Passenger (
  Passenger_ID INT NOT NULL AUTO_INCREMENT,
  Passenger_Name Varchar(50),
  Passenger_Gender Varchar(50),
  Passenger_Age INT,
  PRIMARY KEY (Passenger_ID),
  CHECK(Passenger_Age>=0 OR Passenger_Age<=200),
  CONSTRAINT Gender_Const CHECK (Passenger_Gender IN ('Male', 'Female', 'Other'))

);

ALTER TABLE Passenger AUTO_INCREMENT = 10000000000000;

CREATE TABLE PaymentReciept (
  Receipt_Number INT NOT NULL AUTO_INCREMENT,
  Reservation_Number INT,
  Date_Paid DATETIME DEFAULT CURRENT_TIMESTAMP, 
  Total_Paid DECIMAL(10,4),
  Trip_Summary Varchar(5000),
  PaymentAccount_Number INT,
  Payment_Type Varchar(50),
  PRIMARY KEY (Receipt_Number),
  FOREIGN KEY (Reservation_Number) references Trip(Reservation_Number),
  FOREIGN KEY  (PaymentAccount_Number, Payment_Type) 
  references PaymentAccount(PaymentAccount_Number, Payment_Type),
  CHECK(Total_Paid >=0),
  CHECK( Employee_ID>10000 AND Employee_ID<100000)
);

ALTER TABLE PaymentReciept AUTO_INCREMENT = 100000000000000000;

CREATE TABLE TransportTickets (
 TransportTicket_Number INT,
 Source_Location INT,
 Final_Destination INT,
 ModeOfTransport Varchar(50),
 Fare INT,
 PRIMARY KEY (TransportTicket_Number),
 FOREIGN KEY (Source_Location) references Location(Location_ID),
 FOREIGN KEY (Final_Destination) references Location(Location_ID)
);

CREATE TABLE Flight (
  Flight_ID INT NOT NULL AUTO_INCREMENT,
  Flight_Number INT,
  Flight_Carrier Varchar(50),
  Flight_Fare Decimal(10,4),
  Flight_Class varchar(10),
  Source_Airport_ID Varchar(50),
  Destination_Airport_ID Varchar(50),
  Flight_Capacity INT,
  Flight_Dep_Time DATETIME,
  Flight_Arv_Time DATETIME,
  PRIMARY KEY (Flight_ID),
  CHECK (Flight_Class IN ('Business', 'Economy')),
  CHECK(Flight_Fare>=0),
  CHECK(Flight_Capacity>0 AND Flight_Capacity<305),
  CHECK(Flight_Dep_Time< Flight_Arv_Time)
);

ALTER TABLE Flight AUTO_INCREMENT = 100000000000000000;

CREATE TABLE GroupTrip (
  Group_ID INT NOT NULL AUTO_INCREMENT,
  Reservation_Number INT,
  Group_Size INT,
  Purpose Varchar(50),
  PRIMARY KEY (Group_ID),
  FOREIGN KEY (Reservation_Number) references Trip(Reservation_Number),
  CHECK(Group_ID< 100000000),
  CHECK(Group_Size>0 AND Group_Size<=6)
);
ALTER TABLE GroupTrip AUTO_INCREMENT = 10000001;


CREATE TABLE TransportationOfGroup (
  Transportation_ID INT NOT NULL AUTO_INCREMENT,
  Group_ID INT,
  TransportTicket_Number INT,
  Class Varchar(50),
  PRIMARY KEY (Transportation_ID),
  FOREIGN KEY (Group_ID) references GroupTrip(Group_ID), 
  FOREIGN KEY (TransportTicket_Number) 
  references TransportTickets(TransportTicket_Number),
  CHECK(Transportation_ID<100000000),
  CHECK(Group_ID>10000000 AND Group_ID< 100000000),
  CHECK(TransportTicket_Number>10000000 AND TransportTicket_Number< 100000000)
);
ALTER TABLE TransportationOfGroup AUTO_INCREMENT = 10000001;



CREATE TABLE Accomodation (
  Accomodation_ID INT NOT NULL AUTO_INCREMENT,
  Acommodation_Name Varchar(50),
  Accomodation_Type Varchar(50),
  Quantity_Available INT NOT NULL,
  Rate_Per_Night INT NOT NULL,
  Facilities Varchar(1000),
  PRIMARY KEY (Accomodation_ID),
  CHECK(Rate_Per_Night>=0),
  CHECK( Quantity_Available>=0),
  CHECK( Accomodation_ID< 1000000000000000000)
);
ALTER TABLE Accomodation  AUTO_INCREMENT = 100000000000000000;

CREATE TABLE AccomodationReservation (
  Confirmation_Number INT NOT NULL AUTO_INCREMENT,
  Accomodation_ID INT,
  Group_ID INT,
  Check_In_Date datetime,
  Check_Out_Date datetime,
  Total_Amount DECIMAL(10,4),
  PRIMARY KEY (Confirmation_Number),
  FOREIGN KEY (Accomodation_ID) references Accomodation(Accomodation_ID),
  Foreign KEY ( Group_ID) references GroupTrip(Group_ID),
  CHECK(Total_Amount>=0),
  CHECK( Accomodation_ID >= 100000000000000000 AND Accomodation_ID< 1000000000000000000),
  CHECK( Confirmation_Number< 1000000000000000000),
  CHECK(Group_ID>100000000 AND Group_ID <100000000),
  CHECK(Check_In_Date< Check_Out_Date)
);
ALTER TABLE AccomodationReservation  AUTO_INCREMENT = 100000000000000000;

CREATE TABLE Review (
  Review_Number INT,
  Group_ID INT,
  Passenger_ID INT,
  Rating INT,
  Detailed_Review Varchar(1000),
  PRIMARY KEY (Review_Number),
  FOREIGN KEY (Group_ID) references GroupTrip(Group_ID),
  FOREIGN KEY  (Passenger_ID) references Passenger(Passenger_ID),
  CHECK(Passenger_ID >=10000000000000 AND Passenger_ID <100000000000000),
  CHECK(Group_ID>100000000 AND Group_ID <100000000),
  CHECK(Rating >=0 AND Rating <-5)

);

CREATE TABLE Bus (
  Bus_ID INT NOT NULL AUTO_INCREMENT,
  Bus_Number INT,
  Bus_Company Varchar(50),
  Bus_Fare Decimal(10,4),
  Source_Bus_Stop Varchar(50),
  Destination_Bus_Stop Varchar(50),
  Bus_Capacity INT,
  Bus_Dep_Time DATETIME,
  Bus_Arv_Time DATETIME,
  PRIMARY KEY (Bus_ID),

  CHECK(Bus_Fare>=0),
  CHECK(Bus_Capacity>0 AND Bus_Capacity<50),
  CHECK(Bus_Dep_Time< Bus_Arv_Time)
);

ALTER TABLE Bus AUTO_INCREMENT = 100000000000000000;

CREATE TABLE Cruise (
  Cruise_ID INT NOT NULL AUTO_INCREMENT,
  Route_Number INT,
  Cruise_Company Varchar(50),
  Cruise_Number INT,
  Source_Port Varchar(50),
  Destination_Port Varchar(50),
  
  
  Cruise_Fare Decimal(10,4),
  Cruise_Class varchar(10),
  Cruise_Capacity INT,
  PRIMARY KEY (Cruise_ID),
  CHECK (Cruise_Class IN ('Business', 'Economy')),
  CHECK(Cruise_Fare>=0),
  CHECK(Cruise_Capacity>0 AND Cruise_Capacity<7500),
  CHECK(Cruise_Dep_Time< Cruise_Arv_Time)
);
ALTER TABLE Cruise AUTO_INCREMENT = 100000000000000000;

CREATE TABLE Car(
  Car_ID INT  NOT NULL AUTO_INCREMENT,
  Car_Number INT,
  Company Varchar(50),
  Park_Addr Varchar(50),
  Primary Key(Car_ID)
);
ALTER TABLE Car AUTO_INCREMENT = 100000000000000000;

CREATE TABLE Group_Members(
    Group_ID INT NOT NULL,
    Passenger_ID INT NOT NULL,
    FOREIGN KEY (Group_ID) references GroupTrip(Group_ID),
    FOREIGN KEY  (Passenger_ID) references Passenger(Passenger_ID),
    CHECK(Passenger_ID >=10000000000000 AND Passenger_ID <100000000000000),
    CHECK(Group_ID>100000000 AND Group_ID <100000000)
);