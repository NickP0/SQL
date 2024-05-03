-- CREATE USER
CREATE USER kim
WITH password 'kim1234'; -- note this password isn't secure 

CREATE ROLE testrole
WITH LOGIN PASSWORD 'testrole123'; -- cant query tables

GRANT USAGE
ON SCHEMA public
TO kim;

-- Create a new user called username and username1
CREATE USER username
WITH PASSWORD 'username123';

CREATE USER username1
WITH PASSWORD 'username1231';

-- Create roles
CREATE ROLE read_only; -- grant select privilege
CREATE ROLE read_update; -- grant update privilege

-- Grant usage (granted by default)
GRANT USAGE 
ON SCHEMA public
TO read_only;

-- Grant SELECT on tables
GRANT SELECT
ON ALL TABLES IN SCHEMA public
TO read_only;

-- Grant read_only to users
GRANT read_only TO username;

-- Assign read_only to read_update role
GRANT read_only
TO read_update; 

-- Grant all privileges on all tables in public to read_update
GRANT ALL
ON ALL TABLES IN SCHEMA public 
TO read_update;

-- Revoke some privileges from read_update
REVOKE DELETE, INSERT
ON ALL TABLES IN SCHEMA public 
FROM read_update; 

-- Assign role to username1
GRANT read_update
TO username1;

-- DROP user and roles
DROP ROLE username1;

DROP ROLE read_update; 
/* this doesn't work as some objects depend on the role. 
This means that this has been assigned to a user &
we've also used privileges that were granted to this role.
These dependencies make it difficult for us to drop the role.

To get around this, we can first remove all of those 
dependencies -> 
DROP OWNED BY read_update;
DROP ROLE read_update will now work
*/ 

DROP OWNED BY read_update;
DROP ROLE read_update;

-- CHALLENGE
/*In this challenge you need to create a user, a role and add privileges.

Your tasks are the following:

Create the user mia with password 'mia123'
Create  the role analyst_emp;
Grant SELECT on all tables in the public schema to that role.
Grant INSERT and UPDATE on the employees table to that role.
Add the permission to create databases to that role.
Assign that role to mia and test the privileges with that user.
*/

-- Create user
CREATE USER mia
WITH PASSWORD 'mia123';

-- Create role
CREATE ROLE analyst_emp;

-- Grant privileges
GRANT SELECT
ON ALL TABLES IN SCHEMA public
TO analyst_emp;

GRANT INSERT, UPDATE
ON employees
TO analyst_emp;

-- Add permission to create databases
ALTER ROLE analyst_emp CREATEDB;

-- Assign role to user
GRANT analyst_emp TO mia;



