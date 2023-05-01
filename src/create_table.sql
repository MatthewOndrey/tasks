DROP TABLE tasks;

CREATE TABLE tasks (
                       id          int NOT NULL AUTO_INCREMENT,
                       title       varchar(255) NOT NULL,
                       description varchar(255),
                       dueDate    date,
                       primary key (id)
)