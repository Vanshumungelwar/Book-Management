CREATE DATABASE BookCollection;
USE BookCollection;

CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Birthdate DATE,
    Country VARCHAR(50)
);

CREATE TABLE Genres (
    GenreID INT AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL
);

CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    PublicationYear INT,
    GenreID INT,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE Books_Authors (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Insert authors
INSERT INTO Authors (Name, Birthdate, Country) VALUES
('J.K. Rowling', '1965-07-31', 'United Kingdom'),
('George R.R. Martin', '1948-09-20', 'United States'),
('J.R.R. Tolkien', '1892-01-03', 'United Kingdom');

-- Insert genres
INSERT INTO Genres (GenreName) VALUES
('Fantasy'),
('Science Fiction'),
('Mystery'),
('Non-Fiction');

-- Insert books
INSERT INTO Books (Title, PublicationYear, GenreID) VALUES
('Harry Potter and the Philosopher\'s Stone', 1997, 1),
('A Game of Thrones', 1996, 1),
('The Hobbit', 1937, 1);

-- Insert books-authors relationships
INSERT INTO Books_Authors (BookID, AuthorID) VALUES
(1, 1),  -- Harry Potter by J.K. Rowling
(2, 2),  -- A Game of Thrones by George R.R. Martin
(3, 3);  -- The Hobbit by J.R.R. Tolkien

SELECT b.Title, b.PublicationYear, g.GenreName, a.Name AS Author
FROM Books b
JOIN Genres g ON b.GenreID = g.GenreID
JOIN Books_Authors ba ON b.BookID = ba.BookID
JOIN Authors a ON ba.AuthorID = a.AuthorID;

SELECT b.Title, b.PublicationYear, g.GenreName
FROM Books b
JOIN Genres g ON b.GenreID = g.GenreID
JOIN Books_Authors ba ON b.BookID = ba.BookID
JOIN Authors a ON ba.AuthorID = a.AuthorID
WHERE a.Name = 'J.K. Rowling';

SELECT g.GenreName, COUNT(b.BookID) AS NumberOfBooks
FROM Genres g
LEFT JOIN Books b ON g.GenreID = b.GenreID
GROUP BY g.GenreName;
