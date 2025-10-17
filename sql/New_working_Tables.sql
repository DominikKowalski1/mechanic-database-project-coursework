CREATE TABLE Customer (
    customer_id VARCHAR(20) PRIMARY KEY,
    cust_name VARCHAR(100) NOT NULL,
    cust_email VARCHAR(100),
    cust_phoneno VARCHAR(15)
);

CREATE TABLE Car (
    registration VARCHAR(20) PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    date_of_manufacture DATE ,
    customer_id VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

CREATE TABLE Mechanic (
    employee_id VARCHAR(20) PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    emp_phone VARCHAR(15) UNIQUE,
    grade VARCHAR(50)
);

CREATE TABLE Service (
    service_id VARCHAR(20) PRIMARY KEY,
    registration VARCHAR(20) NOT NULL,
    dropoff_date DATE DEFAULT CAST(GETDATE() AS DATE), --Defaults to current date
    dropoff_time TIME DEFAULT CAST(GETDATE() AS TIME), --Defaults to current time
    work_required TEXT,
    mileage INT CHECK (mileage >= 0), --Car mileage can not be a negative
    next_service DATE NULL,
    FOREIGN KEY (registration) REFERENCES Car(registration) ON DELETE CASCADE
);

CREATE TABLE Service_Mechanic (
    service_id VARCHAR(20) NOT NULL,
    employee_id VARCHAR(20) NOT NULL,
    time_spent TIME DEFAULT '00:00:00',
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
        ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES Mechanic(employee_id)
	ON DELETE CASCADE,
    PRIMARY KEY (service_id, employee_id)
);

