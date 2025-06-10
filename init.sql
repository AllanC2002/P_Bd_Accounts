CREATE TABLE Users (
    Id_User INT PRIMARY KEY,
    Name VARCHAR(100),
    Lastname VARCHAR(100),
    User_mail VARCHAR(100) UNIQUE,
    Password VARCHAR(100),
    Status TINYINT,
    CHECK (Status IN (0, 1)) -- 1 active - 0 inactive
);
