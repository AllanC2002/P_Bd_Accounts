CREATE DATABASE Accounts;
GO

USE Accounts;
GO

-- Table Users
CREATE TABLE Users (
    Id_User INT PRIMARY KEY,
    Name NVARCHAR(100),
    Lastname NVARCHAR(100),
    User_mail NVARCHAR(100) UNIQUE,
    Password NVARCHAR(100),
    Status INT CHECK (Status IN (0, 1)) -- 1 active - 0 inactive
);
GO

-- Login and user creation
CREATE LOGIN [$APP_USER_NAME] WITH PASSWORD = '$APP_USER_PASSWORD';
GO

CREATE USER [$APP_USER_NAME] FOR LOGIN [$APP_USER_NAME];
ALTER ROLE db_owner ADD MEMBER [$APP_USER_NAME];
GO