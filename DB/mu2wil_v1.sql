-- MySQL dump 1  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: mu2wil
-- ------------------------------------------------------
-- Server version	8.0.26

--
-- Table structure for table `access_list`
--

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
('Jasper','Tng', 'jasper.t@kopirun.sg', '91829123','Kopi Run Pte Ltd', '65432345', 'kopirun.sg', 'Singapore', 'Ang Mo Kio Ave 1 Street 40', 'Block A #01-20', '754010', '53066295K', 'Pending'),
('Amanda','Olivia', 'amanda.o@zeeky.com', '61298765432','Zeeky Pte Ltd', '61212345678', 'zeeky.com', 'Australia', '98 Shirley Street', 'PIMPAMA QLD', '4209', 'ACN 072 969 129', 'Pending');
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
May be able to help on coding, design if skillset meet.', '2022-05-20','2', 'Pending'),
('2','Marketing and Design Project Opportunity', 'Building a Digital Inventory System, taking part in frontend, backend and database designing.','2022/04/30','5', 'Pending');
/*!40000 ALTER TABLE `listing` ENABLE KEYS */;
UNLOCK TABLES;

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
(1, 2,'Appeal'), 
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
  `Employer_ID` int NOT NULL,
  `Comment` text,
  `File` blob,
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
INSERT INTO `student_testimonial`(Application_ID, Created_By, Employer_ID, Comment, File, Status) VALUES 
(1, 1, 1, 'Fun and great learning space for students, enjoyed every moment here with KopiRun. Thank you Jasper', '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', 'Pending');
/*!40000 ALTER TABLE `student_testimonial` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `employer_testimonial`
--

CREATE TABLE `employer_testimonial` (
  `Employer_Testimonial_ID` int NOT NULL AUTO_INCREMENT,
  `Application_ID` int NOT NULL,
  `Created_By` int NOT NULL,
  `Student_ID` int NOT NULL,
  `Comment` text,
  `File` blob,
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
INSERT INTO `employer_testimonial`(Application_ID, Student_ID, Created_By, Comment, File, Status) VALUES 
(1, 1, 1, 'Shi Qi carries a strong learner atitude, proves a bright future ahead. Even as her mentor, I had learnt great values from her.', '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', 'Pending');
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


CREATE EVENT IF NOT EXISTS update_listing_status
ON SCHEDULE EVERY 1 DAY 
STARTS CURRENT_TIMESTAMP
DO
  UPDATE listing SET Status = "Closed" WHERE Closing_Date < NOW();

-- Dump completed on 2022-02-23 17:32:36