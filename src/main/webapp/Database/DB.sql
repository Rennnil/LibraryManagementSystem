-- Library Management System Database Schema (2NF Compliant)

-- 1. ROLE TABLE
-- Stores different roles for users (e.g., Admin, Librarian, User)
CREATE TABLE ROLE (
    ROLE_ID       NUMBER PRIMARY KEY,
    ROLE_NAME     VARCHAR2(20) UNIQUE NOT NULL
);

-- 2. USER TABLE
-- Stores registered user information along with role, contact info, and profile image
CREATE TABLE USERS (
    USER_ID       NUMBER PRIMARY KEY,
    FNAME          VARCHAR2(100) NOT NULL,
    LNAME          VARCHAR2(100) NOT NULL,
    EMAIL         VARCHAR2(100) UNIQUE NOT NULL,
    PASSWORD      VARCHAR2(100) NOT NULL,
    MOBILE_NO     VARCHAR2(15),
	GENDER		  VARCHAR2(10),
    ROLE_ID       NUMBER REFERENCES ROLE(ROLE_ID),
    ADDRESS       VARCHAR2(255),
    USER_IMAGE         BLOB,                          -- User profile photo
    CREATED_AT    DATE DEFAULT SYSDATE,
    LAST_LOGIN    DATE
);


CREATE SEQUENCE USER_ID_SEQ START WITH 1 INCREMENT BY 1;


-- 3. BOOK TABLE
-- Stores information about books in the library
CREATE TABLE BOOK (
    BOOK_ID        NUMBER PRIMARY KEY,
    TITLE          VARCHAR2(100) NOT NULL,
    AUTHOR         VARCHAR2(50),                -- Book author name
    PUBLISHER      VARCHAR2(50),                -- Book publisher name
    CATEGORY       VARCHAR2(50),                -- Book category/genre
    YEAR_PUBLISHED NUMBER,                      -- Year book was published
    QNTY           NUMBER,                      -- Total quantity in library
    AVAILABLE_QNTY NUMBER,                      -- Currently available quantity
    BOOK_IMAGE          BLOB,                        -- Cover image of the book
	AUTHOR_IMAGE   BLOB,						-- Author Image
	rating 		   NUMBER(1),					-- Book Rating
	USER_ID		   NUMBER REFERENCES USERS(USER_ID)
);

CREATE SEQUENCE BOOK_ID_SEQ START WITH 1 INCREMENT BY 1;


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


-- 4. ISSUE_BOOK TABLE
-- Tracks which user has issued which book and the status
CREATE TABLE ISSUE_BOOK (
    ISSUE_ID     NUMBER PRIMARY KEY,
    USER_ID      NUMBER REFERENCES USERS(USER_ID),         -- Who issued the book
    BOOK_ID      NUMBER REFERENCES BOOK(BOOK_ID),          -- Which book is issued
    LIBRARIAN_ID NUMBER REFERENCES USERS(USER_ID),         -- Who processed the issue
    ISSUE_DATE   DATE NOT NULL,
    DUE_DATE     DATE NOT NULL,
    RETURN_DATE  DATE,                                     -- Actual return date
    EXTENDED_DATE DATE,                                    -- If return period is extended
    STATUS       VARCHAR2(20)                              -- Issued, Returned, Overdue
);

CREATE SEQUENCE ISSUE_BOOK_SEQ START WITH 1 INCREMENT BY 1;


-- 5. RETURN_BOOK TABLE
-- Captures return events including who received the book and condition
CREATE TABLE RETURN_BOOK (
    RETURN_ID     NUMBER PRIMARY KEY,
    ISSUE_ID      NUMBER REFERENCES ISSUE_BOOK(ISSUE_ID),  -- Linked issue record
    RETURN_DATE   DATE,
    RECEIVED_BY   NUMBER REFERENCES USERS(USER_ID),        -- Librarian who received
    CONDITION_NOTE VARCHAR2(255),                           -- Notes on condition
	BOOK_ID      NUMBER REFERENCES BOOK(BOOK_ID)           -- Which book is issued
);

CREATE SEQUENCE RETURN_BOOK_SEQ START WITH 1 INCREMENT BY 1;



-- 6. FINE TABLE
-- Keeps fine records for late returns or damages
CREATE TABLE FINE (
    FINE_ID      NUMBER PRIMARY KEY,
    USER_ID      NUMBER REFERENCES USERS(USER_ID),         -- Who is fined
    ISSUE_ID     NUMBER REFERENCES ISSUE_BOOK(ISSUE_ID),   -- Related to which issue
    AMOUNT       NUMBER(10,2),                             -- Fine amount
    STATUS       VARCHAR2(10),                             -- Paid or Unpaid
    PAID_DATE    DATE,                                     -- When paid
    CARD_NUMBER  VARCHAR2(20),                               -- Reason for fine
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
    RESERVATION_ID NUMBER PRIMARY KEY,
    USER_ID        NUMBER REFERENCES USERS(USER_ID),       -- Who reserved the book
    BOOK_ID        NUMBER REFERENCES BOOK(BOOK_ID),        -- Which book is reserved
    REQUESTED_DATE DATE,                                   -- When requested
    EXPIRY_DATE    DATE,                                   -- Reservation expiry
    STATUS         VARCHAR2(20),                           -- Pending, Approved, Cancelled
    COLLECTED_DATE DATE                                    -- If collected, when
);



addCourse -> addBook
course -> Books
playlist -> BookDetail
faculty -> Librarian
facultyDetails -> LibrarianDetails
studentQuery -> StudentTable

	
	
book table  -> librarian name
when admin add book  -> spacific librarian 

package p1;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
        maxFileSize = 1024 * 1024 * 20,       // 20 MB
        maxRequestSize = 1024 * 1024 * 25     // 25 MB
)

@WebServlet(name = "IssueBookServlet", value = "/IssueBookServlet")

public class IssueBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                response.sendRedirect("Login.jsp");
                return;
            }

            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int librarianID = Integer.parseInt(request.getParameter("userId"));

            LocalDate issueDate = LocalDate.now();
            LocalDate dueDate = issueDate.plusDays(10);

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO ISSUE_BOOK (ISSUE_ID, LIBRARIAN_ID ,USER_ID, BOOK_ID, ISSUE_DATE, DUE_DATE, STATUS) " +
                    "VALUES (ISSUE_BOOK_SEQ.NEXTVAL,?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, librarianID);
            ps.setInt(2, userId);
            ps.setInt(3, bookId);
            ps.setDate(4, Date.valueOf(issueDate));
            ps.setDate(5, Date.valueOf(dueDate));
            ps.setString(6, "Issued");

            System.out.println(userId + " " + bookId + " " + issueDate + " " + dueDate);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect(request.getContextPath() + "/User/BorrowedBooks.jsp");
            } else {
                response.getWriter().println("Failed to issue book.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

gpt i wanto call below function to above servlet so that when user is Issue the book they got the mail that you are issued the book 

getIssuedBooks 

also call sendIssueMail so that they got the mail 