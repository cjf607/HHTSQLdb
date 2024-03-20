DROP TABLE HHT_INVOICE;
DROP TABLE HHT_INSURANCE_COMPANY;
DROP TABLE HHT_EMPLOYEE;
DROP TABLE HHT_SUPPLIER;
DROP TABLE HHT_MANUFACTURER;
DROP TABLE HHT_SUPPLIES;
DROP TABLE HHT_PATIENT;

--1
--included in file

--2: Single .sql file with all CREATE TABLE queries, and the queries listed below. 
--Make sure to include primary and foreign keys.
CREATE TABLE HHT_EMPLOYEE
(
    eID                 NUMBER(5)       NOT NULL    UNIQUE,
    f_name              VARCHAR2(15)    NOT NULL,
    l_name              VARCHAR2(15)    NOT NULL,
    position            VARCHAR2(30),
    address             VARCHAR2(15),
    city                VARCHAR2(15),
    state               VARCHAR2(2),
    homePhone           NUMBER(10),
    mobilePhone         NUMBER(10),
   
    CONSTRAINT eID_pk PRIMARY KEY(eID)
);
CREATE TABLE HHT_INSURANCE_COMPANY
(
    insurCompID         NUMBER(5)       NOT NULL    UNIQUE,
    insurPolNum         NUMBER(6)       NOT NULL,
    insurGroupNum       NUMBER(6)       NOT NULL,
    name                VARCHAR2(30)    NOT NULL,
    address             VARCHAR2(20),
    city                VARCHAR2(15),
    state               VARCHAR(2),
    phoneNumber         NUMBER(10),
    email               VARCHAR2(30),
    fax                 VARCHAR2(15),
    planCoverage       VARCHAR2(30)     NOT NULL,

    CONSTRAINT insurCompID_pk PRIMARY KEY(insurCompID)
);
CREATE TABLE HHT_SUPPLIER
(
    sID                 NUMBER(5)       NOT NULL    UNIQUE,
    name                VARCHAR2(30)    NOT NULL,
    address             VARCHAR2(15),
    city                VARCHAR(15),
    state               VARCHAR2(2),
    phoneNumber         NUMBER(10),
    fax                 NUMBER(10),
    email               VARCHAR2(30),
    repFName            VARCHAR2(15),
    repLName            VARCHAR2(15),
    webURL              VARCHAR2(30),


    CONSTRAINT sID_pk PRIMARY KEY(sID)
);
CREATE TABLE HHT_MANUFACTURER
(
    mID                 NUMBER(5)       NOT NULL    UNIQUE,
    name                VARCHAR2(30)    NOT NULL,
    address             VARCHAR2(15),
    city                VARCHAR2(15),
    state               VARCHAR2(2),
    phoneNumber         NUMBER(10),
    fax                 VARCHAR2(15),
    email               VARCHAR2(30),
    repFName            VARCHAR(15),
    repLName            VARCHAR2(15),
    webURL              VARCHAR2(30),

    CONSTRAINT mID_pk PRIMARY KEY(mID)
);
CREATE TABLE HHT_INVOICE
(
    invNum              NUMBER(5)       NOT NULL    UNIQUE,
    insurCompID         NUMBER(5)       NOT NULL,
    eID                 NUMBER(5)       NOT NULL,
    patFName            VARCHAR2(15)    NOT NULL,
    patLName            VARCHAR2(15)    NOT NULL,
    patAddress          VARCHAR2(15)    NOT NULL,
    patCity             VARCHAR2(15),
    patState            VARCHAR2(2),
    dateCreated         DATE,
    servOffered         VARCHAR2(25),
    price               NUMBER(9),

    CONSTRAINT invNum_pk PRIMARY KEY(invNum),
    CONSTRAINT insurCompID_fk FOREIGN KEY(insurCompID) REFERENCES HHT_INSURANCE_COMPANY(insurCompID),
    CONSTRAINT eID_fk FOREIGN KEY(eID) REFERENCES HHT_EMPLOYEE(eID)
);
CREATE TABLE HHT_SUPPLIES
(
    suppID              NUMBER(5)       NOT NULL    UNIQUE,
    sID                 NUMBER(5)       NOT NULL,
    mID                 NUMBER(5)       NOT NULL,
    description         VARCHAR2(30),
    quantity            NUMBER(6)       NOT NULL,
    cost                NUMBER(9)       NOT NULL,

    CONSTRAINT suppID_pk PRIMARY KEY(suppID),
    CONSTRAINT sID_fk FOREIGN KEY(sID) REFERENCES HHT_SUPPLIER(sID),
    CONSTRAINT mID_fk FOREIGN KEY(mID) REFERENCES HHT_MANUFACTURER(mID)
);
CREATE TABLE HHT_PATIENT
(
    pID                 NUMBER(5)       NOT NULL    UNIQUE,
    insurCompany        NUMBER(5)       NOT NULL,
    dentist             NUMBER(5)       NOT NULL,
    invNum              NUMBER(5)       NOT NULL,
    f_name              VARCHAR2(15)    NOT NULL,
    l_name              VARCHAR2(15)    NOT NULL,
    address             VARCHAR2(15),
    city                VARCHAR2(15),
    state               VARCHAR2(2),
    email               VARCHAR2(30),
    dateOfBirth         DATE            NOT NULL,
    phoneNumber         NUMBER(10),
    emergContFName      VARCHAR2(15)    NOT NULL,
    emergContLName      VARCHAR2(15)    NOT NULL,
    emergContAddress    VARCHAR2(15),
    emergContCity       VARCHAR2(15),
    emergContState      VARCHAR2(2),
    insurPolNum         NUMBER(6)       NOT NULL,
    insurGroupNum       NUMBER(6)       NOT NULL,

    CONSTRAINT pID_pk PRIMARY KEY(pID),
    CONSTRAINT dentist_fk FOREIGN KEY(dentist) REFERENCES HHT_EMPLOYEE(eID),
    CONSTRAINT insurCompany_fk FOREIGN KEY(insurCompany) REFERENCES HHT_INSURANCE_COMPANY(insurCompID),
    CONSTRAINT invNum_fk FOREIGN KEY(invNum) REFERENCES HHT_INVOICE(invNum)
);


--3: INSERT at least three records in each table. Make up the attributes
--insurance_company
INSERT INTO HHT_INSURANCE_COMPANY
VALUES(90001, 121212, 343434,'RedShield', '555 Park St', 'New York City', 'NY', '8889090123', 'email@redshield.com', '8881234567', 'Family');
INSERT INTO HHT_INSURANCE_COMPANY
VALUES(90002, 565656, 676767,'GreenCross', '78 Battery St', 'New York City', 'NY', '8880014545', 'email@redshield.com', '8884442222', 'Basic');
INSERT INTO HHT_INSURANCE_COMPANY
VALUES(90003, 787878, 898989, 'Lyko', '33 Liberty St', 'New York City', 'NY', '8889997676', 'email@redshield.com', '8885667788', 'Gold');
--manufacturer
INSERT INTO HHT_MANUFACTURER
VALUES(40001, 'OrthoComm', '888 Commerce Dr', 'Baltimore', 'MD', 4108881122, 4102224567, 'orthocomm@orthoco.com', 'Matthew', 'Smith', 'orthoco.com');
INSERT INTO HHT_MANUFACTURER
VALUES(40002, 'DentalSolutions', '466 Business Dr', 'Baltimore', 'MD', 4105559090, 4101112222, 'ds@dentalsolutions.com', 'Mark', 'Rainier', 'dentalsolutions.com');
INSERT INTO HHT_MANUFACTURER
VALUES(40003, 'MedEquip', '844 Thompson Dr', 'Philadelphia', 'PA', 7771111111, 7773332222, 'me@medequip.com', 'Katherine', 'Goodman', 'medequip.com');
--supplier
INSERT INTO HHT_SUPPLIER
VALUES(41001, 'MedEquip', '844 Thompson Dr', 'Philadelphia', 'PA', 7771111111, 7773332222, 'me@medequip.com', 'Jemal', 'Akerson', 'medequip.com');
INSERT INTO HHT_SUPPLIER
VALUES(41002, 'JacksonSupplies', '5656 Hearth Rd', 'Potomac', 'MD', 4886134266, 4881118833, 'supplies@jacksonsupplies.com', 'Abdul', 'Husseini', 'jacksonsupplies.com');
INSERT INTO HHT_SUPPLIER
VALUES(41003, 'AtlanticSupplies', '8542 Swanson Rd', 'Bethesda', 'MD', 4310008989, 4319990987, 'supplies@atlantic.com', 'Brittany', 'Pearson', 'atlantic.com');

--supplies
INSERT INTO HHT_SUPPLIES
VALUES(33001, 41001, 40003, 'Medical Gloves', 10000, 102.55);
INSERT INTO HHT_SUPPLIES
VALUES(33002, 41002, 40002, 'Dental Drill', 5, 4211.77);
INSERT INTO HHT_SUPPLIES
VALUES(33003, 41003, 40001, 'Toothpaste', 500, 749.45);

--employee
INSERT INTO HHT_EMPLOYEE
VALUES(10001, 'Jason', 'Lopez', 'Dentist', '432 Oak Ln', 'Frederick', 'MD', '4445558787', '4456664545');
INSERT INTO HHT_EMPLOYEE
VALUES(10002, 'Melissa', 'Greene', 'Receptionist', '90 Robin Ave', 'Woodlawn', 'MD', '4537544588', '4545908373');
INSERT INTO HHT_EMPLOYEE
VALUES(10003, 'Robert', 'Cohen', 'Dental Assistant', '43 Penn Rd', 'Baltimore', 'MD', '4519994747', '4452777167');
--invoice
INSERT INTO HHT_INVOICE
VALUES(55001, 90001, 10002, 'Miguel', 'Hernandez', '567 Sunny Dr', 'Baltimore', 'MD', (TO_DATE ('10/10/2021', 'mm/dd/yyyy')), 'Routine Cleaning', '85.00');
INSERT INTO HHT_INVOICE
VALUES(55002, 90002, 10002, 'Ashley', 'Robinson', '22 Cliff Dr', 'Towson', 'MD', (TO_DATE ('10/21/2021','mm/dd/yyyy')), 'Braces Checkup', '450.50');
INSERT INTO HHT_INVOICE
VALUES(55003, 90003, 10002, 'Skyler', 'Tim', '87 Block Rd', 'Baltimore', 'MD', (TO_DATE ('10/05/2021', 'mm/dd/yyyy')), 'Root Canal', '200.00');

--patient
INSERT INTO HHT_PATIENT
VALUES(20001, 90001, 10001, 55001, 'Miguel', 'Hernandez', '567 Sunny Dr', 'Baltimore', 'MD', 'miguel543@gmail.com', (TO_DATE ('03/10/1975', 'mm/dd/yyyy')), 4104443434, 'Maria', 'Hernandez', '567 Sunny Dr', 'Baltimore', 'MD', 121212, 343434);
INSERT INTO HHT_PATIENT
VALUES(20002, 90002, 10001, 55002, 'Ashley', 'Robinson', '22 Cliff Dr', 'Towson', 'MD', 'ashleyrob453@gmail.com', (TO_DATE ('04/05/1991', 'mm/dd/yyyy')), 4119895591, 'Joseph', 'Brock', '873 Sly Rd', 'Frederick', 'MD', 565656, 676767);
INSERT INTO HHT_PATIENT
VALUES(20003, 90003, 10001, 55003, 'Skyler', 'Tim', '87 Block Rd', 'Baltimore', 'MD', 'skylertim01@gmail.com', (TO_DATE ('10/15/1989', 'mm/dd/yyyy')), 4100034385, 'Karen', 'Tim', '87 Block Rd', 'Baltimore', 'MD', 787878, 898989);

--Query to SELECT all the attributes of all staff.
SELECT *
FROM HHT_EMPLOYEE;

--SELECT the names only of the manufacturers that are also suppliers
SELECT S.name
FROM HHT_MANUFACTURER M, HHT_SUPPLIER S
WHERE S.name = M.name;

--lists the first and last names of the dental assistants
SELECT E.f_name, E.l_name
FROM HHT_EMPLOYEE E
WHERE position = 'Dental Assistant';

--lists the supplier name and address of a single supply. 

SELECT S.name, S.address, S.city, S.state
FROM HHT_SUPPLIER S
WHERE S.sID = (SELECT SUPP.sID
                    FROM HHT_SUPPLIES SUPP
                    WHERE SUPP.description = 'Toothpaste');