-- In Master Database (Only Step in Master Database)
create login [admin.user] with password ='admin123#'
create login [user1.user] with password ='admin123#'
create login [user2.user] with password ='admin123#'
create login [user3.user] with password ='admin123#'
create login [user4.user] with password ='admin123#'
create login [user5.user] with password ='admin123#'

-- In User Database
CREATE USER [admin.user] with password ='admin123#'
CREATE USER [user1.user] with password ='admin123#'
CREATE USER [user2.user] with password ='admin123#'
CREATE USER [user3.user] with password ='admin123#'
CREATE USER [user4.user] with password ='admin123#'
CREATE USER [user5.user] with password ='admin123#'

-- Create Login Table
CREATE TABLE [Login]
(
LoginName sysname,
LoginPassword varchar(20)
);

-- Sample Data For Login Table
INSERT [Login] VALUES
('admin.user', 'admin123#'),
('user1.user', 'admin123#'),
('user2.user', 'admin123#'),
('user3.user', 'admin123#'),
('user4.user', 'admin123#'),
('user5.user', 'admin123#')

GRANT SELECT ON [Login1] TO [admin.user];
GRANT SELECT ON [Login1] TO [user1.user];
GRANT SELECT ON [Login1] TO [user2.user] ;
GRANT SELECT ON [Login1] TO [user3.user];
GRANT SELECT ON [Login1] TO [user4.user] ;
GRANT SELECT ON [Login1] TO [user5.user];

CREATE SCHEMA [LoginSecurity];
GO

CREATE FUNCTION [LoginSecurity].fn_securitypredicate(@LoginName AS sysname)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS fn_securitypredicate_result
WHERE @LoginName = USER_NAME() OR USER_NAME() = 'admin.user';


CREATE SECURITY POLICY LoginFilter
ADD FILTER PREDICATE [LoginSecurity].fn_securitypredicate(LoginName)
ON dbo.[Login]
WITH (STATE = ON);