create table users(username varchar(50) not null primary key,password varchar(500) not null,enabled boolean not null);
create table authorities (username varchar(50) not null,authority varchar(50) not null,constraint fk_authorities_users foreign key(username) references users(username));
create unique index ix_auth_username on authorities (username,authority);

INSERT IGNORE INTO `users` VALUES ('donald', '{bcrypt}$2a$12$gnGgQDZOcqZ/nCCPSSGXOOcgHSkI3pvyAGYfpFqWx5c74RrumWV7e', '1');
INSERT IGNORE INTO `authorities` VALUES ('donald', 'ROLE_USER');

INSERT IGNORE INTO `users` VALUES ('fethry', '{bcrypt}$2a$12$gnGgQDZOcqZ/nCCPSSGXOOcgHSkI3pvyAGYfpFqWx5c74RrumWV7e', '1');
INSERT IGNORE INTO `authorities` VALUES ('fethry', 'ROLE_NONE');

