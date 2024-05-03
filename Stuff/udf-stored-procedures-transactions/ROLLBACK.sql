--ROLLBACK

SELECT * FROM acc_balance; 

BEGIN TRANSACTION;
UPDATE acc_balance
SET amount = amount +1000
WHERE id=1;
DELETE FROM acc_balance
WHERE id=1;
ROLLBACK -- this would kick us out the transaction
COMMIT;

BEGIN TRANSACTION;
UPDATE acc_balance
SET amount = amount +1000
WHERE id=1;
SAVEPOINT s1;
DELETE FROM acc_balance
WHERE id=1;
ROLLBACK TO SAVEPOINT s1; -- need to run SAVEPOINT first. 
COMMIT;