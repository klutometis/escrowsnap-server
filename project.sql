
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
       email TEXT,
       username TEXT,
       salt TEXT,
       hash TEXT
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
       responsible_person_id INTEGER REFERENCES person(id)
       ON UPDATE CASCADE ON DELETE CASCADE,
       due_date TEXT,
       done INTEGER DEFAULT 0,
       other_name TEXT
       );

DROP TABLE IF EXISTS task_type;
CREATE TABLE task_type (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       name TEXT,
       description TEXT 
       );

INSERT INTO permission (id, level) VALUES(1, "Administrator");
INSERT INTO permission (id, level) VALUES(2, "Contributor");
INSERT INTO permission (id, level) VALUES(3, "User");

INSERT INTO role (id, permission_id, name) VALUES(1, 3, "Buyer");
INSERT INTO role (id, permission_id, name) VALUES(2, 3, "Seller");
INSERT INTO role (id, permission_id, name) VALUES(3, 1, "Buyer Agent");
INSERT INTO role (id, permission_id, name) VALUES(4, 1, "Seller Agent");
INSERT INTO role (id, permission_id, name) VALUES(5, 1, "Mortgage Broker");
INSERT INTO role (id, permission_id, name) VALUES(6, 1, "Escrow Agent");
INSERT INTO role (id, permission_id, name) VALUES(7, 1, "Title Agent");
INSERT INTO role (id, permission_id, name) VALUES(8, 1, "Other");

INSERT INTO task_type (id, name, description)
       VALUES(1, "Open Escrow", "Date on which the escrow starts.");
INSERT INTO task_type (id, name, description)
       VALUES(2, "Close Escrow", "Date on which the escrow ends.");
INSERT INTO task_type (id, name, description)
       VALUES(3, "Appraisal Contingency Date", "Date by which the buyer must get an expert estimate of the value of their new home to opt out of the deal without penalty.");
INSERT INTO task_type (id, name, description)
       VALUES(4, "Inspection Contingency Date", "Date by which the buyer must get an inspection of their new home to opt out of the deal without penalty.");
INSERT INTO task_type (id, name, description)
       VALUES(5, "Loan Contingency Date", "Date by which the buyer has to get a loan guarantee from their lending institution to opt out of the deal without penalty.");
INSERT INTO task_type (id, name, description)
       VALUES(6, "Home Owners Contingency Date", "Date by which the buyer has to obtain a homeowner’s insurance quote (aka “binder”) and forward it to the lender.");
INSERT INTO task_type (id, name, description)
       VALUES(7, "Buyer Escrow Package Date", "Date by which buyer should provide all relevant personal information to escrow");
INSERT INTO task_type (id, name, description)
       VALUES(8, "Seller Escrow Package Date", "Date by which the seller needs to provide ther personal information to escrow");
INSERT INTO task_type (id, name, description)
       VALUES(9, "Buyer Vesting Amendment Date", "Date by which the buyer provides escrow with the legal nature in which he will take title");
INSERT INTO task_type (id, name, description)
       VALUES(10, "Complete Loan Application Date", "Complete Loan Application Date");
INSERT INTO task_type (id, name, description)
       VALUES(11, "Final Walkthrough Date", "Date by which the buyer confirms the condition of the property and does their final ""walk through"" with the buyer's agent");
INSERT INTO task_type (id, name, description)
       VALUES(12, "Verification of Sales Price Date", "Verification of Sales Price Date");
INSERT INTO task_type (id, name, description)
       VALUES(13, "Finalize Closing Cost Date", "Date by which the buyer has to ");
INSERT INTO task_type (id, name, description)
       VALUES(14, "Finalize Credits Date", "Date by which the buyer has to ");
INSERT INTO task_type (id, name, description)
       VALUES(15, "Other Date", "Other Date");
INSERT INTO task_type (id, name, description)
       VALUES(16, "Good Faith Deposit Date", "Occurs within 72 hours of acceptance of the deal - buyer deposits their money to escrow");
INSERT INTO task_type (id, name, description)
       VALUES(17, "City Disclosures", "City Disclosures");
INSERT INTO task_type (id, name, description)
       VALUES(18, "Termite Inspection Date", "Termite Inspection Date");
INSERT INTO task_type (id, name, description)
       VALUES(19, "Termite Repair Date", "Termite Repair Date");

INSERT INTO person (id, role_id, name, company, phone, email, username)
       VALUES(1, 1, "Ella J. Landry", "NoVacations.com", "479-648-7952", "EllaJLandry@teleworm.com", "ella");
INSERT INTO person (id, role_id, name, company, phone, email, username)
       VALUES(2, 2, "Ronny G. Rogers", "WallpaperDealer.com", "281-405-3229", "RonnyGRogers@teleworm.com", "ronny");
INSERT INTO person (id, role_id, name, company, phone, email, username)
       VALUES(3, 3, "Joseph R. Cavitt", "ResidentialIndustry.com", "469-357-1049", "JosephRCavitt@teleworm.com", "joseph");
INSERT INTO person (id, role_id, name, company, phone, email, username)
       VALUES(4, 4, "Patricia A. Madden", "CounselingMaterials.com", "PatriciaAMadden@teleworm.com", "419-916-7859", "patricia");
INSERT INTO person (id, role_id, name, company, phone, email, username)
       VALUES(5, 5, "Timothy S. Peters", "RoadSticks.com", "713-309-0478", "TimothySPeters@teleworm.com", "timothy");
INSERT INTO person (id, role_id, name, company, phone, email, username)
       VALUES(6, 6, "Mary J. Dalton", "FirmPolicy.com", "+13107394902", "pcd@pcd.la", "mary");
       -- VALUES(6, 6, "Mary J. Dalton", "FirmPolicy.com", "+16268172836", "pcd@pcd.la", "mary");
INSERT INTO person (id, role_id, name, company, phone, email, username)
       VALUES(7, 7, "Julie C. Stephenson", "LocalTownhouses.com", "859-229-8849", "JulieCStephenson@teleworm.com", "julie");

INSERT INTO project (creator_id, address_1, address_2, city, state, zip)
       VALUES(6, "234 S Tower Dr #2", "", "Beverly Hills", "CA", "90211");
INSERT INTO project (creator_id, address_1, address_2, city, state, zip)
       VALUES(6, "3523 Eagle Lane", "", "Grand Forks", "MN", "58203");
INSERT INTO project (creator_id, address_1, address_2, city, state, zip)
       VALUES(6, "4381 Stout Street", "", "Lancaster", "PA", "17670");

INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(1, 1, 6, '2011-08-21');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(2, 1, 6, '2011-09-19');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(3, 1, 6, '2011-08-28');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(4, 1, 6, '2011-09-04');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(5, 1, 6, '2011-09-11');

INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(1, 2, 6, '2011-09-01');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(2, 2, 6, '2011-09-30');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(16, 2, 6, '2011-09-09');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(14, 2, 6, '2011-09-17');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(18, 2, 6, '2011-09-21');

INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(1, 3, 6, '2011-10-21');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(2, 3, 6, '2011-11-19');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(10, 3, 6, '2011-10-28');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(7, 3, 6, '2011-11-04');
INSERT INTO task (task_type_id, project_id, responsible_person_id, due_date)
       VALUES(6, 3, 6, '2011-11-11');
