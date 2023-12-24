DROP VIEW IF EXISTS Invoice_Trans;
CREATE VIEW IF NOT EXISTS Invoice_Trans AS
WITH RECURSIVE
itrans AS (SELECT
    i.id AS `tran_id`,
    i.transaction_date,
    i.coa_id AS ar_account,
    -- ABS(total) AS `total`,
    'Accounts Receivable' AS `coa_name`,
    i.total,
    il.id AS `line_id`,
    il.line_coa_id,
    il.line_amount,
    ip.id,
    ip.coa_id AS bank_account,
    'Business Bank Account' AS `bank_name`,
    i.status
FROM Invoices AS i
LEFT JOIN Invoice_Lines AS il ON i.id = il.invoice_id
LEFT JOIN COA AS c ON i.coa_id = c.id
LEFT JOIN Invoice_Payments as ip ON i.invoice_payment_id =ip.id
)

SELECT
itrans.*,
c.name AS `line_coa_name`
FROM itrans
LEFT JOIN COA AS c ON itrans.line_coa_id = c.id;

SELECT * FROM Invoice_Trans;

DROP VIEW IF EXISTS Bill_Trans;
CREATE VIEW IF NOT EXISTS Bill_Trans AS
with recursive
btrans as (SELECT
    'BILL'||b.id as `tran_id`,
    b.transaction_date,
    b.coa_id as ap_account,
    -- ABS(total) as `total`,
    'Accounts Payable' as `coa_name`,
    b.total,
    bl.id  as `line_id`,
    bl.line_coa_id,
    bl.line_amount,
    bp.id,
    bp.coa_id as bank_account,
    'Business Bank Account' as `bank_name`,
    b.status
from Bills as b
left join Bill_Lines as bl on b.id = bl.bill_id
left join COA as c on b.coa_id = c.id
left join Bill_Payments as bp on b.bill_payment_id = bp.id
)
select
btrans.*,
c.name as `line_coa_name`
from btrans
left join COA as c on btrans.line_coa_id = c.id;
SELECT * from Bill_Trans;

DROP VIEW IF EXISTS Received_Money_Trans;
CREATE VIEW IF NOT EXISTS Received_Money_Trans AS
SELECT
    'RM'||rm.id as `tran_id`,
    transaction_date,
    coa_id,
    'Business Bank Account' as `coa_name`,
    total,
    rml.id  as `line_id`,
    rml.line_coa_id,
    c.name as `line_coa_name`,
    rml.line_amount
from Received_Money as rm
left join Received_Money_Lines as rml on rm.id = rml.received_money_id
left join COA  as c on c.id = rml.line_coa_id;
SELECT * from Received_Money_Trans;

DROP VIEW IF EXISTS Spent_Money_Trans;
CREATE VIEW IF NOT EXISTS Spent_Money_Trans AS
SELECT
    'SM'||sm.id as `transaction_id`,
    transaction_date,
    coa_id,
    'Business Bank Account' as `coa_name`,
    total,
    sml.id  as `line_id`,
    sml.line_coa_id,
    c.name as `line_coa_name`,
    sml.line_amount
from Spent_Money as sm
left join Spent_Money_Lines as sml on sm.id = sml.spent_money_id
left join COA  as c on c.id = sml.line_coa_id;
SELECT * from Spent_Money_Trans;

DROP VIEW IF EXISTS Trial_Balance;
CREATE VIEW IF NOT EXISTS Trial_Balance as
-- CREATE TB
-- select all sales
select
    line_coa_id as acct_code,
    line_coa_name as acct_name,
    (case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as debit_bal,
    (case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as credit_bal
from Invoice_Trans
group by line_coa_id
-- select all purchases
union all
select
    line_coa_id as acct_code,
    line_coa_name as acct_name,
    (case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as debit_bal,
    (case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as credit_bal
from Bill_Trans
group by line_coa_id
-- select all received money
union all
select
    line_coa_id as acct_code,
    line_coa_name as acct_name,
    (case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as debit_bal,
    (case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as credit_bal
from Received_Money_Trans
group by line_coa_id
-- select all spent money
union all
select
    line_coa_id as acct_code,
    line_coa_name as acct_name,
    (case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as debit_bal,
    (case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as credit_bal
from Spent_Money_Trans
group by line_coa_id
-- select all AP
union all
select
    ap_account as acct_code,
    coa_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Bill_Trans
where status = "0"
-- select all AR
union all
select
    ar_account as acct_code,
    coa_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Invoice_Trans
where status = "0"
-- select all bill_payments
union all
select
    bank_account as acct_code,
    bank_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Bill_Trans
where status = "1"
-- select all invoice_payments
union all
select
    bank_account as acct_code,
    bank_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Invoice_Trans
where status = "1"
-- select all received_money
union all
select
    coa_id as acct_code,
    coa_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Received_Money_Trans
-- select all spent_money
union all
select
    coa_id as acct_code,
    coa_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Spent_Money_Trans
order by acct_code