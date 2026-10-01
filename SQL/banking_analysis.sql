CREATE DATABASE banking_system;

USE banking_system;

-- Step 2 — Branches Table

CREATE TABLE branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    branch_code VARCHAR(20) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    manager_name VARCHAR(100),
    contact_nloansumber VARCHAR(15),
    opening_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);

-- Step 3 — Customers Table

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10),
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    aadhaar_number VARCHAR(20) UNIQUE,
    pan_number VARCHAR(20) UNIQUE,
    registration_date DATE DEFAULT (CURRENT_DATE),
    status VARCHAR(20) DEFAULT 'Active'
);

-- Step 4 — Accounts Table

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    interest_rate DECIMAL(5,2) DEFAULT 0.00,
    opening_date DATE DEFAULT (CURRENT_DATE),
    status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

-- Step 5 — Transactions Table

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    transaction_type VARCHAR(30) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(255),
    reference_number VARCHAR(50) UNIQUE,

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);


-- Step 6 — Fund Transfers Table

CREATE TABLE fund_transfers (
    transfer_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_account_id INT NOT NULL,
    receiver_account_id INT NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    transfer_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    transfer_mode VARCHAR(30),
    transfer_status VARCHAR(20) DEFAULT 'Completed',
    reference_number VARCHAR(50) UNIQUE,

    FOREIGN KEY (sender_account_id)
        REFERENCES accounts(account_id),

    FOREIGN KEY (receiver_account_id)
        REFERENCES accounts(account_id)
);

-- Step 7 — Loans Table

CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    loan_type VARCHAR(50) NOT NULL,
    loan_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    tenure_months INT NOT NULL,
    start_date DATE,
    end_date DATE,
    loan_status VARCHAR(30) DEFAULT 'Active',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

-- Step 8 — Loan Payments Table

CREATE TABLE loan_payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(15,2) NOT NULL,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20) DEFAULT 'Paid',
    reference_number VARCHAR(50) UNIQUE,

    FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id)
);

-- Step 9 — Cards Table

CREATE TABLE cards (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    account_id INT NOT NULL,
    card_type VARCHAR(20) NOT NULL,
    card_number_masked VARCHAR(25) NOT NULL,
    issue_date DATE,
    expiry_date DATE,
    card_status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);


-- Step 10 — ATM Table

CREATE TABLE atms (
    atm_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT NOT NULL,
    atm_location VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    installation_date DATE,
    status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);


-- Step 11 — ATM Transactions Table

CREATE TABLE atm_transactions (
    atm_transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    atm_id INT NOT NULL,
    account_id INT NOT NULL,
    transaction_type VARCHAR(30) NOT NULL,
    amount DECIMAL(15,2) DEFAULT 0.00,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Successful',
    reference_number VARCHAR(50) UNIQUE,

    FOREIGN KEY (atm_id)
        REFERENCES atms(atm_id),

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);


-- Step 12 — Employees Table

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT NOT NULL,
    employee_name VARCHAR(100) NOT NULL,
    designation VARCHAR(50),
    department VARCHAR(50),
    phone_number VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    joining_date DATE,
    salary DECIMAL(12,2),
    status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

-- Step 13 — Beneficiaries Table

CREATE TABLE beneficiaries (
    beneficiary_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    beneficiary_name VARCHAR(100) NOT NULL,
    beneficiary_account_number VARCHAR(20) NOT NULL,
    beneficiary_bank_name VARCHAR(100),
    ifsc_code VARCHAR(20),
    relationship VARCHAR(50),
    added_date DATE DEFAULT (CURRENT_DATE),
    status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- Step 14 — Departments Table

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) UNIQUE NOT NULL,
    description VARCHAR(255),
    status VARCHAR(20) DEFAULT 'Active'
);

-- Step 15 — Employees Table Update

DESCRIBE employees;

-- Step 15A — Add department_id

ALTER TABLE employees
ADD COLUMN department_id INT;

-- Step 15B — Department Foreign Key

ALTER TABLE employees
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);

-- Step 16 — Insert Branch Data

INSERT INTO branches
(branch_name, branch_code, city, state, manager_name, contact_number, opening_date, status)
VALUES
('Mumbai Central Branch', 'MUM001', 'Mumbai', 'Maharashtra', 'Rahul Sharma', '9000000001', '2018-04-10', 'Active'),
('Andheri Branch', 'MUM002', 'Mumbai', 'Maharashtra', 'Priya Mehta', '9000000002', '2019-06-15', 'Active'),
('Pune Main Branch', 'PUN001', 'Pune', 'Maharashtra', 'Amit Patil', '9000000003', '2017-02-20', 'Active'),
('Nashik Branch', 'NSK001', 'Nashik', 'Maharashtra', 'Neha Joshi', '9000000004', '2020-09-12', 'Active'),
('Nagpur Branch', 'NAG001', 'Nagpur', 'Maharashtra', 'Vikas Rao', '9000000005', '2016-11-05', 'Active'),
('Thane Branch', 'THN001', 'Thane', 'Maharashtra', 'Sneha Kulkarni', '9000000006', '2021-01-18', 'Active'),
('Bandra Branch', 'MUM003', 'Mumbai', 'Maharashtra', 'Karan Shah', '9000000007', '2018-08-25', 'Active'),
('Aurangabad Branch', 'AUR001', 'Aurangabad', 'Maharashtra', 'Pooja Deshmukh', '9000000008', '2019-12-10', 'Active');

-- Step 17 — Department Data

INSERT INTO departments
(department_name, description, status)
VALUES
('Accounts', 'Handles customer accounts and financial records', 'Active'),
('Loans', 'Handles loan applications and loan management', 'Active'),
('Customer Service', 'Handles customer queries and support', 'Active'),
('Operations', 'Handles daily banking operations', 'Active'),
('IT', 'Handles banking technology and systems', 'Active'),
('Human Resources', 'Handles employee management and recruitment', 'Active'),
('Risk Management', 'Handles financial and operational risks', 'Active'),
('Audit', 'Handles internal banking audits', 'Active');

-- Step 18 — Customer Data

INSERT INTO customers
(full_name, date_of_birth, gender, phone_number, email, address, city, state, aadhaar_number, pan_number, registration_date, status)
VALUES
('Aarav Mehta', '1995-04-12', 'Male', '9100000001', 'aarav@example.com', 'MG Road', 'Mumbai', 'Maharashtra', 'DUMMYA001', 'DUMPA001', '2024-01-10', 'Active'),
('Priya Sharma', '1997-08-22', 'Female', '9100000002', 'priya@example.com', 'Andheri West', 'Mumbai', 'Maharashtra', 'DUMMYA002', 'DUMPA002', '2024-01-15', 'Active'),
('Rohan Patil', '1993-02-18', 'Male', '9100000003', 'rohan@example.com', 'Kothrud', 'Pune', 'Maharashtra', 'DUMMYA003', 'DUMPA003', '2024-02-05', 'Active'),
('Sneha Joshi', '1998-11-30', 'Female', '9100000004', 'sneha@example.com', 'College Road', 'Nashik', 'Maharashtra', 'DUMMYA004', 'DUMPA004', '2024-02-20', 'Active'),
('Vikas Rao', '1990-06-14', 'Male', '9100000005', 'vikas@example.com', 'Civil Lines', 'Nagpur', 'Maharashtra', 'DUMMYA005', 'DUMPA005', '2024-03-02', 'Active'),
('Ananya Shah', '1996-09-05', 'Female', '9100000006', 'ananya@example.com', 'Bandra West', 'Mumbai', 'Maharashtra', 'DUMMYA006', 'DUMPA006', '2024-03-18', 'Active'),
('Karan Desai', '1992-12-10', 'Male', '9100000007', 'karan@example.com', 'Thane West', 'Thane', 'Maharashtra', 'DUMMYA007', 'DUMPA007', '2024-04-01', 'Active'),
('Neha Kulkarni', '1999-03-25', 'Female', '9100000008', 'neha@example.com', 'Camp Area', 'Pune', 'Maharashtra', 'DUMMYA008', 'DUMPA008', '2024-04-15', 'Active'),
('Rahul Verma', '1994-07-19', 'Male', '9100000009', 'rahul@example.com', 'Powai', 'Mumbai', 'Maharashtra', 'DUMMYA009', 'DUMPA009', '2024-05-01', 'Active'),
('Pooja Deshmukh', '1997-01-28', 'Female', '9100000010', 'pooja@example.com', 'CIDCO', 'Aurangabad', 'Maharashtra', 'DUMMYA010', 'DUMPA010', '2024-05-16', 'Active'),
('Aditya Singh', '1991-05-16', 'Male', '9100000011', 'aditya@example.com', 'Vashi', 'Mumbai', 'Maharashtra', 'DUMMYA011', 'DUMPA011', '2024-06-05', 'Active'),
('Riya Kapoor', '1998-10-11', 'Female', '9100000012', 'riya@example.com', 'Ghatkopar', 'Mumbai', 'Maharashtra', 'DUMMYA012', 'DUMPA012', '2024-06-20', 'Active'),
('Siddharth Nair', '1989-08-07', 'Male', '9100000013', 'siddharth@example.com', 'Aundh', 'Pune', 'Maharashtra', 'DUMMYA013', 'DUMPA013', '2024-07-02', 'Active'),
('Isha Malhotra', '1996-02-14', 'Female', '9100000014', 'isha@example.com', 'Mulund', 'Mumbai', 'Maharashtra', 'DUMMYA014', 'DUMPA014', '2024-07-18', 'Active'),
('Manish Gupta', '1988-11-21', 'Male', '9100000015', 'manish@example.com', 'Nashik Road', 'Nashik', 'Maharashtra', 'DUMMYA015', 'DUMPA015', '2024-08-01', 'Active'),
('Kavya Iyer', '1995-06-03', 'Female', '9100000016', 'kavya@example.com', 'Dharampeth', 'Nagpur', 'Maharashtra', 'DUMMYA016', 'DUMPA016', '2024-08-15', 'Active'),
('Arjun Rao', '1993-09-27', 'Male', '9100000017', 'arjun@example.com', 'Dadar', 'Mumbai', 'Maharashtra', 'DUMMYA017', 'DUMPA017', '2024-09-01', 'Active'),
('Meera Patil', '1999-12-19', 'Female', '9100000018', 'meera@example.com', 'Wakad', 'Pune', 'Maharashtra', 'DUMMYA018', 'DUMPA018', '2024-09-15', 'Active'),
('Sameer Khan', '1990-04-09', 'Male', '9100000019', 'sameer@example.com', 'Kurla', 'Mumbai', 'Maharashtra', 'DUMMYA019', 'DUMPA019', '2024-10-01', 'Active'),
('Tanya Roy', '1997-07-26', 'Female', '9100000020', 'tanya@example.com', 'Vartak Nagar', 'Thane', 'Maharashtra', 'DUMMYA020', 'DUMPA020', '2024-10-15', 'Active');

-- Step 19 — Accounts Data
INSERT INTO accounts
(customer_id, branch_id, account_number, account_type, balance, interest_rate, opening_date, status)
VALUES
(1, 1, 'ACC100001', 'Savings', 85000.00, 4.00, '2024-01-12', 'Active'),
(2, 2, 'ACC100002', 'Savings', 62000.00, 4.00, '2024-01-18', 'Active'),
(3, 3, 'ACC100003', 'Current', 145000.00, 3.50, '2024-02-08', 'Active'),
(4, 4, 'ACC100004', 'Savings', 48000.00, 4.00, '2024-02-22', 'Active'),
(5, 5, 'ACC100005', 'Salary', 72000.00, 4.50, '2024-03-05', 'Active'),
(6, 7, 'ACC100006', 'Savings', 91000.00, 4.00, '2024-03-20', 'Active'),
(7, 6, 'ACC100007', 'Current', 185000.00, 3.50, '2024-04-03', 'Active'),
(8, 3, 'ACC100008', 'Savings', 56000.00, 4.00, '2024-04-18', 'Active'),
(9, 1, 'ACC100009', 'Salary', 68000.00, 4.50, '2024-05-03', 'Active'),
(10, 8, 'ACC100010', 'Savings', 43000.00, 4.00, '2024-05-18', 'Active'),
(11, 7, 'ACC100011', 'Current', 210000.00, 3.50, '2024-06-08', 'Active'),
(12, 2, 'ACC100012', 'Savings', 76000.00, 4.00, '2024-06-22', 'Active'),
(13, 3, 'ACC100013', 'Salary', 83000.00, 4.50, '2024-07-05', 'Active'),
(14, 1, 'ACC100014', 'Savings', 51000.00, 4.00, '2024-07-20', 'Active'),
(15, 4, 'ACC100015', 'Current', 132000.00, 3.50, '2024-08-03', 'Active'),
(16, 5, 'ACC100016', 'Savings', 67000.00, 4.00, '2024-08-18', 'Active'),
(17, 7, 'ACC100017', 'Salary', 95000.00, 4.50, '2024-09-03', 'Active'),
(18, 3, 'ACC100018', 'Savings', 59000.00, 4.00, '2024-09-18', 'Active'),
(19, 2, 'ACC100019', 'Current', 175000.00, 3.50, '2024-10-03', 'Active'),
(20, 6, 'ACC100020', 'Savings', 73000.00, 4.00, '2024-10-18', 'Active'),
(1, 1, 'ACC100021', 'Fixed Deposit', 250000.00, 7.00, '2024-02-15', 'Active'),
(3, 3, 'ACC100022', 'Savings', 45000.00, 4.00, '2024-05-10', 'Active'),
(6, 7, 'ACC100023', 'Current', 120000.00, 3.50, '2024-06-10', 'Active'),
(11, 7, 'ACC100024', 'Savings', 88000.00, 4.00, '2024-07-10', 'Active'),
(15, 4, 'ACC100025', 'Fixed Deposit', 300000.00, 7.00, '2024-08-10', 'Active');

SELECT * FROM accounts;

-- Step 20 — Transactions Data

INSERT INTO transactions
(account_id, transaction_type, amount, transaction_date, description, reference_number)
VALUES
(1, 'Deposit', 25000.00, '2025-01-05 10:15:00', 'Cash Deposit', 'TXN000001'),
(2, 'Withdrawal', 8000.00, '2025-01-06 12:30:00', 'ATM Withdrawal', 'TXN000002'),
(3, 'Deposit', 50000.00, '2025-01-08 11:20:00', 'Business Deposit', 'TXN000003'),
(4, 'Withdrawal', 5000.00, '2025-01-10 15:10:00', 'Cash Withdrawal', 'TXN000004'),
(5, 'Deposit', 30000.00, '2025-01-12 09:45:00', 'Salary Credit', 'TXN000005'),
(6, 'Transfer', 12000.00, '2025-01-15 14:20:00', 'Fund Transfer', 'TXN000006'),
(7, 'Deposit', 45000.00, '2025-01-18 10:30:00', 'Cash Deposit', 'TXN000007'),
(8, 'Withdrawal', 7000.00, '2025-01-20 16:15:00', 'ATM Withdrawal', 'TXN000008'),
(9, 'Deposit', 28000.00, '2025-01-22 11:00:00', 'Salary Credit', 'TXN000009'),
(10, 'Withdrawal', 6000.00, '2025-01-25 13:40:00', 'Cash Withdrawal', 'TXN000010'),
(11, 'Deposit', 60000.00, '2025-02-02 10:10:00', 'Business Deposit', 'TXN000011'),
(12, 'Transfer', 15000.00, '2025-02-05 12:25:00', 'Fund Transfer', 'TXN000012'),
(13, 'Deposit', 35000.00, '2025-02-08 09:30:00', 'Salary Credit', 'TXN000013'),
(14, 'Withdrawal', 9000.00, '2025-02-10 15:45:00', 'ATM Withdrawal', 'TXN000014'),
(15, 'Deposit', 40000.00, '2025-02-12 11:50:00', 'Cash Deposit', 'TXN000015'),
(16, 'Withdrawal', 5000.00, '2025-02-15 14:10:00', 'ATM Withdrawal', 'TXN000016'),
(17, 'Deposit', 55000.00, '2025-02-18 10:45:00', 'Salary Credit', 'TXN000017'),
(18, 'Transfer', 18000.00, '2025-02-20 13:15:00', 'Fund Transfer', 'TXN000018'),
(19, 'Deposit', 48000.00, '2025-02-22 11:35:00', 'Business Deposit', 'TXN000019'),
(20, 'Withdrawal', 7500.00, '2025-02-25 16:20:00', 'Cash Withdrawal', 'TXN000020'),
(21, 'Deposit', 100000.00, '2025-03-01 10:05:00', 'Fixed Deposit Credit', 'TXN000021'),
(22, 'Withdrawal', 4000.00, '2025-03-03 12:40:00', 'Cash Withdrawal', 'TXN000022'),
(23, 'Deposit', 30000.00, '2025-03-05 09:55:00', 'Business Deposit', 'TXN000023'),
(24, 'Transfer', 22000.00, '2025-03-08 14:30:00', 'Fund Transfer', 'TXN000024'),
(25, 'Deposit', 120000.00, '2025-03-10 10:25:00', 'Fixed Deposit Credit', 'TXN000025'),
(1, 'Withdrawal', 10000.00, '2025-03-12 15:10:00', 'ATM Withdrawal', 'TXN000026'),
(3, 'Transfer', 25000.00, '2025-03-15 11:45:00', 'Fund Transfer', 'TXN000027'),
(6, 'Deposit', 20000.00, '2025-03-18 13:20:00', 'Cash Deposit', 'TXN000028'),
(11, 'Withdrawal', 12000.00, '2025-03-20 16:00:00', 'Cash Withdrawal', 'TXN000029'),
(15, 'Deposit', 45000.00, '2025-03-22 10:50:00', 'Cash Deposit', 'TXN000030');


-- Step 21 — Fund Transfers Data

INSERT INTO fund_transfers
(sender_account_id, receiver_account_id, amount, transfer_date, transfer_mode, transfer_status, reference_number)
VALUES
(1, 2, 5000.00, '2025-01-07 10:30:00', 'UPI', 'Completed', 'TRF000001'),
(2, 3, 12000.00, '2025-01-12 11:15:00', 'NEFT', 'Completed', 'TRF000002'),
(3, 4, 25000.00, '2025-01-18 14:20:00', 'RTGS', 'Completed', 'TRF000003'),
(4, 5, 7000.00, '2025-01-22 09:45:00', 'UPI', 'Completed', 'TRF000004'),
(5, 6, 15000.00, '2025-01-28 16:10:00', 'IMPS', 'Completed', 'TRF000005'),
(6, 7, 18000.00, '2025-02-03 10:20:00', 'NEFT', 'Completed', 'TRF000006'),
(7, 8, 22000.00, '2025-02-08 13:30:00', 'RTGS', 'Completed', 'TRF000007'),
(8, 9, 6500.00, '2025-02-12 15:40:00', 'UPI', 'Completed', 'TRF000008'),
(9, 10, 9500.00, '2025-02-16 11:50:00', 'IMPS', 'Completed', 'TRF000009'),
(10, 11, 14000.00, '2025-02-20 12:15:00', 'NEFT', 'Completed', 'TRF000010'),
(11, 12, 30000.00, '2025-02-25 14:45:00', 'RTGS', 'Completed', 'TRF000011'),
(12, 13, 8500.00, '2025-03-01 10:35:00', 'UPI', 'Completed', 'TRF000012'),
(13, 14, 16000.00, '2025-03-05 13:20:00', 'IMPS', 'Completed', 'TRF000013'),
(14, 15, 11000.00, '2025-03-10 15:10:00', 'NEFT', 'Completed', 'TRF000014'),
(15, 16, 20000.00, '2025-03-15 11:25:00', 'RTGS', 'Completed', 'TRF000015'),
(16, 17, 7500.00, '2025-03-20 09:55:00', 'UPI', 'Completed', 'TRF000016'),
(17, 18, 13500.00, '2025-03-25 14:30:00', 'IMPS', 'Completed', 'TRF000017'),
(18, 19, 24000.00, '2025-04-02 12:10:00', 'NEFT', 'Completed', 'TRF000018'),
(19, 20, 17500.00, '2025-04-07 16:20:00', 'UPI', 'Completed', 'TRF000019'),
(20, 1, 9000.00, '2025-04-12 10:40:00', 'IMPS', 'Completed', 'TRF000020');

-- Step 21A — Fund Transfers Table Create

CREATE TABLE fund_transfers (
    transfer_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_account_id INT NOT NULL,
    receiver_account_id INT NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    transfer_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    transfer_mode VARCHAR(30),
    transfer_status VARCHAR(20) DEFAULT 'Completed',
    reference_number VARCHAR(50) UNIQUE,

    FOREIGN KEY (sender_account_id)
        REFERENCES accounts(account_id),

    FOREIGN KEY (receiver_account_id)
        REFERENCES accounts(account_id)
);

-- Step 21B — Fund Transfer Data

INSERT INTO fund_transfers
(sender_account_id, receiver_account_id, amount, transfer_date, transfer_mode, transfer_status, reference_number)
VALUES
(1, 2, 5000.00, '2025-01-07 10:30:00', 'UPI', 'Completed', 'TRF000001'),
(2, 3, 12000.00, '2025-01-12 11:15:00', 'NEFT', 'Completed', 'TRF000002'),
(3, 4, 25000.00, '2025-01-18 14:20:00', 'RTGS', 'Completed', 'TRF000003'),
(4, 5, 7000.00, '2025-01-22 09:45:00', 'UPI', 'Completed', 'TRF000004'),
(5, 6, 15000.00, '2025-01-28 16:10:00', 'IMPS', 'Completed', 'TRF000005'),
(6, 7, 18000.00, '2025-02-03 10:20:00', 'NEFT', 'Completed', 'TRF000006'),
(7, 8, 22000.00, '2025-02-08 13:30:00', 'RTGS', 'Completed', 'TRF000007'),
(8, 9, 6500.00, '2025-02-12 15:40:00', 'UPI', 'Completed', 'TRF000008'),
(9, 10, 9500.00, '2025-02-16 11:50:00', 'IMPS', 'Completed', 'TRF000009'),
(10, 11, 14000.00, '2025-02-20 12:15:00', 'NEFT', 'Completed', 'TRF000010'),
(11, 12, 30000.00, '2025-02-25 14:45:00', 'RTGS', 'Completed', 'TRF000011'),
(12, 13, 8500.00, '2025-03-01 10:35:00', 'UPI', 'Completed', 'TRF000012'),
(13, 14, 16000.00, '2025-03-05 13:20:00', 'IMPS', 'Completed', 'TRF000013'),
(14, 15, 11000.00, '2025-03-10 15:10:00', 'NEFT', 'Completed', 'TRF000014'),
(15, 16, 20000.00, '2025-03-15 11:25:00', 'RTGS', 'Completed', 'TRF000015'),
(16, 17, 7500.00, '2025-03-20 09:55:00', 'UPI', 'Completed', 'TRF000016'),
(17, 18, 13500.00, '2025-03-25 14:30:00', 'IMPS', 'Completed', 'TRF000017'),
(18, 19, 24000.00, '2025-04-02 12:10:00', 'NEFT', 'Completed', 'TRF000018'),
(19, 20, 17500.00, '2025-04-07 16:20:00', 'UPI', 'Completed', 'TRF000019'),
(20, 1, 9000.00, '2025-04-12 10:40:00', 'IMPS', 'Completed', 'TRF000020');

-- Step 22 — Loans Data
DESCRIBE loans;

-- Step 22 — Insert Loan Data

INSERT INTO loans
(customer_id, branch_id, loan_type, loan_amount, interest_rate, tenure_months, start_date, end_date, loan_status)
VALUES
(1, 1, 'Home Loan', 2500000.00, 8.50, 240, '2024-01-15', '2044-01-15', 'Active'),
(2, 2, 'Personal Loan', 500000.00, 11.50, 60, '2024-02-10', '2029-02-10', 'Active'),
(3, 3, 'Business Loan', 1500000.00, 10.25, 120, '2024-02-20', '2034-02-20', 'Active'),
(4, 4, 'Car Loan', 800000.00, 9.00, 84, '2024-03-05', '2031-03-05', 'Active'),
(5, 5, 'Education Loan', 600000.00, 8.00, 96, '2024-03-18', '2032-03-18', 'Active'),
(6, 7, 'Home Loan', 3200000.00, 8.25, 240, '2024-04-01', '2044-04-01', 'Active'),
(7, 6, 'Personal Loan', 750000.00, 11.00, 60, '2024-04-15', '2029-04-15', 'Active'),
(8, 3, 'Car Loan', 950000.00, 8.75, 84, '2024-05-02', '2031-05-02', 'Active'),
(9, 1, 'Business Loan', 2000000.00, 10.00, 120, '2024-05-20', '2034-05-20', 'Active'),
(10, 8, 'Education Loan', 450000.00, 7.75, 72, '2024-06-10', '2030-06-10', 'Active'),
(11, 7, 'Home Loan', 2800000.00, 8.40, 240, '2024-06-25', '2044-06-25', 'Active'),
(12, 2, 'Personal Loan', 400000.00, 11.25, 48, '2024-07-08', '2028-07-08', 'Active'),
(13, 3, 'Business Loan', 1750000.00, 10.50, 120, '2024-07-22', '2034-07-22', 'Active'),
(14, 1, 'Car Loan', 700000.00, 9.10, 84, '2024-08-05', '2031-08-05', 'Active'),
(15, 4, 'Home Loan', 2200000.00, 8.30, 180, '2024-08-20', '2039-08-20', 'Active'),
(16, 5, 'Personal Loan', 550000.00, 11.00, 60, '2024-09-10', '2029-09-10', 'Active'),
(17, 7, 'Business Loan', 1250000.00, 10.25, 120, '2024-09-25', '2034-09-25', 'Active'),
(18, 3, 'Education Loan', 500000.00, 7.90, 84, '2024-10-05', '2031-10-05', 'Active'),
(19, 2, 'Car Loan', 900000.00, 8.90, 84, '2024-10-20', '2031-10-20', 'Active'),
(20, 6, 'Home Loan', 3000000.00, 8.45, 240, '2024-11-05', '2044-11-05', 'Active');

-- Step 23 — Loan Payments
DESCRIBE loan_payments;

-- Step 23 — Insert Loan Payments 

INSERT INTO loan_payments
(loan_id, payment_date, payment_amount, payment_method, payment_status, reference_number)
VALUES
(1, '2025-01-10', 25000.00, 'Bank Transfer', 'Paid', 'LP000001'),
(2, '2025-01-12', 11000.00, 'UPI', 'Paid', 'LP000002'),
(3, '2025-01-15', 22000.00, 'Bank Transfer', 'Paid', 'LP000003'),
(4, '2025-01-18', 14500.00, 'Auto Debit', 'Paid', 'LP000004'),
(5, '2025-01-20', 8500.00, 'UPI', 'Paid', 'LP000005'),
(6, '2025-01-25', 28000.00, 'Bank Transfer', 'Paid', 'LP000006'),
(7, '2025-02-02', 16500.00, 'Auto Debit', 'Paid', 'LP000007'),
(8, '2025-02-05', 15500.00, 'UPI', 'Paid', 'LP000008'),
(9, '2025-02-08', 26500.00, 'Bank Transfer', 'Paid', 'LP000009'),
(10, '2025-02-12', 7500.00, 'UPI', 'Paid', 'LP000010'),
(11, '2025-02-15', 26000.00, 'Auto Debit', 'Paid', 'LP000011'),
(12, '2025-02-18', 12000.00, 'Bank Transfer', 'Paid', 'LP000012'),
(13, '2025-02-22', 24000.00, 'UPI', 'Paid', 'LP000013'),
(14, '2025-02-25', 13500.00, 'Auto Debit', 'Paid', 'LP000014'),
(15, '2025-03-02', 23500.00, 'Bank Transfer', 'Paid', 'LP000015'),
(16, '2025-03-05', 12500.00, 'UPI', 'Paid', 'LP000016'),
(17, '2025-03-08', 21000.00, 'Bank Transfer', 'Paid', 'LP000017'),
(18, '2025-03-12', 9000.00, 'Auto Debit', 'Paid', 'LP000018'),
(19, '2025-03-15', 15000.00, 'UPI', 'Paid', 'LP000019'),
(20, '2025-03-18', 27000.00, 'Bank Transfer', 'Paid', 'LP000020');

SELECT * FROM loan_payments;

-- Step 24 — Cards

DESCRIBE cards;

-- Step 24 — Insert Card Data

INSERT INTO cards
(customer_id, account_id, card_type, card_number_masked, issue_date, expiry_date, card_status)
VALUES
(1, 1, 'Debit', 'XXXX-XXXX-XXXX-1001', '2024-01-20', '2029-01-20', 'Active'),
(2, 2, 'Debit', 'XXXX-XXXX-XXXX-1002', '2024-01-25', '2029-01-25', 'Active'),
(3, 3, 'Credit', 'XXXX-XXXX-XXXX-1003', '2024-02-15', '2029-02-15', 'Active'),
(4, 4, 'Debit', 'XXXX-XXXX-XXXX-1004', '2024-02-28', '2029-02-28', 'Active'),
(5, 5, 'Debit', 'XXXX-XXXX-XXXX-1005', '2024-03-10', '2029-03-10', 'Active'),
(6, 6, 'Credit', 'XXXX-XXXX-XXXX-1006', '2024-03-25', '2029-03-25', 'Active'),
(7, 7, 'Debit', 'XXXX-XXXX-XXXX-1007', '2024-04-10', '2029-04-10', 'Active'),
(8, 8, 'Debit', 'XXXX-XXXX-XXXX-1008', '2024-04-25', '2029-04-25', 'Active'),
(9, 9, 'Credit', 'XXXX-XXXX-XXXX-1009', '2024-05-10', '2029-05-10', 'Active'),
(10, 10, 'Debit', 'XXXX-XXXX-XXXX-1010', '2024-05-25', '2029-05-25', 'Active'),
(11, 11, 'Debit', 'XXXX-XXXX-XXXX-1011', '2024-06-15', '2029-06-15', 'Active'),
(12, 12, 'Credit', 'XXXX-XXXX-XXXX-1012', '2024-06-28', '2029-06-28', 'Active'),
(13, 13, 'Debit', 'XXXX-XXXX-XXXX-1013', '2024-07-12', '2029-07-12', 'Active'),
(14, 14, 'Debit', 'XXXX-XXXX-XXXX-1014', '2024-07-28', '2029-07-28', 'Active'),
(15, 15, 'Credit', 'XXXX-XXXX-XXXX-1015', '2024-08-12', '2029-08-12', 'Active'),
(16, 16, 'Debit', 'XXXX-XXXX-XXXX-1016', '2024-08-28', '2029-08-28', 'Active'),
(17, 17, 'Debit', 'XXXX-XXXX-XXXX-1017', '2024-09-12', '2029-09-12', 'Active'),
(18, 18, 'Credit', 'XXXX-XXXX-XXXX-1018', '2024-09-28', '2029-09-28', 'Active'),
(19, 19, 'Debit', 'XXXX-XXXX-XXXX-1019', '2024-10-12', '2029-10-12', 'Active'),
(20, 20, 'Debit', 'XXXX-XXXX-XXXX-1020', '2024-10-28', '2029-10-28', 'Active');

SELECT * FROM cards;

-- Step 25 — ATM Table
DESCRIBE atms;

-- Step 25 — ATM Data

INSERT INTO atms
(branch_id, atm_location, city, installation_date, status)
VALUES
(1, 'Mumbai Central Railway Road', 'Mumbai', '2022-01-15', 'Active'),
(1, 'MG Road Shopping Complex', 'Mumbai', '2022-06-20', 'Active'),
(2, 'Andheri West Metro Station', 'Mumbai', '2022-03-10', 'Active'),
(2, 'Andheri Market Area', 'Mumbai', '2023-01-25', 'Active'),
(3, 'Kothrud Main Road', 'Pune', '2022-08-12', 'Active'),
(3, 'Pune Camp Area', 'Pune', '2023-04-18', 'Active'),
(4, 'College Road', 'Nashik', '2022-11-05', 'Active'),
(5, 'Civil Lines', 'Nagpur', '2023-02-14', 'Active'),
(6, 'Thane West Station Road', 'Thane', '2023-05-20', 'Active'),
(7, 'Bandra Linking Road', 'Mumbai', '2023-07-10', 'Active');

SELECT * FROM atms;

-- Step 26 — ATM Transactions

DESCRIBE atm_transactions;

-- Step 26 — ATM Transactions

INSERT INTO atm_transactions
(atm_id, account_id, transaction_type, amount, transaction_date, status, reference_number)
VALUES
(1, 1, 'Withdrawal', 5000.00, '2025-01-05 10:15:00', 'Successful', 'ATM000001'),
(2, 2, 'Withdrawal', 8000.00, '2025-01-08 12:30:00', 'Successful', 'ATM000002'),
(3, 3, 'Deposit', 15000.00, '2025-01-12 11:20:00', 'Successful', 'ATM000003'),
(4, 4, 'Withdrawal', 4000.00, '2025-01-15 15:10:00', 'Successful', 'ATM000004'),
(5, 5, 'Balance Inquiry', 0.00, '2025-01-18 09:45:00', 'Successful', 'ATM000005'),
(6, 6, 'Withdrawal', 10000.00, '2025-01-20 14:20:00', 'Successful', 'ATM000006'),
(7, 7, 'Deposit', 20000.00, '2025-01-25 10:30:00', 'Successful', 'ATM000007'),
(8, 8, 'Withdrawal', 6000.00, '2025-02-02 16:15:00', 'Successful', 'ATM000008'),
(9, 9, 'Withdrawal', 7500.00, '2025-02-05 11:00:00', 'Successful', 'ATM000009'),
(10, 10, 'Balance Inquiry', 0.00, '2025-02-08 13:40:00', 'Successful', 'ATM000010'),
(1, 11, 'Withdrawal', 12000.00, '2025-02-12 10:10:00', 'Successful', 'ATM000011'),
(2, 12, 'Deposit', 18000.00, '2025-02-15 12:25:00', 'Successful', 'ATM000012'),
(3, 13, 'Withdrawal', 9000.00, '2025-02-18 14:30:00', 'Successful', 'ATM000013'),
(4, 14, 'Balance Inquiry', 0.00, '2025-02-20 15:45:00', 'Successful', 'ATM000014'),
(5, 15, 'Withdrawal', 6500.00, '2025-02-25 11:50:00', 'Successful', 'ATM000015'),
(6, 16, 'Deposit', 25000.00, '2025-03-01 09:30:00', 'Successful', 'ATM000016'),
(7, 17, 'Withdrawal', 11000.00, '2025-03-05 13:15:00', 'Successful', 'ATM000017'),
(8, 18, 'Withdrawal', 5500.00, '2025-03-08 16:20:00', 'Successful', 'ATM000018'),
(9, 19, 'Deposit', 22000.00, '2025-03-12 10:40:00', 'Successful', 'ATM000019'),
(10, 20, 'Balance Inquiry', 0.00, '2025-03-15 12:10:00', 'Successful', 'ATM000020'),
(1, 21, 'Withdrawal', 15000.00, '2025-03-18 14:25:00', 'Successful', 'ATM000021'),
(3, 22, 'Deposit', 17000.00, '2025-03-20 11:35:00', 'Successful', 'ATM000022'),
(5, 23, 'Withdrawal', 7000.00, '2025-03-22 15:00:00', 'Successful', 'ATM000023'),
(7, 24, 'Withdrawal', 8500.00, '2025-03-25 10:50:00', 'Successful', 'ATM000024'),
(9, 25, 'Deposit', 30000.00, '2025-03-28 13:20:00', 'Successful', 'ATM000025');

-- Step 27 — Beneficiaries

DESCRIBE beneficiaries;

-- Step 27 — Beneficiary Data

INSERT INTO beneficiaries
(customer_id, beneficiary_name, beneficiary_account_number, beneficiary_bank_name, ifsc_code, relationship, added_date, status)
VALUES
(1, 'Rahul Mehta', 'BENACC10001', 'ABC Bank', 'ABCB0001001', 'Brother', '2025-01-05', 'Active'),
(2, 'Neha Sharma', 'BENACC10002', 'XYZ Bank', 'XYZB0001002', 'Sister', '2025-01-08', 'Active'),
(3, 'Amit Patil', 'BENACC10003', 'National Bank', 'NATB0001003', 'Friend', '2025-01-12', 'Active'),
(4, 'Snehal Joshi', 'BENACC10004', 'City Bank', 'CITY0001004', 'Sister', '2025-01-15', 'Active'),
(5, 'Vikas Rao', 'BENACC10005', 'ABC Bank', 'ABCB0001005', 'Father', '2025-01-18', 'Active'),
(6, 'Ananya Shah', 'BENACC10006', 'XYZ Bank', 'XYZB0001006', 'Friend', '2025-01-20', 'Active'),
(7, 'Karan Desai', 'BENACC10007', 'National Bank', 'NATB0001007', 'Brother', '2025-01-25', 'Active'),
(8, 'Pooja Kulkarni', 'BENACC10008', 'City Bank', 'CITY0001008', 'Mother', '2025-02-02', 'Active'),
(9, 'Riya Verma', 'BENACC10009', 'ABC Bank', 'ABCB0001009', 'Friend', '2025-02-05', 'Active'),
(10, 'Aditya Singh', 'BENACC10010', 'XYZ Bank', 'XYZB0001010', 'Brother', '2025-02-08', 'Active'),
(11, 'Meera Kapoor', 'BENACC10011', 'National Bank', 'NATB0001011', 'Sister', '2025-02-12', 'Active'),
(12, 'Siddharth Nair', 'BENACC10012', 'City Bank', 'CITY0001012', 'Friend', '2025-02-15', 'Active'),
(13, 'Isha Malhotra', 'BENACC10013', 'ABC Bank', 'ABCB0001013', 'Mother', '2025-02-18', 'Active'),
(14, 'Arjun Rao', 'BENACC10014', 'XYZ Bank', 'XYZB0001014', 'Father', '2025-02-20', 'Active'),
(15, 'Kavya Iyer', 'BENACC10015', 'National Bank', 'NATB0001015', 'Sister', '2025-02-25', 'Active'),
(16, 'Manish Gupta', 'BENACC10016', 'City Bank', 'CITY0001016', 'Friend', '2025-03-01', 'Active'),
(17, 'Meera Patil', 'BENACC10017', 'ABC Bank', 'ABCB0001017', 'Mother', '2025-03-05', 'Active'),
(18, 'Sameer Khan', 'BENACC10018', 'XYZ Bank', 'XYZB0001018', 'Brother', '2025-03-08', 'Active'),
(19, 'Tanya Roy', 'BENACC10019', 'National Bank', 'NATB0001019', 'Friend', '2025-03-12', 'Active'),
(20, 'Aarav Shah', 'BENACC10020', 'City Bank', 'CITY0001020', 'Father', '2025-03-15', 'Active');

SELECT * FROM beneficiaries;


-- Step 28 — Employees
DESCRIBE employees;

-- Step 28 — Employees Data

INSERT INTO employees
(branch_id, employee_name, designation, department, phone_number, email, joining_date, salary, status, department_id)
VALUES
(1, 'Rahul Sharma', 'Branch Manager', 'Management', '9876500001', 'rahul.sharma@bank.com', '2021-04-12', 85000.00, 'Active', 1),
(1, 'Priya Mehta', 'Relationship Manager', 'Customer Service', '9876500002', 'priya.mehta@bank.com', '2022-06-15', 62000.00, 'Active', 2),
(2, 'Amit Patil', 'Assistant Manager', 'Loans', '9876500003', 'amit.patil@bank.com', '2021-08-20', 70000.00, 'Active', 3),
(2, 'Neha Shah', 'Loan Officer', 'Loans', '9876500004', 'neha.shah@bank.com', '2023-01-10', 55000.00, 'Active', 3),
(3, 'Vikas Rao', 'Cashier', 'Operations', '9876500005', 'vikas.rao@bank.com', '2022-03-18', 42000.00, 'Active', 4),
(3, 'Sneha Joshi', 'Accountant', 'Finance', '9876500006', 'sneha.joshi@bank.com', '2021-11-05', 58000.00, 'Active', 5),
(4, 'Karan Desai', 'Branch Manager', 'Management', '9876500007', 'karan.desai@bank.com', '2020-07-15', 90000.00, 'Active', 1),
(4, 'Pooja Kulkarni', 'Customer Executive', 'Customer Service', '9876500008', 'pooja.kulkarni@bank.com', '2023-02-20', 38000.00, 'Active', 2),
(5, 'Aditya Singh', 'Loan Officer', 'Loans', '9876500009', 'aditya.singh@bank.com', '2022-09-12', 52000.00, 'Active', 3),
(5, 'Riya Verma', 'Cashier', 'Operations', '9876500010', 'riya.verma@bank.com', '2023-04-10', 40000.00, 'Active', 4),
(6, 'Sameer Khan', 'IT Officer', 'IT', '9876500011', 'sameer.khan@bank.com', '2021-05-22', 68000.00, 'Active', 6),
(6, 'Meera Kapoor', 'HR Executive', 'Human Resources', '9876500012', 'meera.kapoor@bank.com', '2022-10-15', 48000.00, 'Active', 7),
(7, 'Arjun Nair', 'Branch Manager', 'Management', '9876500013', 'arjun.nair@bank.com', '2020-12-01', 88000.00, 'Active', 1),
(7, 'Isha Malhotra', 'Security Officer', 'Security', '9876500014', 'isha.malhotra@bank.com', '2023-06-18', 45000.00, 'Active', 8),
(8, 'Manish Gupta', 'Accountant', 'Finance', '9876500015', 'manish.gupta@bank.com', '2021-09-08', 60000.00, 'Active', 5),
(8, 'Tanya Roy', 'Customer Executive', 'Customer Service', '9876500016', 'tanya.roy@bank.com', '2022-12-10', 39000.00, 'Active', 2),
(1, 'Siddharth Nair', 'IT Officer', 'IT', '9876500017', 'siddharth.nair@bank.com', '2023-03-15', 65000.00, 'Active', 6),
(2, 'Kavya Iyer', 'HR Executive', 'Human Resources', '9876500018', 'kavya.iyer@bank.com', '2023-07-05', 47000.00, 'Active', 7),
(3, 'Manoj Joshi', 'Security Officer', 'Security', '9876500019', 'manoj.joshi@bank.com', '2022-05-12', 44000.00, 'Active', 8),
(4, 'Ananya Shah', 'Operations Officer', 'Operations', '9876500020', 'ananya.shah@bank.com', '2024-01-08', 46000.00, 'Active', 4);

SELECT * FROM employees;

SELECT COUNT(*) AS total_atms FROM atms;

SELECT COUNT(*) AS total_beneficiaries FROM beneficiaries;

SELECT COUNT(*) AS total_employees FROM employees;

-- Step 29 — Banking Analysis

CREATE VIEW customer_account_summary AS
SELECT
    c.customer_id,
    c.full_name,
    a.account_id,
    a.account_number,
    a.account_type,
    a.balance,
    a.interest_rate,
    a.status AS account_status
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id;

SELECT * FROM customer_account_summary;
-- Step 30 — Loan Summary View

CREATE VIEW loan_summary AS
SELECT
    l.loan_id,
    c.customer_id,
    c.full_name,
    l.loan_type,
    l.loan_amount,
    l.interest_rate,
    l.tenure_months,
    l.start_date,
    l.end_date,
    l.loan_status
FROM loans l
JOIN customers c
    ON l.customer_id = c.customer_id;
    
SELECT * FROM loan_summary;

-- Step 31 — Transaction Summary View

DESCRIBE transactions;

CREATE VIEW transaction_summary AS
SELECT
    t.transaction_id,
    c.customer_id,
    c.full_name,
    a.account_id,
    a.account_number,
    a.account_type,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.description,
    t.reference_number
FROM transactions t
JOIN accounts a
    ON t.account_id = a.account_id
JOIN customers c
    ON a.customer_id = c.customer_id;

SELECT * FROM transaction_summary;

-- Step 32 — Fund Transfer Summary View

CREATE VIEW fund_transfer_summary AS
SELECT
    f.transfer_id,
    f.sender_account_id,
    sender.full_name AS sender_name,
    sender_acc.account_number AS sender_account_number,
    f.receiver_account_id,
    receiver.full_name AS receiver_name,
    receiver_acc.account_number AS receiver_account_number,
    f.amount,
    f.transfer_date,
    f.transfer_mode,
    f.transfer_status,
    f.reference_number
FROM fund_transfers f
JOIN accounts sender_acc
    ON f.sender_account_id = sender_acc.account_id
JOIN customers sender
    ON sender_acc.customer_id = sender.customer_id
JOIN accounts receiver_acc
    ON f.receiver_account_id = receiver_acc.account_id
JOIN customers receiver
    ON receiver_acc.customer_id = receiver.customer_id;

SELECT * FROM fund_transfer_summary;

-- Step 33 — ATM Transaction Summary View

CREATE VIEW atm_transaction_summary AS
SELECT
    at.atm_transaction_id,
    at.atm_id,
    a.atm_location,
    a.city,
    at.account_id,
    c.full_name,
    acc.account_number,
    acc.account_type,
    at.transaction_type,
    at.amount,
    at.transaction_date,
    at.status,
    at.reference_number
FROM atm_transactions at
JOIN atms a
    ON at.atm_id = a.atm_id
JOIN accounts acc
    ON at.account_id = acc.account_id
JOIN customers c
    ON acc.customer_id = c.customer_id;
    
SELECT * FROM atm_transaction_summary;

-- Step 34 — Card Summary View

CREATE VIEW card_summary AS
SELECT
    cd.card_id,
    c.customer_id,
    c.full_name,
    acc.account_id,
    acc.account_number,
    acc.account_type,
    cd.card_type,
    cd.card_number_masked,
    cd.issue_date,
    cd.expiry_date,
    cd.card_status
FROM cards cd
JOIN customers c
    ON cd.customer_id = c.customer_id
JOIN accounts acc
    ON cd.account_id = acc.account_id;
    
SELECT * FROM card_summary;

DESCRIBE branches;

-- Step 35 — Branch Performance View

CREATE VIEW branch_performance AS
SELECT
    b.branch_id,
    b.branch_name,
    b.branch_code,
    b.city,
    b.state,
    b.manager_name,
    COUNT(DISTINCT a.customer_id) AS total_customers,
    COUNT(a.account_id) AS total_accounts,
    COALESCE(SUM(a.balance), 0) AS total_balance
FROM branches b
LEFT JOIN accounts a
    ON b.branch_id = a.branch_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.branch_code,
    b.city,
    b.state,
    b.manager_name;
    
SELECT * FROM branch_performance;

-- Step 36 — Department Employee Summary
DESCRIBE departments;

CREATE VIEW department_employee_summary AS
SELECT
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    COALESCE(SUM(e.salary), 0) AS total_salary,
    COALESCE(AVG(e.salary), 0) AS average_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY
    d.department_id,
    d.department_name;
    
SELECT * FROM department_employee_summary;

-- Step 37 — Loan Payment Summary

DESCRIBE loan_payments;

CREATE VIEW loan_payment_summary AS
SELECT
    l.loan_id,
    c.customer_id,
    c.full_name,
    l.loan_type,
    l.loan_amount,
    COUNT(lp.payment_id) AS total_payments,
    COALESCE(SUM(lp.payment_amount), 0) AS total_paid,
    (l.loan_amount - COALESCE(SUM(lp.payment_amount), 0)) AS remaining_amount,
    l.loan_status
FROM loans l
JOIN customers c
    ON l.customer_id = c.customer_id
LEFT JOIN loan_payments lp
    ON l.loan_id = lp.loan_id
GROUP BY
    l.loan_id,
    c.customer_id,
    c.full_name,
    l.loan_type,
    l.loan_amount,
    l.loan_status;

SELECT * FROM loan_payment_summary;

-- Step 38 — Customer Financial Summary

CREATE VIEW customer_financial_summary AS
SELECT
    c.customer_id,
    c.full_name,
    COUNT(DISTINCT a.account_id) AS total_accounts,
    COALESCE(SUM(DISTINCT a.balance), 0) AS total_account_balance,
    COUNT(DISTINCT l.loan_id) AS total_loans,
    COALESCE(SUM(DISTINCT l.loan_amount), 0) AS total_loan_amount
FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id
LEFT JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.full_name;

SELECT * FROM customer_financial_summary;

-- Step 39 — Banking Dashboard Queries

SELECT
    customer_id,
    full_name,
    total_accounts,
    total_account_balance
FROM customer_financial_summary
ORDER BY total_account_balance DESC
LIMIT 5;

-- Step 40 — Top 5 Customers by Loan Amount

SELECT
    customer_id,
    full_name,
    total_loans,
    total_loan_amount
FROM customer_financial_summary
ORDER BY total_loan_amount DESC
LIMIT 5;

-- Step 41 — Loan Type Analysis

SELECT
    loan_type,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount,
    AVG(loan_amount) AS average_loan_amount
FROM loans
GROUP BY loan_type
ORDER BY total_loan_amount DESC;

-- Step 42 — Transaction Type Analysis

SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;

-- Step 43 — Fund Transfer Mode Analysis

SELECT
    transfer_mode,
    COUNT(*) AS total_transfers,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM fund_transfers
GROUP BY transfer_mode
ORDER BY total_amount DESC;


-- Step 44 — ATM Transaction Analysis

SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM atm_transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;

-- Step 45 — Branch-wise Account Balance Analysis

SELECT
    branch_name,
    city,
    total_accounts,
    total_customers,
    total_balance
FROM branch_performance
ORDER BY total_balance DESC;

-- Step 46 — Department Salary Analysis

SELECT
    department_name,
    total_employees,
    total_salary,
    average_salary
FROM department_employee_summary
ORDER BY total_salary DESC;

-- Step 47 — Loan Payment Analysis

SELECT
    loan_type,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount,
    SUM(total_paid) AS total_paid,
    SUM(remaining_amount) AS total_remaining
FROM loan_payment_summary
GROUP BY loan_type
ORDER BY total_loan_amount DESC;

-- Step 48 — Customer Account Balance Ranking

SELECT
    customer_id,
    full_name,
    total_accounts,
    total_account_balance,
    RANK() OVER (ORDER BY total_account_balance DESC) AS balance_rank
FROM customer_financial_summary
ORDER BY balance_rank;

-- Step 49 — Loan Amount Ranking

SELECT
    customer_id,
    full_name,
    total_loans,
    total_loan_amount,
    RANK() OVER (
        ORDER BY total_loan_amount DESC
    ) AS loan_rank
FROM customer_financial_summary
ORDER BY loan_rank;

-- Step 50 — Customer Loan Procedure
DROP PROCEDURE IF EXISTS GetCustomerLoans;

DELIMITER $$

CREATE PROCEDURE GetCustomerLoans(IN p_customer_id INT)
BEGIN
    SELECT
        loan_id,
        customer_id,
        loan_type,
        loan_amount,
        interest_rate,
        tenure_months,
        start_date,
        end_date,
        loan_status
    FROM loans
    WHERE customer_id = p_customer_id;
END $$

DELIMITER ;

USE banking_system;

SELECT *
FROM loans
WHERE customer_id = 1;

CALL GetCustomerLoans(1);

SELECT COUNT(*) AS total_loans
FROM loans;

SELECT * FROM loans;

SHOW PROCEDURE STATUS
WHERE Db = 'banking_system';

SHOW CREATE PROCEDURE GetCustomerLoans;

USE banking_system;
SELECT * FROM loans WHERE customer_id = 1;
CALL GetCustomerLoans(1);

USE banking_system;

CALL GetCustomerLoans(1);

SELECT *
FROM loans
WHERE customer_id = 1;

-- Step 51 — Duplicate Loan Check

SELECT
    customer_id,
    branch_id,
    loan_type,
    loan_amount,
    interest_rate,
    tenure_months,
    start_date,
    end_date,
    loan_status,
    COUNT(*) AS duplicate_count
FROM loans
GROUP BY
    customer_id,
    branch_id,
    loan_type,
    loan_amount,
    interest_rate,
    tenure_months,
    start_date,
    end_date,
    loan_status
HAVING COUNT(*) > 1;


--  Customer Loan Count Procedure
DROP PROCEDURE IF EXISTS GetCustomerLoanCount;

DELIMITER $$

CREATE PROCEDURE GetCustomerLoanCount(IN p_customer_id INT)
BEGIN
    SELECT
        customer_id,
        COUNT(*) AS total_loans
    FROM loans
    WHERE customer_id = p_customer_id
    GROUP BY customer_id;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerLoanCount(1);

-- Step 52 — Customer Loan Amount Procedure

DROP PROCEDURE IF EXISTS GetCustomerLoanAmount;

DELIMITER $$

CREATE PROCEDURE GetCustomerLoanAmount(IN p_customer_id INT)
BEGIN
    SELECT
        customer_id,
        SUM(loan_amount) AS total_loan_amount
    FROM loans
    WHERE customer_id = p_customer_id
    GROUP BY customer_id;
END $$

DELIMITER ;
CALL GetCustomerLoanAmount(1);

-- Step 53 — Customer Account Count Procedure

DROP PROCEDURE IF EXISTS GetCustomerAccountCount;

DELIMITER $$

CREATE PROCEDURE GetCustomerAccountCount(IN p_customer_id INT)
BEGIN
    SELECT
        customer_id,
        COUNT(*) AS total_accounts
    FROM accounts
    WHERE customer_id = p_customer_id
    GROUP BY customer_id;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerAccountCount(1);

-- Step 54 — Customer Total Balance Procedure

DROP PROCEDURE IF EXISTS GetCustomerBalance;

DELIMITER $$

CREATE PROCEDURE GetCustomerBalance(IN p_customer_id INT)
BEGIN
    SELECT
        customer_id,
        SUM(balance) AS total_balance
    FROM accounts
    WHERE customer_id = p_customer_id
    GROUP BY customer_id;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerBalance(1);

-- Step 55 — Customer Full Financial Summary Procedure

DROP PROCEDURE IF EXISTS GetCustomerFinancialSummary;

DELIMITER $$

CREATE PROCEDURE GetCustomerFinancialSummary(IN p_customer_id INT)
BEGIN
    SELECT
        c.customer_id,
        c.full_name,
        COUNT(DISTINCT a.account_id) AS total_accounts,
        COALESCE(SUM(DISTINCT a.balance), 0) AS total_balance,
        COUNT(DISTINCT l.loan_id) AS total_loans,
        COALESCE(SUM(DISTINCT l.loan_amount), 0) AS total_loan_amount
    FROM customers c
    LEFT JOIN accounts a
        ON c.customer_id = a.customer_id
    LEFT JOIN loans l
        ON c.customer_id = l.customer_id
    WHERE c.customer_id = p_customer_id
    GROUP BY
        c.customer_id,
        c.full_name;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerFinancialSummary(1);

-- Step 56 — Customer Transaction History Procedure

DROP PROCEDURE IF EXISTS GetCustomerTransactions;

DELIMITER $$

CREATE PROCEDURE GetCustomerTransactions(IN p_customer_id INT)
BEGIN
    SELECT
        t.transaction_id,
        c.customer_id,
        c.full_name,
        a.account_number,
        a.account_type,
        t.transaction_type,
        t.amount,
        t.transaction_date,
        t.description,
        t.reference_number
    FROM transactions t
    JOIN accounts a
        ON t.account_id = a.account_id
    JOIN customers c
        ON a.customer_id = c.customer_id
    WHERE c.customer_id = p_customer_id
    ORDER BY t.transaction_date;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerTransactions(1);

-- Step 57 — Customer Fund Transfer History

DROP PROCEDURE IF EXISTS GetCustomerTransfers;

DELIMITER $$

CREATE PROCEDURE GetCustomerTransfers(IN p_customer_id INT)
BEGIN
    SELECT
        f.transfer_id,
        f.sender_account_id,
        sender.full_name AS sender_name,
        sender_acc.account_number AS sender_account_number,
        f.receiver_account_id,
        receiver.full_name AS receiver_name,
        receiver_acc.account_number AS receiver_account_number,
        f.amount,
        f.transfer_date,
        f.transfer_mode,
        f.transfer_status,
        f.reference_number
    FROM fund_transfers f
    JOIN accounts sender_acc
        ON f.sender_account_id = sender_acc.account_id
    JOIN customers sender
        ON sender_acc.customer_id = sender.customer_id
    JOIN accounts receiver_acc
        ON f.receiver_account_id = receiver_acc.account_id
    JOIN customers receiver
        ON receiver_acc.customer_id = receiver.customer_id
    WHERE sender.customer_id = p_customer_id
       OR receiver.customer_id = p_customer_id
    ORDER BY f.transfer_date;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerTransfers(1);

-- Step 58 — Customer Loan Payments Procedure

DROP PROCEDURE IF EXISTS GetCustomerLoanPayments;

DELIMITER $$

CREATE PROCEDURE GetCustomerLoanPayments(IN p_customer_id INT)
BEGIN
    SELECT
        lp.payment_id,
        l.loan_id,
        c.customer_id,
        c.full_name,
        l.loan_type,
        l.loan_amount,
        lp.payment_date,
        lp.payment_amount,
        lp.payment_method,
        lp.payment_status,
        lp.reference_number
    FROM loan_payments lp
    JOIN loans l
        ON lp.loan_id = l.loan_id
    JOIN customers c
        ON l.customer_id = c.customer_id
    WHERE c.customer_id = p_customer_id
    ORDER BY lp.payment_date;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerLoanPayments(1);

-- Step 59 — Customer Card Details Procedure

DROP PROCEDURE IF EXISTS GetCustomerCards;

DELIMITER $$

CREATE PROCEDURE GetCustomerCards(IN p_customer_id INT)
BEGIN
    SELECT
        cd.card_id,
        c.customer_id,
        c.full_name,
        acc.account_number,
        acc.account_type,
        cd.card_type,
        cd.card_number_masked,
        cd.issue_date,
        cd.expiry_date,
        cd.card_status
    FROM cards cd
    JOIN customers c
        ON cd.customer_id = c.customer_id
    JOIN accounts acc
        ON cd.account_id = acc.account_id
    WHERE c.customer_id = p_customer_id
    ORDER BY cd.card_id;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerCards(1);

-- Step 60 — Customer ATM Transaction History

DROP PROCEDURE IF EXISTS GetCustomerATMTransactions;

DELIMITER $$

CREATE PROCEDURE GetCustomerATMTransactions(IN p_customer_id INT)
BEGIN
    SELECT
        at.atm_transaction_id,
        c.customer_id,
        c.full_name,
        at.atm_id,
        atm.atm_location,
        atm.city,
        acc.account_number,
        at.transaction_type,
        at.amount,
        at.transaction_date,
        at.status,
        at.reference_number
    FROM atm_transactions at
    JOIN accounts acc
        ON at.account_id = acc.account_id
    JOIN customers c
        ON acc.customer_id = c.customer_id
    JOIN atms atm
        ON at.atm_id = atm.atm_id
    WHERE c.customer_id = p_customer_id
    ORDER BY at.transaction_date;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerATMTransactions(1);

-- Step 61 — Customer Beneficiary Procedure

DROP PROCEDURE IF EXISTS GetCustomerBeneficiaries;

DELIMITER $$

CREATE PROCEDURE GetCustomerBeneficiaries(IN p_customer_id INT)
BEGIN
    SELECT
        beneficiary_id,
        customer_id,
        beneficiary_name,
        beneficiary_account_number,
        beneficiary_bank_name,
        ifsc_code,
        relationship,
        added_date,
        status
    FROM beneficiaries
    WHERE customer_id = p_customer_id
    ORDER BY beneficiary_id;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerBeneficiaries(1);

-- Step 62 — Customer Branch Details Procedure

DROP PROCEDURE IF EXISTS GetCustomerBranchDetails;

DELIMITER $$

CREATE PROCEDURE GetCustomerBranchDetails(IN p_customer_id INT)
BEGIN
    SELECT DISTINCT
        c.customer_id,
        c.full_name,
        b.branch_id,
        b.branch_name,
        b.branch_code,
        b.city,
        b.state,
        b.manager_name,
        b.contact_number,
        b.status
    FROM customers c
    JOIN accounts a
        ON c.customer_id = a.customer_id
    JOIN branches b
        ON a.branch_id = b.branch_id
    WHERE c.customer_id = p_customer_id
    ORDER BY b.branch_id;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerBranchDetails(1);

-- Step 63 — Customer Complete Profile Procedure

DROP PROCEDURE IF EXISTS GetCustomerProfile;

DELIMITER $$

CREATE PROCEDURE GetCustomerProfile(IN p_customer_id INT)
BEGIN
    SELECT
        c.customer_id,
        c.full_name,
        c.date_of_birth,
        c.gender,
        c.phone_number,
        c.email,
        c.address,
        c.city,
        c.state,
        c.registration_date,
        c.status AS customer_status,
        a.account_id,
        a.account_number,
        a.account_type,
        a.balance,
        a.interest_rate,
        a.opening_date,
        a.status AS account_status
    FROM customers c
    LEFT JOIN accounts a
        ON c.customer_id = a.customer_id
    WHERE c.customer_id = p_customer_id
    ORDER BY a.account_id;
END $$

DELIMITER ;
USE banking_system;

CALL GetCustomerProfile(1);
