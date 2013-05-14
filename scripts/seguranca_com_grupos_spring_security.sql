--banco usado postgres

-- -----------------------------------------------------
-- TABLE SEC_GROUPS'
-- -----------------------------------------------------
DROP TABLE IF EXISTS SEC_GROUPS;
 
 create sequence SEQ_SEC_GROUPS;
CREATE  TABLE IF NOT EXISTS SEC_GROUPS(
  SEC_GROUPS_GROUP_ID INTEGER NOT NULL ,
  SEC_GROUPS_GROUP_NAME VARCHAR(45) NOT NULL ,
  PRIMARY KEY (SEC_GROUPS_GROUP_ID) );
 
 
-- -----------------------------------------------------
-- TABLE SEC_GROUP_AUTHORITIES'
-- -----------------------------------------------------
DROP TABLE IF EXISTS SEC_GROUP_AUTHORITIES;
 
 create sequence SEQ_SEC_GROUP_AUTHORITIES;
CREATE  TABLE IF NOT EXISTS  SEC_GROUP_AUTHORITIES(
  SEC_GROUP_AUTHORITIES_AUTHORITY_ID INTEGER NOT NULL ,
  SEC_GROUP_AUTHORITIES_GROUP_ID INTEGER NOT NULL ,
  SEC_GROUP_AUTHORITIES_AUTHORITY VARCHAR(45) NOT NULL ,
  PRIMARY KEY (SEC_GROUP_AUTHORITIES_AUTHORITY_ID) ,
  CONSTRAINT FK_SEC_GROUP_AUTHORITIES_GROUP_ID
    FOREIGN KEY (SEC_GROUP_AUTHORITIES_GROUP_ID)
    REFERENCES SEC_GROUPS(SEC_GROUPS_GROUP_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
 
 
-- -----------------------------------------------------
-- TABLE SEC_USERS'
-- -----------------------------------------------------
DROP TABLE IF EXISTS SEC_USERS;
 
 create sequence SEQ_SEC_USERS;
CREATE  TABLE IF NOT EXISTS SEC_USERS(
  PK_SEC_USERS INTEGER NOT NULL ,
  SEC_USERS_USERNAME VARCHAR(45) NOT NULL ,
  SEC_USERS_PASSWORD VARCHAR(255) NOT NULL ,
  SEC_USERS_ENABLED VARCHAR(5) NOT NULL ,
  SEC_USERS_CREATED_DT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  SEC_USERS_MODIFIED_DT TIMESTAMP NULL DEFAULT NULL ,
  SEC_USERS_ENCRYPTED VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (PK_SEC_USERS));
  
 CREATE UNIQUE INDEX SEC_USERS_USERNAME_UNIQUE ON SEC_USERS(SEC_USERS_USERNAME);
 
 
-- -----------------------------------------------------
-- TABLE SEC_GROUP_MEMBERS'
-- -----------------------------------------------------
DROP TABLE IF EXISTS SEC_GROUP_MEMBERS;
 
CREATE  TABLE IF NOT EXISTS SEC_GROUP_MEMBERS(
  SEC_GROUP_MEMBERS_ID INTEGER NOT NULL ,
  SEC_GROUP_MEMBERS_GROUP_ID INTEGER NOT NULL ,
  SEC_GROUP_MEMBERS_USER_ID INTEGER NOT NULL ,
  PRIMARY KEY (SEC_GROUP_MEMBERS_ID) ,
  CONSTRAINT FK_SEC_GROUP_MEMBERS_GROUP_ID
    FOREIGN KEY (SEC_GROUP_MEMBERS_GROUP_ID)
    REFERENCES SEC_GROUPS(SEC_GROUPS_GROUP_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT FK_SEC_GROUP_MEMBERS_USER_ID
    FOREIGN KEY (SEC_GROUP_MEMBERS_USER_ID)
    REFERENCES SEC_USERS(PK_SEC_USERS)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
 
 
-- -----------------------------------------------------
-- TABLE SEC_ROLES'
-- -----------------------------------------------------
DROP TABLE IF EXISTS SEC_ROLES;
 
  create sequence SEQ_SEC_ROLES;
CREATE  TABLE IF NOT EXISTS SEC_ROLES(
  PK_SEC_ROLES INTEGER NOT NULL ,
  SEC_ROLES_USERNAME VARCHAR(45) NOT NULL ,
  SEC_ROLES_ROLE_NAME VARCHAR(45) NOT NULL ,
  SEC_ROLES_CREATED_DT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  SEC_ROLES_MODIFIED_DT TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (PK_SEC_ROLES) ,
  CONSTRAINT FK_USERNAME_SEC_ROLES
    FOREIGN KEY (SEC_ROLES_USERNAME)
    REFERENCES SEC_USERS(SEC_USERS_USERNAME)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    --carga inicial para testes
    INSERT INTO sec_users (PK_SEC_USERS, SEC_USERS_USERNAME, SEC_USERS_PASSWORD, SEC_USERS_ENABLED, SEC_USERS_CREATED_DT, SEC_USERS_MODIFIED_DT, SEC_USERS_ENCRYPTED) VALUES (1,'admin','admin','true',CURRENT_TIMESTAMP,null,null),(2,'guest','guest','true',CURRENT_TIMESTAMP,null,null);
 
INSERT INTO sec_groups (SEC_GROUPS_GROUP_ID, SEC_GROUPS_GROUP_NAME) VALUES (1,'ADMIN'),(2,'GUEST');
 
INSERT INTO sec_group_authorities (SEC_GROUP_AUTHORITIES_AUTHORITY_ID, SEC_GROUP_AUTHORITIES_GROUP_ID, SEC_GROUP_AUTHORITIES_AUTHORITY) VALUES (1,1,'ROLE_USER'),(2,2,'ROLE_GUEST'),(3,1,'ROLE_ADMIN');
 
INSERT INTO sec_group_members (SEC_GROUP_MEMBERS_ID, SEC_GROUP_MEMBERS_GROUP_ID, SEC_GROUP_MEMBERS_USER_ID) VALUES (1,1,1),(2,2,2);
 
INSERT INTO sec_roles (PK_SEC_ROLES, SEC_ROLES_USERNAME, SEC_ROLES_ROLE_NAME, SEC_ROLES_CREATED_DT, SEC_ROLES_MODIFIED_DT) VALUES (1,'admin','ROLE_USER',CURRENT_TIMESTAMP,null),(2,'admin','ROLE_ADMIN',CURRENT_TIMESTAMP,null),(3,'guest','ROLE_USER',CURRENT_TIMESTAMP,null);