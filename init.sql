CREATE TABLE Users (
    Id_User INT AUTO_INCREMENT PRIMARY KEY,
    Name NVARCHAR(100),
    Lastname NVARCHAR(100),
    User_mail NVARCHAR(100) UNIQUE,
    Password NVARCHAR(100),
    Status INT CHECK (Status IN (0, 1))
);
