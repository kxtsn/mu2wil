-- MySQL dump 3  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: mu2wil
-- ------------------------------------------------------
-- Server version	8.0.26

--
-- CLEAR SCHEMA
--
UNLOCK TABLES;
DROP EVENT IF EXISTS update_listing_status;
DROP TABLE IF EXISTS `access_list`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `super_admin`;
DROP TABLE IF EXISTS `portal_manager`;
DROP TABLE IF EXISTS `student_testimonial`;
DROP TABLE IF EXISTS `employer_testimonial`;
DROP TABLE IF EXISTS `application`;
DROP TABLE IF EXISTS `listing`;
DROP TABLE IF EXISTS `student`;
DROP TABLE IF EXISTS `employer`;

--
-- Table structure for table `access_list`
--

CREATE TABLE `access_list` (
  `Role_ID` int NOT NULL AUTO_INCREMENT,
  `Role` varchar(45) NOT NULL,
  PRIMARY KEY (`Role_ID`)
);
ALTER TABLE access_list AUTO_INCREMENT = 1;

--
-- Dumping data for table `access_list`
--

LOCK TABLES `access_list` WRITE;
/*!40000 ALTER TABLE `access_list` DISABLE KEYS */;
INSERT INTO `access_list`(Role) VALUES ('Super Admin'), ('Portal Manager'), ('Student'), ('Employer');
/*!40000 ALTER TABLE `access_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `superadmin`
--

CREATE TABLE `super_admin` (
  `Super_Admin_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Email` varchar(100) NOT NULL,
  PRIMARY KEY (`Super_Admin_ID`)
);
ALTER TABLE super_admin AUTO_INCREMENT = 1;

--
-- Dumping data for table `super_admin`
--

LOCK TABLES `super_admin` WRITE;
/*!40000 ALTER TABLE `super_admin` DISABLE KEYS */;
INSERT INTO `super_admin`(First_Name, Last_Name, Email) VALUES ('Anderson','Louis', 'anderson.l@murdoch.edu.au');
/*!40000 ALTER TABLE `super_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal_manager`
--

CREATE TABLE `portal_manager` (
  `Portal_Manager_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Email` varchar(100) NOT NULL,
  PRIMARY KEY (`Portal_Manager_ID`)
);
ALTER TABLE portal_manager AUTO_INCREMENT = 1;

--
-- Dumping data for table `portal_manager`
--

LOCK TABLES `portal_manager` WRITE;
/*!40000 ALTER TABLE `portal_manager` DISABLE KEYS */;
INSERT INTO `portal_manager`(First_Name, Last_Name, Email) VALUES ('Kathy','Lim', 'kathy.l@murdoch.edu.au');
/*!40000 ALTER TABLE `portal_manager` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `Student_ID` int NOT NULL AUTO_INCREMENT,
  `Murdoch_Student_ID` char(8) NOT NULL,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Status` char(1) NOT NULL, 
  PRIMARY KEY (`Student_ID`)
);
ALTER TABLE student AUTO_INCREMENT = 1;

--
-- Dumping data for table `student`
--

/* C - Current, G - Graduated */

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student`(Murdoch_Student_ID, First_Name, Last_Name, Email, Status) VALUES ('12345678', 'Shi Qi','Fong', '12345678@student.murdoch.edu.au','C'), ('87654321', 'Edwin','Tan', '87654321@student.murdoch.edu.au','C');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employer`
--

CREATE TABLE `employer` (
  `Employer_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Contact_Number` varchar(15) NOT NULL,
  `Company_Name` varchar(80) NOT NULL,
  `Telephone` varchar(15) NOT NULL,
  `Website` tinytext DEFAULT NULL,
  `Country` varchar(15) NOT NULL, 
  `Address1` varchar(100) NOT NULL,
  `Address2` varchar(100),
  `Postal_Code` varchar(6) NOT NULL,
  `Company_Code` varchar(20) NOT NULL,
  `Status` varchar(10) NOT NULL,
  PRIMARY KEY (`Employer_ID`)
);
ALTER TABLE employer AUTO_INCREMENT = 1;

--
-- Dumping data for table `employer`
--

LOCK TABLES `employer` WRITE;
/*!40000 ALTER TABLE `employer` DISABLE KEYS */;
INSERT INTO `employer`(First_Name, Last_Name, Email, Contact_Number, Company_Name, Telephone, Website, Country, Address1, Address2, Postal_Code, Company_Code, Status) VALUES 
('Jasper','Tng', 'jasper.t@kopirun.sg', '91829123','Kopi Run Pte Ltd', '65432345', 'kopirun.sg', 'Singapore', 'Ang Mo Kio Ave 1 Street 40', 'Block A #01-20', '754010', '53066295K', 'Approved'),
('Amanda','Olivia', 'amanda.o@zeeky.com', '61298765432','Zeeky Pte Ltd', '61212345678', 'zeeky.com', 'Australia', '98 Shirley Street', 'PIMPAMA QLD', '4209', 'ACN 072 969 129', 'Approved');
/*!40000 ALTER TABLE `employer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing`
--

CREATE TABLE `listing` (
  `Listing_ID` int NOT NULL AUTO_INCREMENT,
  `Employer_ID` int NOT NULL,
  `Title` varchar(50) NOT NULL,
  `Description` text NOT NULL,
  `Closing_Date` datetime NOT NULL,
  `Available_Slot` int NOT NULL,
  `Status` varchar(10) NOT NULL,
  PRIMARY KEY (`Listing_ID`),
  FOREIGN KEY (`Employer_ID`) REFERENCES employer(`Employer_ID`)
);
ALTER TABLE listing AUTO_INCREMENT = 1;

--
-- Dumping data for table `listing`
--

LOCK TABLES `listing` WRITE;
/*!40000 ALTER TABLE `listing` DISABLE KEYS */;
INSERT INTO `listing`(Employer_ID, Title, Description, Closing_Date, Available_Slot, Status) VALUES 
('1','Product Engineer Internship', 'Modifications/implementation software automation test script.
Support SW testing.
May be able to help on coding, design if skillset meet.', '2022-03-22','2', 'Pending'),
('2','Marketing and Design Project Opportunity', 'Building a Digital Inventory System, taking part in frontend, backend and database designing.','2022/04/30','5', 'Pending');

/*!40000 ALTER TABLE `listing` ENABLE KEYS */;
UNLOCK TABLES;

CREATE EVENT update_listing_status
ON SCHEDULE EVERY 1 DAY 
STARTS CURRENT_TIMESTAMP
DO
  UPDATE listing SET Status = "Closed" WHERE Closing_Date < CURDATE();


--
-- Table structure for table `application`
--

CREATE TABLE `application` (
  `Application_ID` int NOT NULL AUTO_INCREMENT,
  `Listing_ID` int NOT NULL,
  `Student_ID` int NOT NULL,
  `Status` varchar(10) NOT NULL,
  PRIMARY KEY (`Application_ID`),
  FOREIGN KEY (`Listing_ID`) REFERENCES listing(`Listing_ID`),
  FOREIGN KEY (`Student_ID`) REFERENCES student(`Student_ID`)
);
ALTER TABLE application AUTO_INCREMENT = 1;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application`(Listing_ID, Student_ID, Status) VALUES 
(1, 1,'Matched'), 
(2, 1,'Failed'), 
(1, 2,'Cancelled'), 
(2, 2,'Pending');
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_testimonial`
--

CREATE TABLE `student_testimonial` (
  `Student_Testimonial_ID` int NOT NULL AUTO_INCREMENT,
  `Application_ID` int NOT NULL,
  `Created_By` int NOT NULL,
  `Created_On` DateTime NOT NULL,
  `Employer_ID` int NOT NULL,
  `Comment` text,
  `File` longblob,
  `Status` varchar(10) NOT NULL,
  PRIMARY KEY (`Student_Testimonial_ID`),
  FOREIGN KEY (`Application_ID`) REFERENCES application(`Application_ID`),
  FOREIGN KEY (`Created_By`) REFERENCES student(`Student_ID`)
);
ALTER TABLE student_testimonial AUTO_INCREMENT = 1;

--
-- Dumping data for table `student_testimonial`
--

LOCK TABLES `student_testimonial` WRITE;
/*!40000 ALTER TABLE `student_testimonial` DISABLE KEYS */;
INSERT INTO `student_testimonial`(Application_ID, Created_By, Created_On, Employer_ID, Comment, Status) VALUES 
(1, 1, now(),1, 'Fun and great learning space for students, enjoyed every moment here with KopiRun. Thank you Jasper', 'Approved');
/*!40000 ALTER TABLE `student_testimonial` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `employer_testimonial`
--

CREATE TABLE `employer_testimonial` (
  `Employer_Testimonial_ID` int NOT NULL AUTO_INCREMENT,
  `Application_ID` int NOT NULL,
  `Created_By` int NOT NULL,
  `Created_On` DateTime NOT NULL,
  `Student_ID` int NOT NULL,
  `Comment` text,
  `File` longblob,
  `Status` varchar(10) NOT NULL,
  PRIMARY KEY (`Employer_Testimonial_ID`),
  FOREIGN KEY (`Application_ID`) REFERENCES application(`Application_ID`),
  FOREIGN KEY (`Student_ID`) REFERENCES student(`Student_ID`),
  FOREIGN KEY (`Created_By`) REFERENCES employer(`Employer_ID`)
);
ALTER TABLE employer_testimonial AUTO_INCREMENT = 1;

--
-- Dumping data for table `student_testimonial`
--

LOCK TABLES `employer_testimonial` WRITE;
/*!40000 ALTER TABLE `employer_testimonial` DISABLE KEYS */;
INSERT INTO `employer_testimonial`(Application_ID, Student_ID, Created_By, Created_On, Comment, Status) VALUES 
(1, 1, 1, now(), 'Shi Qi carries a strong learner atitude, proves a bright future ahead. Even as her mentor, I had learnt great values from her.', 'Approved');
/*!40000 ALTER TABLE `employer_testimonial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `Role_ID` int NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` char(60) NOT NULL,
  `Last_Login` datetime DEFAULT NULL,
  `Super_Admin_ID` int DEFAULT NULL,
  `Portal_Manager_ID` int DEFAULT NULL,
  `Student_ID` int DEFAULT NULL,
  `Employer_ID` int DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  FOREIGN KEY (`Super_Admin_ID`) REFERENCES super_admin(`Super_Admin_ID`),
  FOREIGN KEY (`Portal_Manager_ID`) REFERENCES portal_manager(`Portal_Manager_ID`),
  FOREIGN KEY (`Student_ID`) REFERENCES student(`Student_ID`),
  FOREIGN KEY (`Employer_ID`) REFERENCES employer(`Employer_ID`)
);
ALTER TABLE user AUTO_INCREMENT = 1;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user`(Role_ID, Email, Password, Super_Admin_ID ) VALUES 
(1, 'anderson.l@murdoch.edu.au', '$2a$12$fum3HAhxbazh6Cq7QzRrG..5Cpe8WGluQDQOJ0JzXYjNo64KN3Yre', 1);
INSERT INTO `user`(Role_ID, Email, Password, Portal_Manager_ID ) VALUES 
(2, 'kathy.l@murdoch.edu.au', '$2a$12$FkJE360b51V80CgAZta04OemxoV/apAAsWiM94dwb5iXhImrca.hG', 1);
INSERT INTO `user`(Role_ID, Email, Password, Student_ID ) VALUES 
(3, '12345678@student.murdoch.edu.au', '$2a$12$y0ulEpxVDcz4e7VyS90bn.t3b3InbJbc6mpCe06QDzNNsJRXZO9Fy', 1),(3, '87654321@student.murdoch.edu.au', '$2a$12$y0ulEpxVDcz4e7VyS90bn.t3b3InbJbc6mpCe06QDzNNsJRXZO9Fy', 1);
INSERT INTO `user`(Role_ID, Email, Password, Employer_ID ) VALUES 
(4, 'jasper.t@kopirun.sg', '$2a$12$WH6z4NsRYEhyd.3uCM4TwenoqJ.j5o477blDKv6soalPKVKUAhOuu', 1),(4, 'amanda.o@zeeky.com', '$2a$12$WH6z4NsRYEhyd.3uCM4TwenoqJ.j5o477blDKv6soalPKVKUAhOuu', 2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


-- Dump completed on 2022-02-23 17:32:36