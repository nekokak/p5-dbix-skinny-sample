CREATE TABLE user (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    name       VARCHAR(255) NOT NULL,
    UNIQUE(name)
);

CREATE TABLE status (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER NOT NULL,
    body       VARCHAR(255) NOT NULL
);

