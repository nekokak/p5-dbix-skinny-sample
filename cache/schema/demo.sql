CREATE TABLE user (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    name       VARCHAR(255) NOT NULL,
    UNIQUE(name)
);

