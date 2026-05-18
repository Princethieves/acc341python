-- proof.sql
-- This file proves that my PostgreSQL constraints are working correctly.
-- Each INSERT below should fail, and the Neon error message is pasted below it.

-- =========================================================
-- TEST 1: Foreign key test
-- This should fail because payment_id 9999 does not exist.
-- =========================================================

INSERT INTO payment_application (payment_id, invoice_id, amount_applied, application_date)
VALUES (9999, 1, 100.00, CURRENT_DATE);

-- Error message from Neon:
-- ERROR: insert or update on table "payment_application" violates foreign key constraint "fk_app_payment" (SQLSTATE 23503)




-- =========================================================
-- TEST 2: Check constraint test for negative amount
-- This should fail because amount_applied cannot be negative.
-- =========================================================

INSERT INTO payment_application (payment_id, invoice_id, amount_applied, application_date)
VALUES (1, 1, -50.00, CURRENT_DATE);

-- Error message from Neon:
-- ERROR: new row for relation "payment_application" violates check constraint "payment_application_amount_applied_check" (SQLSTATE 23514)




-- =========================================================
-- TEST 3: Check constraint test for invalid payment method
-- This should fail because payment_method must be Check, ACH, Wire, or Credit Card.
-- =========================================================

INSERT INTO payment (customer_id, payment_date, payment_method, amount_received, reference_number)
VALUES (1, CURRENT_DATE, 'Bitcoin', 500.00, 'BTC-TEST-001');

-- Error message from Neon:
-- ERROR: new row for relation "payment" violates check constraint "payment_payment_method_check" (SQLSTATE 23514)

-- Constraint proof completed.