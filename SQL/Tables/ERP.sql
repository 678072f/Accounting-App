CREATE TABLE IF NOT EXISTS COA (
    id INT PRIMARY KEY,
    name VARCHAR(32)
);

CREATE TABLE IF NOT EXISTS Terms (
    code INT(2) PRIMARY KEY,
    description VARCHAR(8),
    due_days INT(2) NOT NULL,
    discount_days INT(2) DEFAULT 0,
    discount DECIMAL(2,2)
);

CREATE TABLE IF NOT EXISTS Customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL,
    address1 VARCHAR(64),
    address2 VARCHAR(64),
    city VARCHAR(64),
    state VARCHAR(2),
    zip VARCHAR(10),
    country VARCHAR(32),
    website_URL TEXT(500),
    phone VARCHAR(16),
    term_code INT(2),
    FOREIGN KEY (term_code) REFERENCES Terms(code)
);

CREATE TABLE IF NOT EXISTS Invoice_Payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    description TEXT(1000),
    reference TEXT(500),
    total DECIMAL(20,4) NOT NULL,
    coa_id INT NOT NULL,
    FOREIGN KEY(coa_id) REFERENCES COA(id)
);

CREATE TABLE IF NOT EXISTS Invoices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    due_date DATE,
    description TEXT(1000),
    reference TEXT(500),
    total DECIMAL(10,4) NOT NULL,
    status BOOLEAN,
    customer_id INT,
    invoice_payment_id INT,
    coa_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (invoice_payment_id) REFERENCES Invoice_Payments(id),
    FOREIGN KEY (coa_id) REFERENCES COA(id)
);

CREATE TABLE IF NOT EXISTS Invoice_Lines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    line_amount DECIMAL(20,4) NOT NULL,
    invoice_id INT,
    line_coa_id INT NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES Invoices(id),
    FOREIGN KEY (line_coa_id) REFERENCES COA(id)
);

CREATE TABLE IF NOT EXISTS Received_Money (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    description TEXT(1000),
    reference TEXT(500),
    total DECIMAL(20,4) NOT NULL,
    customer_id INT,
    coa_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(id),
    FOREIGN KEY (coa_id) REFERENCES COA(id)
);

CREATE TABLE IF NOT EXISTS Received_Money_Lines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    line_amount DECIMAL(20,4) NOT NULL,
    received_money_id INT,
    line_coa_id INT NOT NULL,
    FOREIGN KEY (received_money_id) REFERENCES Received_Money(id),
    FOREIGN KEY (line_coa_id) REFERENCES COA(id)
);

CREATE TABLE IF NOT EXISTS Suppliers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL,
    phone VARCHAR(16),
    address1 VARCHAR(64),
    address2 VARCHAR(64),
    city VARCHAR(64),
    state VARCHAR(2),
    zip VARCHAR(10),
    country VARCHAR(32),
    approved BOOLEAN,
    term_code INT(2),
    FOREIGN KEY (term_code) REFERENCES Terms(code)
);

CREATE TABLE IF NOT EXISTS Contacts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    title VARCHAR(32),
    email VARCHAR(128),
    phone VARCHAR(16),
    customer_id INT,
    supplier_id INT,
    decision_maker BOOLEAN DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES Customers(id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(id)
);

CREATE TABLE IF NOT EXISTS Bill_Payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    description TEXT(1000),
    reference TEXT(500),
    total DECIMAL(20,4) NOT NULL,
    coa_id INT NOT NULL,
    FOREIGN KEY (coa_id) REFERENCES COA(id)
);

CREATE TABLE IF NOT EXISTS Bills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    due_date DATE,
    description TEXT(1000),
    reference TEXT(500),
    total DECIMAL(20,4) NOT NULL,
    status BOOLEAN,
    supplier_id INT,
    bill_payment_id INT,
    coa_id INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(id),
    FOREIGN KEY (bill_payment_id) REFERENCES Bill_Payments(id),
    FOREIGN KEY (coa_id) REFERENCES COA(id)
);

CREATE TABLE IF NOT EXISTS Spent_Money (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    description TEXT(1000),
    reference TEXT(500),
    total DECIMAL(20,4) NOT NULL,
    supplier_id INT,
    coa_id INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(id),
    FOREIGN KEY (coa_id) REFERENCES COA(id)
);

CREATE TABLE IF NOT EXISTS Bill_Lines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    line_amount DECIMAL(20,4) NOT NULL,
    bill_id INT,
    line_coa_id INT NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES Bills(id),
    FOREIGN KEY (line_coa_id) REFERENCES COA(id)
);

CREATE TABLE IF NOT EXISTS Spent_Money_Lines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    line_amount DECIMAL(20,4) NOT NULL,
    spent_money_id INT,
    line_coa_id INT NOT NULL,
    FOREIGN KEY (spent_money_id) REFERENCES Spent_Money(id),
    FOREIGN KEY (line_coa_id) REFERENCES COA(id)
);