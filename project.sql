
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS permission;
CREATE TABLE permission (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       level TEXT
       );

DROP TABLE IF EXISTS role;
CREATE TABLE role (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       permission_id INTEGER REFERENCES permission(id)
       ON UPDATE CASCADE ON DELETE CASCADE,
       name TEXT
       );

DROP TABLE IF EXISTS person;
CREATE TABLE person (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       role_id INTEGER REFERENCES role(id)
       ON UPDATE CASCADE ON DELETE CASCADE,
       name TEXT,
       company TEXT,
       phone TEXT,
       email TEXT
       );

DROP TABLE IF EXISTS project;
CREATE TABLE project (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       creator_id INTEGER REFERENCES person(id)
       ON UPDATE CASCADE ON DELETE CASCADE,
       address_1 TEXT,
       address_2 TEXT,
       city TEXT,
       state TEXT,
       zip TEXT
       );

DROP TABLE IF EXISTS task;
CREATE TABLE task (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       task_type_id INTEGER REFERENCES task_type(id)
       ON UPDATE CASCADE ON DELETE CASCADE,
       project_id INTEGER REFERENCES project(id)
       ON UPDATE CASCADE ON DELETE CASCADE,
       due_date INTEGER,
       other_name TEXT
       );

DROP TABLE IF EXISTS task_type;
CREATE TABLE task_type (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       name TEXT
       );

INSERT INTO permission (id, level) VALUES(1, "Administrator");
INSERT INTO permission (id, level) VALUES(2, "Contributor");
INSERT INTO permission (id, level) VALUES(3, "User");

INSERT INTO role (permission_id, name) VALUES(3, "Buyer");
INSERT INTO role (permission_id, name) VALUES(3, "Seller");
INSERT INTO role (permission_id, name) VALUES(1, "Buyer Agent");
INSERT INTO role (permission_id, name) VALUES(1, "Seller Agent");
INSERT INTO role (permission_id, name) VALUES(1, "Mortgage Broker");
INSERT INTO role (permission_id, name) VALUES(1, "Escrow Agent");
INSERT INTO role (permission_id, name) VALUES(1, "Title Agent");
INSERT INTO role (permission_id, name) VALUES(1, "Other");

INSERT INTO task_type (id, name) VALUES(1, "Escrow Open Date");
INSERT INTO task_type (id, name) VALUES(2, "Escrow Period");
INSERT INTO task_type (id, name) VALUES(3, "Appraisal Contingency Date");
INSERT INTO task_type (id, name) VALUES(4, "Inspection Contingency Date");
INSERT INTO task_type (id, name) VALUES(5, "Loan Contingency Date");
INSERT INTO task_type (id, name) VALUES(6, "Home Owners Contingency Date");
INSERT INTO task_type (id, name) VALUES(7, "Buyer Escrow Package Date");
INSERT INTO task_type (id, name) VALUES(8, "Seller Escrow Package Date");
INSERT INTO task_type (id, name) VALUES(9, "Buyer Vesting Amendment Date");
INSERT INTO task_type (id, name) VALUES(10, "Complete Loan Application Date");
INSERT INTO task_type (id, name) VALUES(11, "Final Walkthrough Date");
INSERT INTO task_type (id, name) VALUES(12, "Verification of Sales Price Date");
INSERT INTO task_type (id, name) VALUES(13, "Finalize Closing Cost Date");
INSERT INTO task_type (id, name) VALUES(14, "Finalize Credits Date");
INSERT INTO task_type (id, name) VALUES(15, "Other Date");

INSERT INTO person (role_id, name, company, phone, email) VALUES(1, "Ella J. Landry", "NoVacations.com", "479-648-7952", "EllaJLandry@teleworm.com");
INSERT INTO person (role_id, name, company, phone, email) VALUES(2, "Ronny G. Rogers", "WallpaperDealer.com", "281-405-3229", "RonnyGRogers@teleworm.com");
INSERT INTO person (role_id, name, company, phone, email) VALUES(3, "Joseph R. Cavitt", "ResidentialIndustry.com", "469-357-1049", "JosephRCavitt@teleworm.com");
INSERT INTO person (role_id, name, company, phone, email) VALUES(4, "Patricia A. Madden", "CounselingMaterials.com", "PatriciaAMadden@teleworm.com", "419-916-7859");
INSERT INTO person (role_id, name, company, phone, email) VALUES(5, "Timothy S. Peters", "RoadSticks.com", "713-309-0478", "TimothySPeters@teleworm.com");
INSERT INTO person (role_id, name, company, phone, email) VALUES(6, "Mary J. Dalton", "FirmPolicy.com", "323-278-4445", "MaryJDalton@teleworm.com");

INSERT INTO project (creator_id, address_1, address_2, city, state, zip) VALUES(1, "234 S Tower Dr #2", "", "Beverly Hills", "CA", "90211");

INSERT INTO task (task_type_id, project_id, due_date) VALUES(1, 1, 1313902800);
INSERT INTO task (task_type_id, project_id, due_date) VALUES(2, 1, 1316581200);
INSERT INTO task (task_type_id, project_id, due_date) VALUES(3, 1, 1314507600);
INSERT INTO task (task_type_id, project_id, due_date) VALUES(4, 1, 1315112400);
INSERT INTO task (task_type_id, project_id, due_date) VALUES(5, 1, 1315717200);
