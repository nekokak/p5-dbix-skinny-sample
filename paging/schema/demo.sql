CREATE TABLE user (
    id         INTEGER PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(255) NOT NULL,
    UNIQUE(name)
);

