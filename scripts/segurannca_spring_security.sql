/* Banco de dados usado postgres SQL */
CREATE  TABLE IF NOT EXISTS users (
  username VARCHAR(50) NOT NULL ,
  password VARCHAR(50) NOT NULL ,
  enabled VARCHAR(50) NOT NULL ,
  PRIMARY KEY (username) );

  CREATE  TABLE IF NOT EXISTS authorities (
  username VARCHAR(50) NOT NULL ,
  authority VARCHAR(50) NOT NULL ,
  CONSTRAINT fk_authorities_users
    FOREIGN KEY (username )
    REFERENCES wusers (username )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE SEQUENCE SEQ_groups;

    CREATE  TABLE IF NOT EXISTS groups (
  id INTEGER NOT NULL,
  group_name VARCHAR(50) NOT NULL ,
  PRIMARY KEY (id) );

  CREATE  TABLE IF NOT EXISTS group_authorities (
  group_id INTEGER NOT NULL ,
  authority VARCHAR(50) NOT NULL ,
  PRIMARY KEY (group_id) ,
  CONSTRAINT fk_group_authorities_group
    FOREIGN KEY (group_id )
    REFERENCES groups (id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE SEQUENCE SEQ_group_members;
    CREATE  TABLE IF NOT EXISTS group_members (
  id INTEGER NOT NULL,
  username VARCHAR(50) NOT NULL ,
  group_id INTEGER NOT NULL ,
  PRIMARY KEY (id) ,
  CONSTRAINT fk_group_members_group
    FOREIGN KEY (id )
    REFERENCES groups (id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

    INSERT INTO users VALUES ('admin','admin','1'),('guest','guest','1');
 
INSERT INTO authorities VALUES ('admin','ROLE_USER'),('guest','ROLE_USER'),('admin','ROLE_ADMIN');

select * from user;
commit;