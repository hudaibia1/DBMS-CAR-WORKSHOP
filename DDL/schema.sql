-- Milestone 4: DDL Scripts for Car Workshop Management System
-- Database Setup based on Normalized Schema

-- 1. CUSTOMER TABLE
CREATE TABLE CUSTOMER (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(20)
);

-- Index on frequently queried columns
CREATE INDEX idx_customer_email ON CUSTOMER(Email);
CREATE INDEX idx_customer_lastname ON CUSTOMER(LastName);

-- 2. VEHICLE TABLE
CREATE TABLE VEHICLE (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    RegNo VARCHAR(20) NOT NULL UNIQUE,
    Make VARCHAR(50) NOT NULL,
    ModelName VARCHAR(50) NOT NULL,
    Year INT NOT NULL CHECK (Year >= 1900 AND Year <= 2100),
    CustomerID INT NOT NULL,
    CONSTRAINT fk_vehicle_customer FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID) ON DELETE CASCADE
);

-- Index on Foreign Key and frequently queried column
CREATE INDEX idx_vehicle_customerid ON VEHICLE(CustomerID);
CREATE INDEX idx_vehicle_regno ON VEHICLE(RegNo);

-- 3. MECHANIC TABLE
CREATE TABLE MECHANIC (
    MechanicID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    SkillLevel VARCHAR(20) NOT NULL CHECK (SkillLevel IN ('Junior', 'Intermediate', 'Senior', 'Master')),
    Contact VARCHAR(20) NOT NULL
);

-- Index on frequently queried columns
CREATE INDEX idx_mechanic_lastname ON MECHANIC(LastName);
CREATE INDEX idx_mechanic_skilllevel ON MECHANIC(SkillLevel);

-- 4. SERVICE_JOB TABLE
CREATE TABLE SERVICE_JOB (
    JobID INT AUTO_INCREMENT PRIMARY KEY,
    Date DATE NOT NULL,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Pending', 'In Progress', 'Completed', 'Cancelled')),
    LaborCost DECIMAL(10, 2) DEFAULT 0.00 CHECK (LaborCost >= 0),
    VehicleID INT NOT NULL,
    MechanicID INT NOT NULL,
    CONSTRAINT fk_job_vehicle FOREIGN KEY (VehicleID) REFERENCES VEHICLE(VehicleID) ON DELETE CASCADE,
    CONSTRAINT fk_job_mechanic FOREIGN KEY (MechanicID) REFERENCES MECHANIC(MechanicID) ON DELETE RESTRICT
);

-- Indexes on Foreign Keys and Status
CREATE INDEX idx_job_vehicleid ON SERVICE_JOB(VehicleID);
CREATE INDEX idx_job_mechanicid ON SERVICE_JOB(MechanicID);
CREATE INDEX idx_job_status ON SERVICE_JOB(Status);

-- 5. SPARE_PART TABLE
CREATE TABLE SPARE_PART (
    PartID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL DEFAULT 0 CHECK (Quantity >= 0),
    UnitPrice DECIMAL(10, 2) NOT NULL CHECK (UnitPrice >= 0)
);

-- Index on Part Name
CREATE INDEX idx_part_name ON SPARE_PART(Name);

-- 6. SERVICE_PARTS (Junction Table)
CREATE TABLE SERVICE_PARTS (
    JobID INT NOT NULL,
    PartID INT NOT NULL,
    QuantityUsed INT NOT NULL CHECK (QuantityUsed > 0),
    PRIMARY KEY (JobID, PartID),
    CONSTRAINT fk_sp_job FOREIGN KEY (JobID) REFERENCES SERVICE_JOB(JobID) ON DELETE CASCADE,
    CONSTRAINT fk_sp_part FOREIGN KEY (PartID) REFERENCES SPARE_PART(PartID) ON DELETE RESTRICT
);

-- Indexes on Foreign Keys
CREATE INDEX idx_sp_partid ON SERVICE_PARTS(PartID);

-- 7. INVOICE TABLE
CREATE TABLE INVOICE (
    InvoiceID INT AUTO_INCREMENT PRIMARY KEY,
    Date DATE NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL CHECK (PaymentStatus IN ('Paid', 'Unpaid', 'Refunded')),
    PaymentMethod VARCHAR(50),
    JobID INT NOT NULL,
    CONSTRAINT fk_invoice_job FOREIGN KEY (JobID) REFERENCES SERVICE_JOB(JobID) ON DELETE CASCADE
);

-- Indexes on Foreign Key and Status
CREATE INDEX idx_invoice_jobid ON INVOICE(JobID);
CREATE INDEX idx_invoice_paymentstatus ON INVOICE(PaymentStatus);
