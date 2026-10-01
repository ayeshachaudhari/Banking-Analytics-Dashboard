# Banking-Analytics-Dashboard
Banking Analytics project using SQL and Power BI

BANKING SYSTEM DATABASE
=======================

A MySQL relational database schema for a retail banking system, covering branches, customers, accounts, transactions, fund transfers, loans, cards, ATMs, employees, and beneficiaries - plus a set of analytical views, dashboard queries, and stored procedures.


OVERVIEW
--------

This SQL script (banking_system.sql) creates a complete banking_system database, populates it with sample data, and adds reporting views and stored procedures for common banking queries (customer profiles, transaction history, loan summaries, etc.).


TABLES
------

branches            - Bank branch details (name, code, city, manager, status)
customers           - Customer personal and KYC information (Aadhaar, PAN, contact details)
accounts            - Customer bank accounts, linked to a customer and branch
transactions        - Deposits, withdrawals, and other account transactions
fund_transfers      - Transfers between sender and receiver accounts
loans               - Loans issued to customers, with type, amount, interest, and tenure
loan_payments       - Repayment records against loans
cards               - Debit/credit cards issued against accounts
atms                - ATM locations tied to branches
atm_transactions    - Transactions performed at ATMs
employees           - Bank staff, linked to a branch and department
departments         - Department master list (Accounts, Loans, IT, HR, etc.)
beneficiaries       - Saved transfer beneficiaries for each customer


Relationships

  - accounts -> customers, branches
  - transactions -> accounts
  - fund_transfers -> accounts (sender & receiver)
  - loans -> customers, branches
  - loan_payments -> loans
  - cards -> customers, accounts
  - atms -> branches
  - atm_transactions -> atms, accounts
  - employees -> branches, departments
  - beneficiaries -> customers


SAMPLE DATA
-----------

The script inserts sample records for all tables, including 8 branches, multiple customers, accounts, transactions, loans, cards, ATMs, and employees - enough to exercise every view and procedure below.


VIEWS
-----

Loan summary                  - Loan details per customer
Transaction summary           - Aggregated transaction activity
Fund transfer summary         - Transfer activity overview
ATM transaction summary       - ATM usage overview
Card summary                  - Issued cards overview
Branch performance            - Branch-level metrics
Department employee summary   - Staff counts by department
Loan payment summary          - Repayment tracking
Customer financial summary    - Consolidated customer financial position


DASHBOARD QUERIES
-----------------

Ready-to-run analytical queries covering: top 5 customers by loan amount, loan type analysis, transaction type analysis, fund transfer mode analysis, ATM transaction analysis, branch-wise balance analysis, department salary analysis, loan payment analysis, and customer balance/loan ranking.


STORED PROCEDURES
-----------------

GetCustomerLoanDetails        - Loan details for a customer
CheckDuplicateLoan            - Checks for duplicate active loans
GetCustomerLoanAmount         - Total loan amount for a customer
GetCustomerAccountCount       - Number of accounts held by a customer
GetCustomerTotalBalance       - Total balance across a customer's accounts
GetCustomerFinancialSummary   - Full financial summary for a customer
GetCustomerTransactions       - Transaction history for a customer
GetCustomerTransfers          - Fund transfer history (sent & received)
GetCustomerLoanPayments       - Loan repayment history
GetCustomerCards              - Cards issued to a customer
GetCustomerATMTransactions    - ATM transaction history
GetCustomerBeneficiaries      - Saved beneficiaries for a customer
GetCustomerBranchDetails      - Branches associated with a customer's accounts
GetCustomerProfile            - Full customer profile with account details

Each procedure takes a customer_id (or similar) parameter, e.g.:

    CALL GetCustomerProfile(1);


USAGE
-----

1. Run the script in MySQL (e.g. via the CLI or MySQL Workbench):

       mysql -u <user> -p < banking_system.sql

2. The script creates the database, tables, sample data, views, and procedures in sequence.

3. Query the views or call the stored procedures to explore customer, branch, loan, and transaction data.


REQUIREMENTS
------------

- MySQL 5.7+ (uses AUTO_INCREMENT, DELIMITER, stored procedures, and CURRENT_TIMESTAMP defaults)


