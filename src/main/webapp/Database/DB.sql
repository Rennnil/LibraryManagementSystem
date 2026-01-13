-- Library Management System Database Schema (2NF Compliant)

-- 1. ROLE TABLE
-- Stores different roles for users (e.g., Admin, Librarian, User)
CREATE TABLE ROLE (
    ROLE_ID       NUMBER PRIMARY KEY,               -- Unique role id
    ROLE_NAME     VARCHAR2(20) UNIQUE NOT NULL      -- Role name	
);


-- 2. USER TABLE
-- Stores registered user information along with role, contact info, and profile image
CREATE TABLE USERS (
    USER_ID       NUMBER PRIMARY KEY,                  -- Unique user id
    FNAME         VARCHAR2(100) NOT NULL,              -- First name
    LNAME         VARCHAR2(100) NOT NULL,              -- Last name
    EMAIL         VARCHAR2(100) UNIQUE NOT NULL,       -- Login Email
    PASSWORD      VARCHAR2(100) NOT NULL,              -- Encrypted password
    MOBILE_NO     VARCHAR2(15),                        -- Contact number
	GENDER		  VARCHAR2(10),                        -- Male/Female/Other
    ROLE_ID       NUMBER REFERENCES ROLE(ROLE_ID),     -- Role mapping
    ADDRESS       VARCHAR2(255),                       -- Full address    
    IMAGE         BLOB,                                -- User profile photo
    CREATED_AT    DATE DEFAULT SYSDATE,                -- Record creation
    LAST_LOGIN    DATE                                 -- Last login time
);
CREATE SEQUENCE USER_ID_SEQ START WITH 1 INCREMENT BY 1;


-- 3. BOOK TABLE
-- Stores information about books in the library
CREATE TABLE BOOK (
    BOOK_ID        NUMBER PRIMARY KEY,                -- Unique book id
    TITLE          VARCHAR2(100) NOT NULL,            -- Book title
    AUTHOR         VARCHAR2(50),                      -- Book author name
    PUBLISHER      VARCHAR2(50),                      -- Book publisher name
    CATEGORY       VARCHAR2(50),                      -- Book category/genre
    YEAR_PUBLISHED NUMBER,                            -- Year book was published
    QNTY           NUMBER,                            -- Total quantity in library
    AVAILABLE_QNTY NUMBER,                            -- Currently available quantity
    BOOK_IMAGE     BLOB,                              -- Cover image of the book
	AUTHOR_IMAGE   BLOB,						      -- Author Image
	rating 		   NUMBER(1),					      -- Book Rating
	USER_ID		   NUMBER REFERENCES USERS(USER_ID)   -- Added by
);
CREATE SEQUENCE BOOK_ID_SEQ START WITH 1 INCREMENT BY 1;


-- 4. ISSUE_BOOK TABLE
-- Tracks which user has issued which book and the status
CREATE TABLE ISSUE_BOOK (
    ISSUE_ID     NUMBER PRIMARY KEY,                       -- Unique issue id 
    USER_ID      NUMBER REFERENCES USERS(USER_ID),         -- Who issued the book
    BOOK_ID      NUMBER REFERENCES BOOK(BOOK_ID),          -- Which book is issued
    LIBRARIAN_ID NUMBER REFERENCES USERS(USER_ID),         -- Who processed the issue
    ISSUE_DATE   DATE NOT NULL,                            -- Issue date/System DATE
    DUE_DATE     DATE NOT NULL,                            -- Due return date
    RETURN_DATE  DATE,                                     -- Actual return date
    EXTENDED_DATE DATE,                                    -- If return period is extended
    STATUS       VARCHAR2(20)                              -- Issued, Returned, Overdue
);
CREATE SEQUENCE ISSUE_BOOK_SEQ START WITH 1 INCREMENT BY 1;


-- 5. RETURN_BOOK TABLE
-- Captures return events including who received the book and condition
CREATE TABLE RETURN_BOOK (
    RETURN_ID     NUMBER PRIMARY KEY,                      -- Unique Return id
    ISSUE_ID      NUMBER REFERENCES ISSUE_BOOK(ISSUE_ID),  -- Linked issue record
    RETURN_DATE   DATE,                                    -- Return date/ System DATE
    RECEIVED_BY   NUMBER REFERENCES USERS(USER_ID),        -- Librarian who received
    CONDITION_NOTE VARCHAR2(255),                          -- Notes on condition
	BOOK_ID      NUMBER REFERENCES BOOK(BOOK_ID)           -- Which book is issued
);
CREATE SEQUENCE RETURN_BOOK_SEQ START WITH 1 INCREMENT BY 1;


-- 6. FINE TABLE
-- Keeps fine records for late returns or damages
CREATE TABLE FINE (
    FINE_ID      NUMBER PRIMARY KEY,                       -- Unique Fine id
    USER_ID      NUMBER REFERENCES USERS(USER_ID),         -- Who is fined
    ISSUE_ID     NUMBER REFERENCES ISSUE_BOOK(ISSUE_ID),   -- Related to which issue
    AMOUNT       NUMBER(10,2),                             -- Fine amount
    STATUS       VARCHAR2(10),                             -- Paid or Unpaid
    PAID_DATE    DATE,                                     -- When paid
    CARD_NUMBER  VARCHAR2(20),                             -- Reason for fine
	PAYEE_NAME   VARCHAR2(20),                             -- Who PAY
	EX_MONTH     VARCHAR2(4),                              
	EX_YEAR      VARCHAR2(4),
	CVV          NUMBER(5),
    LIBRARIAN_ID NUMBER REFERENCES USERS(USER_ID)          -- Who recorded the fine
);
CREATE SEQUENCE FINE_SEQ START WITH 1 INCREMENT BY 1;


-- 7. RESERVATION TABLE
-- Tracks which user reserved which book and current reservation status
CREATE TABLE RESERVATION (
    RESERVATION_ID NUMBER PRIMARY KEY,                     -- unique reservation system
    USER_ID        NUMBER REFERENCES USERS(USER_ID),       -- Who reserved the book
    BOOK_ID        NUMBER REFERENCES BOOK(BOOK_ID),        -- Which book is reserved
    REQUESTED_DATE DATE,                                   -- When requested
    EXPIRY_DATE    DATE,                                   -- Reservation expiry
    STATUS         VARCHAR2(20),                           -- Pending, Approved, Cancelled
    COLLECTED_DATE DATE                                    -- If collected, when
);

--8. Contactus
CREATE TABLE CONTACTUS ( 
    CONTACT_ID   NUMBER PRIMARY KEY,                       -- Unique message id
    NAME         VARCHAR2(20),                             -- Sender name
    MAIL         VARCHAR2(20),                             -- Email address
    QUERY        VARCHAR2(20)                              -- User query/message
);
CREATE SEQUENCE CONTACTUS_SEQ START WITH 1 INCREMENT BY 1;



--Triggers 

-- decrease book qty
CREATE OR REPLACE TRIGGER trg_decrease_available_qnty
AFTER INSERT ON ISSUE_BOOK
FOR EACH ROW
BEGIN
    UPDATE BOOK
    SET AVAILABLE_QNTY = NVL(AVAILABLE_QNTY, 0) - 1
    WHERE BOOK_ID = :NEW.BOOK_ID;
END;
/

-- Default Avalilable book is 5 
CREATE OR REPLACE TRIGGER trg_set_default_available_qnty
BEFORE INSERT ON BOOK
FOR EACH ROW
BEGIN
    IF :NEW.AVAILABLE_QNTY IS NULL THEN
        :NEW.AVAILABLE_QNTY := 5;
    END IF;
END;
/

-- Auto Rating book 
CREATE OR REPLACE TRIGGER trg_auto_random_rating
BEFORE INSERT ON BOOK
FOR EACH ROW
BEGIN
    :NEW.RATING := TRUNC(DBMS_RANDOM.VALUE(1, 6));  -- Generates 1 to 5
END;
/





Export Specific table :

go to CMD
cd C:\oraclexe\app\oracle\product\10.2.0\server\BIN

For Export :
expdp system/system@XE tables=BOOK directory=DATA_PUMP_DIR dumpfile=book_backup.dmp logfile=book_backup.log
expdp system/system@XE tables=USERS directory=DATA_PUMP_DIR dumpfile=user_backup.dmp logfile=user_backup.log
expdp system/system@XE tables=ISSUE_BOOK directory=DATA_PUMP_DIR dumpfile=issue_book_backup.dmp logfile=issue_book_backup.log
expdp system/system@XE tables=RETURN_BOOK directory=DATA_PUMP_DIR dumpfile=return_book_backup.dmp logfile=return_book_backup.log
expdp system/system@XE tables=FINE directory=DATA_PUMP_DIR dumpfile=fine_backup.dmp logfile=fine_backup.log

For Import :
impdp system/system@XE tables=STD directory=DATA_PUMP_DIR dumpfile=std_backup.DMP logfile=std_import.log

Exp Imp files are here :
C:\oraclexe\app\oracle\admin\XE\dpdump
