/*
SQLyog Trial v13.1.8 (64 bit)
MySQL - 10.4.32-MariaDB : Database - expediaflightbooking
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`expediaflightbooking` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `expediaflightbooking`;

/*Table structure for table `airlines` */

DROP TABLE IF EXISTS `airlines`;

CREATE TABLE `airlines` (
  `airlineid` int(11) NOT NULL AUTO_INCREMENT,
  `airlinename` varchar(200) NOT NULL,
  `iatacode` varchar(50) DEFAULT NULL,
  `airlinelogo` varchar(255) DEFAULT NULL,
  `homecountryid` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`airlineid`),
  KEY `homecountryid` (`homecountryid`),
  CONSTRAINT `airlines_ibfk_1` FOREIGN KEY (`homecountryid`) REFERENCES `countries` (`countryid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `airlines` */

insert  into `airlines`(`airlineid`,`airlinename`,`iatacode`,`airlinelogo`,`homecountryid`,`email`,`website`) values 
(2,'Kenya Airways','','',NULL,'',''),
(4,'Safari Link','','Safarilink.jpg',NULL,'',''),
(5,'Kenya Airways','KQ','kenya_airways.png',1,'info@kenya-airways.com','https://www.kenya-airways.com'),
(6,'Uganda Airlines','UR','uganda_airlines.png',2,'info@ugandairlines.com','https://www.ugandairlines.com'),
(7,'Air Tanzania','TC','air_tanzania.png',3,'info@airtanzania.com','https://www.airtanzania.com'),
(8,'Ethiopian Airlines','ET','ethiopian_airlines.png',4,'info@ethiopianairlines.com','https://www.ethiopianairlines.com'),
(9,'RwandAir','WB','rwandair.png',5,'info@rwandair.com','https://www.rwandair.com'),
(10,'Delta Airlines','DL','delta.png',6,'info@delta.com','https://www.delta.com'),
(11,'British Airways','BA','british_airways.png',7,'info@ba.com','https://www.britishairways.com'),
(12,'Emirates','EK','emirates.png',8,'info@emirates.com','https://www.emirates.com'),
(13,'South African Airways','SA','saa.png',9,'info@flysaa.com','https://www.flysaa.com'),
(14,'Air India','AI','airindia.png',10,'info@airindia.in','https://www.airindia.in');

/*Table structure for table `airports` */

DROP TABLE IF EXISTS `airports`;

CREATE TABLE `airports` (
  `airportid` int(11) NOT NULL AUTO_INCREMENT,
  `airportname` varchar(200) NOT NULL,
  `iatacode` varchar(10) DEFAULT NULL,
  `cityid` int(11) DEFAULT NULL,
  PRIMARY KEY (`airportid`),
  KEY `cityid` (`cityid`),
  CONSTRAINT `airports_ibfk_1` FOREIGN KEY (`cityid`) REFERENCES `cities` (`cityid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `airports` */

insert  into `airports`(`airportid`,`airportname`,`iatacode`,`cityid`) values 
(1,'Jomo Kenyatta International Airport','NBO',1),
(2,'Moi International Airport','MBA',2),
(3,'Entebbe International Airport','EBB',4),
(4,'Julius Nyerere International Airport','DAR',5),
(5,'Abeid Amani Karume International Airport','ZNZ',6),
(6,'Addis Ababa Bole International Airport','ADD',7),
(7,'Kigali International Airport','KGL',8),
(8,'John F. Kennedy International Airport','JFK',9),
(9,'Heathrow Airport','LHR',10),
(10,'Dubai International Airport','DXB',11),
(11,'O. R. Tambo International Airport','JNB',12),
(12,'Chhatrapati Shivaji Maharaj International Airport','BOM',13);

/*Table structure for table `cities` */

DROP TABLE IF EXISTS `cities`;

CREATE TABLE `cities` (
  `cityid` int(11) NOT NULL AUTO_INCREMENT,
  `cityname` varchar(200) NOT NULL,
  `countryid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cityid`),
  KEY `countryid` (`countryid`),
  CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`countryid`) REFERENCES `countries` (`countryid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `cities` */

insert  into `cities`(`cityid`,`cityname`,`countryid`) values 
(1,'Nairobi',1),
(2,'Mombasa',1),
(3,'Kampala',2),
(4,'Entebbe',2),
(5,'Dar es Salaam',3),
(6,'Zanzibar',3),
(7,'Addis Ababa',4),
(8,'Kigali',5),
(9,'New York',6),
(10,'London',7),
(11,'Dubai',8),
(12,'Johannesburg',9),
(13,'Mumbai',10);

/*Table structure for table `countries` */

DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `countryid` int(11) NOT NULL AUTO_INCREMENT,
  `countryname` varchar(200) NOT NULL,
  `countrycode` varchar(10) NOT NULL,
  PRIMARY KEY (`countryid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `countries` */

insert  into `countries`(`countryid`,`countryname`,`countrycode`) values 
(1,'Kenya',''),
(2,'Uganda',''),
(3,'Tanzania',''),
(4,'Ethiopia',''),
(5,'Rwanda',''),
(6,'United States',''),
(7,'United Kingdom',''),
(8,'United Arab Emirates',''),
(9,'South Africa',''),
(10,'India','');

/*Table structure for table `flightbooking` */

DROP TABLE IF EXISTS `flightbooking`;

CREATE TABLE `flightbooking` (
  `bookingid` int(11) NOT NULL AUTO_INCREMENT,
  `passengerid` int(11) DEFAULT NULL,
  `flightid` int(11) DEFAULT NULL,
  `bookingdate` datetime DEFAULT current_timestamp(),
  `paymentmethodid` int(11) DEFAULT NULL,
  `totalamount` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bookingid`),
  KEY `passengerid` (`passengerid`),
  KEY `flightid` (`flightid`),
  KEY `paymentmethodid` (`paymentmethodid`),
  CONSTRAINT `flightbooking_ibfk_1` FOREIGN KEY (`passengerid`) REFERENCES `passengers` (`passengerid`),
  CONSTRAINT `flightbooking_ibfk_2` FOREIGN KEY (`flightid`) REFERENCES `flights` (`flightid`),
  CONSTRAINT `flightbooking_ibfk_3` FOREIGN KEY (`paymentmethodid`) REFERENCES `paymentmethods` (`paymentmethodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `flightbooking` */

/*Table structure for table `flightclasses` */

DROP TABLE IF EXISTS `flightclasses`;

CREATE TABLE `flightclasses` (
  `classid` int(11) NOT NULL AUTO_INCREMENT,
  `classname` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`classid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `flightclasses` */

/*Table structure for table `flights` */

DROP TABLE IF EXISTS `flights`;

CREATE TABLE `flights` (
  `flightid` int(11) NOT NULL AUTO_INCREMENT,
  `airlineid` int(11) DEFAULT NULL,
  `departureairportid` int(11) DEFAULT NULL,
  `arrivalairportid` int(11) DEFAULT NULL,
  `departuretime` datetime DEFAULT NULL,
  `arrivaltime` datetime DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`flightid`),
  KEY `airlineid` (`airlineid`),
  KEY `departureairportid` (`departureairportid`),
  KEY `arrivalairportid` (`arrivalairportid`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`airlineid`) REFERENCES `airlines` (`airlineid`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`departureairportid`) REFERENCES `airports` (`airportid`),
  CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`arrivalairportid`) REFERENCES `airports` (`airportid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `flights` */

/*Table structure for table `passengers` */

DROP TABLE IF EXISTS `passengers`;

CREATE TABLE `passengers` (
  `passengerid` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `phonenumber` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`passengerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `passengers` */

/*Table structure for table `paymentmethods` */

DROP TABLE IF EXISTS `paymentmethods`;

CREATE TABLE `paymentmethods` (
  `paymentmethodid` int(11) NOT NULL AUTO_INCREMENT,
  `methodname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`paymentmethodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `paymentmethods` */

/*Table structure for table `traveldocuments` */

DROP TABLE IF EXISTS `traveldocuments`;

CREATE TABLE `traveldocuments` (
  `documentid` int(11) NOT NULL AUTO_INCREMENT,
  `passengerid` int(11) DEFAULT NULL,
  `documenttype` varchar(50) DEFAULT NULL,
  `documentnumber` varchar(100) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  PRIMARY KEY (`documentid`),
  KEY `passengerid` (`passengerid`),
  CONSTRAINT `traveldocuments_ibfk_1` FOREIGN KEY (`passengerid`) REFERENCES `passengers` (`passengerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `traveldocuments` */

/* Procedure structure for procedure `sp_Airline_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Airline_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Airline_Add`(IN p_name VARCHAR(100), IN p_logo VARCHAR(255))
BEGIN
    INSERT INTO Airline(airlinename, airlinelogo) VALUES(p_name, p_logo);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Airline_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Airline_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Airline_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Airline WHERE airlineid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Airline_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Airline_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Airline_Get`()
BEGIN
    SELECT * FROM Airline;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Airline_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Airline_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Airline_Update`(IN p_id INT, IN p_name VARCHAR(100), IN p_logo VARCHAR(255))
BEGIN
    UPDATE Airline SET airlinename = p_name, airlinelogo = p_logo WHERE airlineid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Airport_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Airport_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Airport_Add`(IN p_code VARCHAR(10), IN p_name VARCHAR(100), IN p_cityid INT)
BEGIN
    INSERT INTO Airports(airportcode, airportname, cityid) VALUES(p_code, p_name, p_cityid);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Airport_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Airport_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Airport_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Airports WHERE airportid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Airport_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Airport_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Airport_Get`()
BEGIN
    SELECT * FROM Airports;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Airport_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Airport_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Airport_Update`(IN p_id INT, IN p_code VARCHAR(10), IN p_name VARCHAR(100), IN p_cityid INT)
BEGIN
    UPDATE Airports SET airportcode = p_code, airportname = p_name, cityid = p_cityid WHERE airportid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_BookingClass_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_BookingClass_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BookingClass_Add`(IN p_classname VARCHAR(50))
BEGIN
    INSERT INTO Bookingclass(classname) VALUES(p_classname);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_BookingClass_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_BookingClass_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BookingClass_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Bookingclass WHERE classid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_BookingClass_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_BookingClass_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BookingClass_Get`()
BEGIN
    SELECT * FROM Bookingclass;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_BookingClass_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_BookingClass_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BookingClass_Update`(IN p_id INT, IN p_classname VARCHAR(50))
BEGIN
    UPDATE Bookingclass SET classname = p_classname WHERE classid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_BookingType_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_BookingType_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BookingType_Add`(IN p_typename VARCHAR(50))
BEGIN
    INSERT INTO Bookingtype(typename) VALUES(p_typename);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_BookingType_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_BookingType_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BookingType_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Bookingtype WHERE typeid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_BookingType_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_BookingType_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BookingType_Get`()
BEGIN
    SELECT * FROM Bookingtype;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_BookingType_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_BookingType_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BookingType_Update`(IN p_id INT, IN p_typename VARCHAR(50))
BEGIN
    UPDATE Bookingtype SET typename = p_typename WHERE typeid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_City_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_City_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_City_Add`(IN p_cityname VARCHAR(100), IN p_countryid INT)
BEGIN
    INSERT INTO City(cityname, countryid) VALUES(p_cityname, p_countryid);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_City_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_City_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_City_Delete`(IN p_cityid INT)
BEGIN
    DELETE FROM City WHERE cityid = p_cityid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_City_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_City_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_City_Get`()
BEGIN
    SELECT * FROM City;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_City_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_City_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_City_Update`(IN p_cityid INT, IN p_cityname VARCHAR(100), IN p_countryid INT)
BEGIN
    UPDATE City SET cityname = p_cityname, countryid = p_countryid WHERE cityid = p_cityid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Country_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Country_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Country_Add`(IN p_countryname VARCHAR(100))
BEGIN
    INSERT INTO Country(countryname) VALUES(p_countryname);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Country_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Country_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Country_Delete`(IN p_countryid INT)
BEGIN
    DELETE FROM Country WHERE countryid = p_countryid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Country_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Country_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Country_Get`()
BEGIN
    SELECT * FROM Country;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Country_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Country_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Country_Update`(IN p_countryid INT, IN p_countryname VARCHAR(100))
BEGIN
    UPDATE Country SET countryname = p_countryname WHERE countryid = p_countryid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteairline` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteairline` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteairline`(IN p_id INT)
BEGIN
    DELETE FROM airlines WHERE airlineid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_filterairlines` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_filterairlines` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_filterairlines`(
    IN p_airlinename VARCHAR(200),
    IN p_countryname VARCHAR(200)
)
BEGIN
    SELECT a.airlineid, a.airlinename, a.iatacode, a.airlinelogo, c.countryname, a.email, a.website
    FROM airlines a
    JOIN countries c ON a.homecountryid = c.countryid
    WHERE (p_airlinename = '' OR LOWER(a.airlinename) LIKE CONCAT('%', LOWER(p_airlinename), '%'))
      AND (p_countryname = '' OR LOWER(c.countryname) LIKE CONCAT('%', LOWER(p_countryname), '%'));
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBookingClass_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBookingClass_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBookingClass_Add`(IN p_bookingid INT, IN p_noofseats INT, IN p_unitprice DECIMAL(10,2), IN p_currencyid INT)
BEGIN
    INSERT INTO Flightbookingclasses(bookingid, noofseats, unitprice, currencyid)
    VALUES(p_bookingid, p_noofseats, p_unitprice, p_currencyid);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBookingClass_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBookingClass_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBookingClass_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Flightbookingclasses WHERE bookingclassid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBookingClass_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBookingClass_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBookingClass_Get`()
BEGIN
    SELECT * FROM Flightbookingclasses;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBookingClass_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBookingClass_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBookingClass_Update`(IN p_id INT, IN p_bookingid INT, IN p_noofseats INT, IN p_unitprice DECIMAL(10,2), IN p_currencyid INT)
BEGIN
    UPDATE Flightbookingclasses
    SET bookingid = p_bookingid, noofseats = p_noofseats, unitprice = p_unitprice, currencyid = p_currencyid
    WHERE bookingclassid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBookingPassenger_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBookingPassenger_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBookingPassenger_Add`(
    IN p_bookingclassid INT, IN p_documentid INT, IN p_iddocumentno VARCHAR(50),
    IN p_firstname VARCHAR(50), IN p_middlename VARCHAR(50),
    IN p_lastname VARCHAR(50), IN p_gender VARCHAR(10), IN p_dateofbirth DATE)
BEGIN
    INSERT INTO Flightbookingpassengers(bookingclassid, documentid, iddocumentno, firstname, middlename, lastname, gender, dateofbirth)
    VALUES(p_bookingclassid, p_documentid, p_iddocumentno, p_firstname, p_middlename, p_lastname, p_gender, p_dateofbirth);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBookingPassenger_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBookingPassenger_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBookingPassenger_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Flightbookingpassengers WHERE passengerbookingid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBookingPassenger_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBookingPassenger_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBookingPassenger_Get`()
BEGIN
    SELECT * FROM Flightbookingpassengers;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBookingPassenger_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBookingPassenger_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBookingPassenger_Update`(
    IN p_id INT, IN p_bookingclassid INT, IN p_documentid INT, IN p_iddocumentno VARCHAR(50),
    IN p_firstname VARCHAR(50), IN p_middlename VARCHAR(50),
    IN p_lastname VARCHAR(50), IN p_gender VARCHAR(10), IN p_dateofbirth DATE)
BEGIN
    UPDATE Flightbookingpassengers
    SET bookingclassid = p_bookingclassid, documentid = p_documentid, iddocumentno = p_iddocumentno,
        firstname = p_firstname, middlename = p_middlename, lastname = p_lastname, gender = p_gender, dateofbirth = p_dateofbirth
    WHERE passengerbookingid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBooking_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBooking_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBooking_Add`(IN p_flightid INT, IN p_bookingdate DATE, IN p_paymentmethod INT, IN p_bookingtypeid INT)
BEGIN
    INSERT INTO Flightbooking(flightid, bookingdate, paymentmethod, bookingtypeid)
    VALUES(p_flightid, p_bookingdate, p_paymentmethod, p_bookingtypeid);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBooking_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBooking_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBooking_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Flightbooking WHERE bookingid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBooking_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBooking_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBooking_Get`()
BEGIN
    SELECT * FROM Flightbooking;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightBooking_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightBooking_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightBooking_Update`(IN p_id INT, IN p_flightid INT, IN p_bookingdate DATE, IN p_paymentmethod INT, IN p_bookingtypeid INT)
BEGIN
    UPDATE Flightbooking
    SET flightid = p_flightid, bookingdate = p_bookingdate, paymentmethod = p_paymentmethod, bookingtypeid = p_bookingtypeid
    WHERE bookingid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightClass_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightClass_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightClass_Add`(IN p_flightid INT, IN p_bookingclassid INT, IN p_unitprice DECIMAL(10,2), IN p_noofseats INT, IN p_currencyid INT)
BEGIN
    INSERT INTO Flightclasses(flightid, bookingclassid, unitprice, noofseats, currencyid)
    VALUES(p_flightid, p_bookingclassid, p_unitprice, p_noofseats, p_currencyid);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightClass_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightClass_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightClass_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Flightclasses WHERE flightclassid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightClass_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightClass_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightClass_Get`()
BEGIN
    SELECT * FROM Flightclasses;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_FlightClass_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_FlightClass_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FlightClass_Update`(IN p_id INT, IN p_flightid INT, IN p_bookingclassid INT, IN p_unitprice DECIMAL(10,2), IN p_noofseats INT, IN p_currencyid INT)
BEGIN
    UPDATE Flightclasses
    SET flightid = p_flightid, bookingclassid = p_bookingclassid, unitprice = p_unitprice, noofseats = p_noofseats, currencyid = p_currencyid
    WHERE flightclassid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Flight_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Flight_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Flight_Add`(
    IN p_airlineid INT, IN p_flightno VARCHAR(20),
    IN p_departurecity INT, IN p_destinationcity INT,
    IN p_departuretime DATETIME, IN p_duration INT, IN p_departureairportid INT)
BEGIN
    INSERT INTO Flights(airlineid, flightno, departurecity, destinationcity, departuretime, duration, departureairportid)
    VALUES(p_airlineid, p_flightno, p_departurecity, p_destinationcity, p_departuretime, p_duration, p_departureairportid);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Flight_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Flight_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Flight_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Flights WHERE flightid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Flight_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Flight_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Flight_Get`()
BEGIN
    SELECT * FROM Flights;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_Flight_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_Flight_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Flight_Update`(
    IN p_id INT, IN p_airlineid INT, IN p_flightno VARCHAR(20),
    IN p_departurecity INT, IN p_destinationcity INT,
    IN p_departuretime DATETIME, IN p_duration INT, IN p_departureairportid INT)
BEGIN
    UPDATE Flights
    SET airlineid = p_airlineid, flightno = p_flightno, departurecity = p_departurecity,
        destinationcity = p_destinationcity, departuretime = p_departuretime,
        duration = p_duration, departureairportid = p_departureairportid
    WHERE flightid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getairlinedetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getairlinedetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getairlinedetails`(IN p_id INT)
BEGIN
    SELECT * FROM airlines WHERE airlineid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getairlines` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getairlines` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getairlines`()
BEGIN
    SELECT a.*, c.countryname
    FROM airlines a
    LEFT JOIN countries c ON a.homecountryid = c.countryid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcities` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcities` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcities`()
BEGIN
    SELECT ci.*, co.countryname
    FROM cities ci
    LEFT JOIN countries co ON ci.countryid = co.countryid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcountries` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcountries` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcountries`()
BEGIN
    SELECT * FROM countries;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getflights` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getflights` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getflights`()
BEGIN
    SELECT f.*, a.airlinename, da.airportname AS departure, aa.airportname AS arrival
    FROM flights f
    JOIN airlines a ON f.airlineid = a.airlineid
    JOIN airports da ON f.departureairportid = da.airportid
    JOIN airports aa ON f.arrivalairportid = aa.airportid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_PaymentMethod_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_PaymentMethod_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_PaymentMethod_Add`(IN p_methodname VARCHAR(50))
BEGIN
    INSERT INTO Paymentmethods(methodname) VALUES(p_methodname);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_PaymentMethod_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_PaymentMethod_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_PaymentMethod_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Paymentmethods WHERE methodid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_PaymentMethod_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_PaymentMethod_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_PaymentMethod_Get`()
BEGIN
    SELECT * FROM Paymentmethods;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_PaymentMethod_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_PaymentMethod_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_PaymentMethod_Update`(IN p_id INT, IN p_methodname VARCHAR(50))
BEGIN
    UPDATE Paymentmethods SET methodname = p_methodname WHERE methodid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_saveairline` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_saveairline` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveairline`(
    IN p_id INT,
    IN p_name VARCHAR(200),
    IN p_iatacode VARCHAR(50),
    IN p_logo VARCHAR(255),
    IN p_countryid INT,
    IN p_email VARCHAR(255),
    IN p_website VARCHAR(255)
)
BEGIN
    -- If user sends 0 for country, replace with NULL
    IF p_countryid = 0 THEN
        SET p_countryid = NULL;
    END IF;

    IF p_id = 0 THEN
        INSERT INTO airlines (airlinename, iatacode, airlinelogo, homecountryid, email, website)
        VALUES (p_name, p_iatacode, p_logo, p_countryid, p_email, p_website);
    ELSE
        UPDATE airlines
        SET airlinename   = p_name,
            iatacode      = p_iatacode,
            airlinelogo   = p_logo,
            homecountryid = p_countryid,
            email         = p_email,
            website       = p_website
        WHERE airlineid = p_id;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savebooking` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savebooking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savebooking`(IN p_id INT, IN p_passengerid INT, IN p_flightid INT, IN p_paymentmethodid INT, IN p_amount DECIMAL(10,2), IN p_status VARCHAR(50))
BEGIN
    IF p_id = 0 THEN
        INSERT INTO flightbooking(passengerid, flightid, paymentmethodid, totalamount, status)
        VALUES(p_passengerid, p_flightid, p_paymentmethodid, p_amount, p_status);
    ELSE
        UPDATE flightbooking
        SET passengerid = p_passengerid,
            flightid = p_flightid,
            paymentmethodid = p_paymentmethodid,
            totalamount = p_amount,
            status = p_status
        WHERE bookingid = p_id;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savecity` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savecity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecity`(IN p_id INT, IN p_name VARCHAR(200), IN p_countryid INT)
BEGIN
    IF p_id = 0 THEN
        INSERT INTO cities(cityname, countryid) VALUES(p_name, p_countryid);
    ELSE
        UPDATE cities SET cityname = p_name, countryid = p_countryid WHERE cityid = p_id;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savecountry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savecountry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecountry`(IN p_id INT, IN p_name VARCHAR(200), IN p_code VARCHAR(10))
BEGIN
    IF p_id = 0 THEN
        INSERT INTO countries(countryname, countrycode) VALUES(p_name, p_code);
    ELSE
        UPDATE countries SET countryname = p_name, countrycode = p_code WHERE countryid = p_id;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_saveflight` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_saveflight` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveflight`(
    IN p_id INT,
    IN p_airlineid INT,
    IN p_departureairport INT,
    IN p_arrivalairport INT,
    IN p_departuretime DATETIME,
    IN p_arrivaltime DATETIME,
    IN p_price DECIMAL(10,2)
)
BEGIN
    IF p_id = 0 THEN
        INSERT INTO flights(airlineid, departureairportid, arrivalairportid, departuretime, arrivaltime, price)
        VALUES(p_airlineid, p_departureairport, p_arrivalairport, p_departuretime, p_arrivaltime, p_price);
    ELSE
        UPDATE flights
        SET airlineid = p_airlineid,
            departureairportid = p_departureairport,
            arrivalairportid = p_arrivalairport,
            departuretime = p_departuretime,
            arrivaltime = p_arrivaltime,
            price = p_price
        WHERE flightid = p_id;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savepassenger` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savepassenger` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savepassenger`(IN p_id INT, IN p_first VARCHAR(100), IN p_last VARCHAR(100), IN p_email VARCHAR(200), IN p_phone VARCHAR(50))
BEGIN
    IF p_id = 0 THEN
        INSERT INTO passengers(firstname, lastname, email, phonenumber) VALUES(p_first, p_last, p_email, p_phone);
    ELSE
        UPDATE passengers SET firstname = p_first, lastname = p_last, email = p_email, phonenumber = p_phone WHERE passengerid = p_id;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_TravelDocument_Add` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_TravelDocument_Add` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TravelDocument_Add`(IN p_name VARCHAR(50), IN p_expires DATE)
BEGIN
    INSERT INTO Traveldocuments(documentname, documentexpires) VALUES(p_name, p_expires);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_TravelDocument_Delete` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_TravelDocument_Delete` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TravelDocument_Delete`(IN p_id INT)
BEGIN
    DELETE FROM Traveldocuments WHERE documentid = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_TravelDocument_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_TravelDocument_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TravelDocument_Get`()
BEGIN
    SELECT * FROM Traveldocuments;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_TravelDocument_Update` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_TravelDocument_Update` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TravelDocument_Update`(IN p_id INT, IN p_name VARCHAR(50), IN p_expires DATE)
BEGIN
    UPDATE Traveldocuments SET documentname = p_name, documentexpires = p_expires WHERE documentid = p_id;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
