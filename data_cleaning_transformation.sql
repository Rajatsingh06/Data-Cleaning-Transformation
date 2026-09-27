-- ============================================================
-- MINI PROJECT 03: DATA CLEANING & TRANSFORMATION
-- ============================================================
-- Database: MySQL 8.0+
-- Dataset: 1,020 deliberately messy customer/order records
-- Purpose: Practice NULL handling, cleaning, transformation,
--          string manipulation, duplicates, UPDATE, CASE logic,
--          validation, and standardisation.
--
-- Run this entire file in MySQL Workbench / MySQL command line.
-- ============================================================

DROP DATABASE IF EXISTS mini_project_03;
CREATE DATABASE mini_project_03;
USE mini_project_03;

-- ------------------------------------------------------------
-- 1. RAW TABLE
-- ------------------------------------------------------------
DROP TABLE IF EXISTS orders_raw;

CREATE TABLE orders_raw (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(50),
    city VARCHAR(50),
    product VARCHAR(150),
    quantity INT,
    order_status VARCHAR(30),
    order_date DATE,
    order_total DECIMAL(12,2)
);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(1,'ANANYA SINGH','ananyasingh1@OUTLOOK.COM','+91-70518-02512','Delhi','Keyboard - Electronics',1,'return','2025-12-18',1800),
(2,'Priya Mehta','priyamehta2@','(613) 650-5587','Bengaluru','Wireless Mouse - Electronics',2,'Pending','2025-09-20',2400),
(3,'Rajat Rao','rajatrao3 @ yahoo.com','+91 9075280817',NULL,'Smartphone - Electronics',NULL,'cancelled','2025-04-15',NULL),
(4,'Manish Reddy',NULL,'92590 52811','Mumbai','Smartphone - Electronics',4,'Cancelled','2025-05-05',168000),
(5,'Vikram Gupta','vikramgupta5@gmail.com',NULL,'Pune','Wireless Mouse - Electronics',3,'Cancelled','2025-10-09',3600),
(6,'Aarav Joshi','aaravjoshi6@gmail.com','9961228449','Pune','Wireless Mouse - Electronics',NULL,'pending','2025-11-20',NULL),
(7,'Pooja Mehta','poojamehta7@yahoo.com','9026113008','Bangalore','Laptop - Electronics',2,'pending','2025-02-28',130000),
(8,'Neha Sharma','nehasharma8@example.com','7193887545','Chennai','Water Bottle - Lifestyle',3,'COMPLETE','2025-06-12',2100),
(9,'  vikram reddy  ','vikramreddy9@gmail.com','+91-86161-97747',NULL,'Keyboard - Electronics',NULL,'Pending','2025-03-15',NULL),
(10,'ROHAN REDDY',' rohanreddy10@yahoo.com ','(894) 039-5823','Hyderabad','Table Lamp - Home',1,'Pending','2025-01-26',1600),
(11,'Arjun Verma','arjunverma11@OUTLOOK.COM','+91 6284277889','Delhi','Coffee Mug - Home',3,'Pending','2025-11-16',1350),
(12,'Rohan Joshi','rohanjoshi12@','71376 51678','Mumbai','Office Chair - Furniture',NULL,'shipped','2025-05-24',NULL),
(13,'Manish Verma','manishverma13 @ example.com',NULL,'Delhi','Keyboard - Electronics',NULL,'Shipped','2025-02-25',NULL),
(14,'Aarav Sharma',NULL,'8694860228','Mumbai','USB Cable - Electronics',4,'Returned','2025-02-13',2000),
(15,'Rohan Mehta','rohanmehta15@example.com','8272528809','New Delhi','Notebook - Stationery',1,'return','2025-12-04',250),
(16,'Nisha Reddy','nishareddy16@outlook.com','6479112937','New Delhi','Headphones - Electronics',1,'Shipped','2025-01-24',3200),
(17,'Amit Rao','amitrao17@yahoo.com','+91-81804-76188','Bangalore','Table Lamp - Home',2,'return','2025-09-20',3200),
(18,'  vikram patel  ','vikrampatel18@outlook.com','(927) 495-8945','Mumbai','Notebook - Stationery',NULL,'Completed','2025-10-11',NULL),
(19,'DIVYA SINGH','divyasingh19@gmail.com','+91 9990448177','Hyderabad','Coffee Mug - Home',2,'Pending','2025-01-08',900),
(20,'Manish Sharma',' manishsharma20@gmail.com ','91435 19183','Chennai','Table Lamp - Home',1,'shipped','2025-03-05',1600),
(21,'Divya Rao','divyarao21@YAHOO.COM',NULL,'Kolkata','Table Lamp - Home',4,'Pending','2025-09-25',6400),
(22,'Vikram Reddy','vikramreddy22@','8884873529',NULL,'Monitor - Electronics',5,'shipped','2025-08-04',72500),
(23,'Neha Kumar','nehakumar23 @ gmail.com','7452066459','Bengaluru','Pen Set - Stationery',NULL,'Pending','2025-10-08',NULL),
(24,'Rajat Sharma',NULL,'6983297492','Bangalore','Coffee Mug - Home',1,'Cancelled','2025-02-17',450),
(25,'Neha Reddy','nehareddy25@example.com','+91-69201-40090','Kolkata','Keyboard - Electronics',5,'Pending','2025-08-26',9000),
(26,'Meera Kumar','meerakumar26@gmail.com','(641) 631-4667',NULL,'Headphones - Electronics',3,'cancelled','2025-07-15',9600),
(27,'  aarav sharma  ','aaravsharma27@gmail.com','+91 7729245242','Hyderabad','USB Cable - Electronics',1,'Pending','2025-04-07',500),
(28,'NISHA JOSHI','nishajoshi28@yahoo.com','78119 67841','Mumbai','Desk - Furniture',5,'Pending','2025-02-15',60000),
(29,'Nisha Sharma','nishasharma29@gmail.com',NULL,'Kolkata','Table Lamp - Home',1,'completed','2025-04-06',1600),
(30,'Meera Joshi',' meerajoshi30@example.com ','6918037633','Pune','Coffee Mug - Home',1,'COMPLETE','2025-07-01',450),
(31,'Rohan Reddy','rohanreddy31@EXAMPLE.COM','7225136114','Pune','Smartphone - Electronics',NULL,'return','2025-12-16',NULL),
(32,'Rahul Kumar','rahulkumar32@','6935018220','Bengaluru','Pen Set - Stationery',NULL,'Completed','2025-12-11',NULL),
(33,'Aarav Singh','aaravsingh33 @ example.com','+91-81597-25924','Kolkata','Keyboard - Electronics',1,'shipped','2025-02-28',1800),
(34,'Sneha Sharma',NULL,'(890) 001-5820','Delhi','Headphones - Electronics',1,'Returned','2025-04-19',3200),
(35,'Isha Singh','ishasingh35@gmail.com','+91 7800557283',NULL,'Pen Set - Stationery',NULL,'Cancelled','2025-05-07',NULL),
(36,'  arjun kumar  ','arjunkumar36@outlook.com','76998 87270','Mumbai','Water Bottle - Lifestyle',2,'Shipped','2025-06-25',1400),
(37,'PRIYA SINGH','priyasingh37@example.com',NULL,'Ahmedabad','Wireless Mouse - Electronics',0,'Completed','2025-04-17',0),
(38,'Amit Patel','amitpatel38@outlook.com','9783282817','Bangalore','Coffee Mug - Home',2,'Cancelled','2025-05-06',900),
(39,'Karan Rao','karanrao39@outlook.com','8627135980',NULL,'Notebook - Stationery',1,'return','2025-09-10',250),
(40,'Ananya Patel',' ananyapatel40@outlook.com ','6495762348','Bangalore','Smartphone - Electronics',NULL,'COMPLETE','2025-05-10',NULL),
(41,'Isha Kumar','ishakumar41@OUTLOOK.COM','+91-68744-43787',NULL,'Water Bottle - Lifestyle',2,'shipped','2025-08-09',1400),
(42,'Aarav Sharma','aaravsharma42@','(956) 202-2940','New Delhi','Laptop - Electronics',1,'Cancelled','2025-03-21',65000),
(43,'Amit Patel','amitpatel43 @ example.com','+91 8369449369','Pune','Notebook - Stationery',1,'completed','2025-02-23',250),
(44,'Rahul Rao',NULL,'95845 58315','Hyderabad','Pen Set - Stationery',NULL,'COMPLETE','2025-07-05',NULL),
(45,'  aarav reddy  ','aaravreddy45@outlook.com',NULL,'Bengaluru','Coffee Mug - Home',3,'Pending','2025-11-08',1350),
(46,'ANANYA GUPTA','ananyagupta46@example.com','8665720874','Mumbai','Coffee Mug - Home',2,'COMPLETE','2025-03-14',900),
(47,'Rajat Patel','rajatpatel47@outlook.com','9360324392','Pune','USB Cable - Electronics',2,'pending','2025-03-26',1000),
(48,'Ananya Verma','ananyaverma48@gmail.com','9687629943','Chennai','Office Chair - Furniture',2,'Shipped','2025-06-10',17000),
(49,'Neha Kumar','nehakumar49@gmail.com','+91-88348-20954','Delhi','Headphones - Electronics',3,'pending','2025-02-25',9600),
(50,'Amit Gupta',' amitgupta50@example.com ','(891) 850-8077','Kolkata','Monitor - Electronics',1,'completed','2025-05-06',14500),
(51,'Manish Reddy','manishreddy51@GMAIL.COM','+91 6465585404','Ahmedabad','Headphones - Electronics',3,'Cancelled','2025-07-20',9600),
(52,'Suresh Sharma','sureshsharma52@','98633 43401','Ahmedabad','Office Chair - Furniture',2,'Completed','2025-12-14',17000),
(53,'Rajat Rao','rajatrao53 @ yahoo.com',NULL,'Pune','Wireless Mouse - Electronics',3,NULL,'2025-06-22',3600),
(54,'  ananya reddy  ',NULL,'8864283209','Pune','Monitor - Electronics',4,'pending','2025-09-05',58000),
(55,'VIKRAM VERMA','vikramverma55@example.com','8909058412','Mumbai','Pen Set - Stationery',2,'cancelled','2025-09-27',360),
(56,'Rajat Reddy','rajatreddy56@outlook.com','6902727745','Pune','USB Cable - Electronics',3,'Shipped','2025-08-15',1500),
(57,'Vikram Rao','vikramrao57@example.com','+91-94090-67573','Mumbai','Water Bottle - Lifestyle',1,'pending','2025-09-22',700),
(58,'Isha Gupta','ishagupta58@gmail.com','(951) 510-1988','Delhi','Water Bottle - Lifestyle',2,'Pending','2025-04-05',1400),
(59,'Rajat Singh','rajatsingh59@yahoo.com','+91 8040695043','Ahmedabad','Table Lamp - Home',1,'Shipped','2025-07-21',1600),
(60,'Manish Kumar',' manishkumar60@example.com ','81233 33781','Pune','Office Chair - Furniture',1,'return','2025-12-01',8500),
(61,'Ananya Verma','ananyaverma61@YAHOO.COM',NULL,'Kolkata','Backpack - Accessories',1,'shipped','2025-04-28',1800),
(62,'Ananya Joshi','ananyajoshi62@','9442058095','Chennai','Water Bottle - Lifestyle',NULL,'shipped','2025-10-11',NULL),
(63,'  karan mehta  ','karanmehta63 @ example.com','9567267411','Kolkata','Backpack - Accessories',1,'Shipped','2025-08-09',1800),
(64,'NEHA REDDY',NULL,'8691864041','Delhi','Desk - Furniture',5,'completed','2025-12-10',60000),
(65,'Neha Reddy','nehareddy65@outlook.com','+91-73731-42116','Kolkata','Wireless Mouse - Electronics',1,'COMPLETE','2025-04-13',1200),
(66,'Rahul Kumar','rahulkumar66@gmail.com','(778) 184-4052','Pune','Monitor - Electronics',NULL,'Shipped','2025-07-02',NULL),
(67,'Vikram Verma','vikramverma67@example.com','+91 9886251649','Ahmedabad','Smartphone - Electronics',1,'Returned','2025-07-16',42000),
(68,'Rajat Gupta','rajatgupta68@outlook.com','92361 51037','Pune','Table Lamp - Home',4,'shipped','2025-12-24',6400),
(69,'Nisha Mehta','nishamehta69@yahoo.com',NULL,'Delhi','Desk - Furniture',4,'Shipped','2025-01-13',48000),
(70,'Arjun Verma',' arjunverma70@yahoo.com ','9609944328','Chennai','Coffee Mug - Home',1,'Returned','2025-09-01',450),
(71,'Rohan Mehta','rohanmehta71@GMAIL.COM','6360551585',NULL,'Headphones - Electronics',1,'Shipped','2025-03-02',3200),
(72,'  amit verma  ','amitverma72@','6909074012','Chennai','Monitor - Electronics',3,'cancelled','2025-05-25',43500),
(73,'MEERA REDDY','meerareddy73 @ gmail.com','+91-80199-52485','Bengaluru','Smartphone - Electronics',NULL,'Completed','2025-06-08',NULL),
(74,'Priya Singh',NULL,'(706) 207-3697','Delhi','Table Lamp - Home',0,'Completed','2025-03-08',0),
(75,'Rahul Joshi','rahuljoshi75@gmail.com','+91 8422230882','Delhi','Backpack - Accessories',2,'Cancelled','2025-03-20',3600),
(76,'Isha Sharma','ishasharma76@yahoo.com','73359 01990','Bangalore','Pen Set - Stationery',1,'pending','2025-10-22',180),
(77,'Rohan Verma','rohanverma77@yahoo.com',NULL,'Ahmedabad','Smartphone - Electronics',2,'completed','2025-12-25',84000),
(78,'Kavya Mehta','kavyamehta78@gmail.com','9419769846','Ahmedabad','USB Cable - Electronics',1,'Cancelled','2025-09-14',500),
(79,'Pooja Sharma','poojasharma79@outlook.com','6054340558','Pune','Table Lamp - Home',5,'completed','2025-07-12',8000),
(80,'Karan Patel',' karanpatel80@example.com ','6756502473','Kolkata','Water Bottle - Lifestyle',2,'Returned','2025-09-25',1400),
(81,'  divya joshi  ','divyajoshi81@EXAMPLE.COM','+91-95465-03094','Ahmedabad','Desk - Furniture',3,'Pending','2025-02-09',36000),
(82,'KARAN KUMAR','karankumar82@','(844) 748-5590','Ahmedabad','Water Bottle - Lifestyle',4,'Cancelled','2025-01-16',2800),
(83,'Arjun Patel','arjunpatel83 @ example.com','+91 6911047815','Hyderabad','USB Cable - Electronics',2,'Cancelled','2025-05-20',1000),
(84,'Amit Rao',NULL,'82188 97149','Delhi','Wireless Mouse - Electronics',2,'cancelled','2025-08-18',2400),
(85,'Neha Joshi','nehajoshi85@example.com',NULL,'Bengaluru','Wireless Mouse - Electronics',2,'Pending','2025-07-23',2400),
(86,'Neha Reddy','nehareddy86@outlook.com','8032638323','Kolkata','Notebook - Stationery',3,'cancelled','2025-12-18',750),
(87,'Arjun Gupta','arjungupta87@example.com','7163577186','New Delhi','Desk - Furniture',2,'completed','2025-12-07',24000),
(88,'Arjun Sharma','arjunsharma88@yahoo.com','6822662216','Delhi','Smartphone - Electronics',5,'pending','2025-12-19',210000),
(89,'Suresh Mehta','sureshmehta89@outlook.com','+91-64317-56350','Delhi','Desk - Furniture',2,'Cancelled','2025-03-10',24000),
(90,'  rajat rao  ',' rajatrao90@yahoo.com ','(717) 815-8203','Bengaluru','Laptop - Electronics',NULL,'pending','2025-12-05',NULL),
(91,'DIVYA SHARMA','divyasharma91@GMAIL.COM','+91 8465587067','New Delhi','Backpack - Accessories',5,'Shipped','2025-06-06',9000),
(92,'Aarav Reddy','aaravreddy92@','64900 00526','Bangalore','Headphones - Electronics',5,'completed','2025-10-21',16000),
(93,'Aarav Patel','aaravpatel93 @ yahoo.com',NULL,'Ahmedabad','Desk - Furniture',1,'Pending','2025-02-18',12000),
(94,'Meera Mehta',NULL,'9331578385','Kolkata','Headphones - Electronics',5,'Shipped','2025-05-28',16000),
(95,'Manish Verma','manishverma95@outlook.com','8442244963','Ahmedabad','Laptop - Electronics',1,'Pending','2025-11-07',65000),
(96,'Amit Sharma','amitsharma96@yahoo.com','7030213097','Mumbai','Notebook - Stationery',1,'COMPLETE','2025-01-14',250),
(97,'Karan Mehta','karanmehta97@example.com','+91-72509-49136','Bengaluru','Office Chair - Furniture',2,'pending','2025-12-28',17000),
(98,'Karan Sharma','karansharma98@yahoo.com','(996) 816-7735','New Delhi','USB Cable - Electronics',2,'cancelled','2025-02-18',1000),
(99,'  neha patel  ','nehapatel99@outlook.com','+91 9550353803','Mumbai','Wireless Mouse - Electronics',1,'COMPLETE','2025-05-20',1200),
(100,'MANISH REDDY',' manishreddy100@example.com ','65340 94883','Chennai','Smartphone - Electronics',2,'cancelled','2025-05-17',84000);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(101,'Nisha Joshi','nishajoshi101@EXAMPLE.COM',NULL,'Ahmedabad','Laptop - Electronics',4,'Cancelled','2025-10-09',260000),
(102,'Rajat Sharma','rajatsharma102@','8896089430','Ahmedabad','Pen Set - Stationery',1,'return','2025-05-19',180),
(103,'Aarav Patel','aaravpatel103 @ example.com','8228932714',NULL,'Backpack - Accessories',2,'COMPLETE','2025-10-14',3600),
(104,'Divya Sharma',NULL,'7494481363','Pune','Monitor - Electronics',3,'return','2025-02-28',43500),
(105,'Sneha Gupta','snehagupta105@example.com','+91-89793-05739','Chennai','Desk - Furniture',4,'shipped','2025-01-15',48000),
(106,'Priya Gupta','priyagupta106@outlook.com','(738) 845-0337','Bangalore','USB Cable - Electronics',4,NULL,'2025-01-22',2000),
(107,'Nisha Joshi','nishajoshi107@example.com','+91 6232804774','Delhi','Notebook - Stationery',3,'Returned','2025-08-21',750),
(108,'  karan singh  ','karansingh108@yahoo.com','71469 97816','Kolkata','Keyboard - Electronics',2,'Shipped','2025-12-16',3600),
(109,'ANANYA SINGH','ananyasingh109@yahoo.com',NULL,'Mumbai','Desk - Furniture',NULL,'Completed','2025-09-14',NULL),
(110,'Priya Kumar',' priyakumar110@gmail.com ','7981903597','Bangalore','Water Bottle - Lifestyle',1,'Shipped','2025-12-10',700),
(111,'Suresh Reddy','sureshreddy111@EXAMPLE.COM','9585112032','Chennai','Backpack - Accessories',0,'Completed','2025-09-05',0),
(112,'Rohan Kumar','rohankumar112@','9710967433','Bangalore','Desk - Furniture',4,'Cancelled','2025-09-09',48000),
(113,'Rajat Reddy','rajatreddy113 @ outlook.com','+91-95969-31684','Ahmedabad','Pen Set - Stationery',5,'COMPLETE','2025-08-18',900),
(114,'Divya Gupta',NULL,'(837) 046-7256','Kolkata','Headphones - Electronics',5,'Cancelled','2025-04-23',16000),
(115,'Neha Mehta','nehamehta115@example.com','+91 7003143045','Pune','Laptop - Electronics',3,'Shipped','2025-12-26',195000),
(116,'Rohan Verma','rohanverma116@yahoo.com','81274 20335','Bengaluru','Keyboard - Electronics',NULL,'Returned','2025-06-28',NULL),
(117,'  ananya joshi  ','ananyajoshi117@gmail.com',NULL,'Chennai','Laptop - Electronics',1,'cancelled','2025-11-05',65000),
(118,'PRIYA JOSHI','priyajoshi118@outlook.com','7454109425','Ahmedabad','Smartphone - Electronics',4,'return','2025-02-28',168000),
(119,'Arjun Rao','arjunrao119@example.com','7360049298',NULL,'Smartphone - Electronics',5,'shipped','2025-01-20',210000),
(120,'Priya Kumar',' priyakumar120@outlook.com ','6977046129','Bangalore','Headphones - Electronics',1,'return','2025-12-28',3200),
(121,'Ananya Joshi','ananyajoshi121@YAHOO.COM','+91-89807-12298','New Delhi','Coffee Mug - Home',1,'Completed','2025-06-26',450),
(122,'Aarav Reddy','aaravreddy122@','(760) 993-0218','Pune','Keyboard - Electronics',2,'shipped','2025-07-19',3600),
(123,'Sneha Patel','snehapatel123 @ yahoo.com','+91 6339166473','Ahmedabad','Table Lamp - Home',4,'Returned','2025-11-08',6400),
(124,'Divya Mehta',NULL,'69972 41761','Chennai','Water Bottle - Lifestyle',2,'Shipped','2025-05-22',1400),
(125,'Rajat Joshi','rajatjoshi125@outlook.com',NULL,'Kolkata','Keyboard - Electronics',1,'Shipped','2025-06-19',1800),
(126,'  kavya verma  ','kavyaverma126@outlook.com','7962094851','New Delhi','Office Chair - Furniture',4,'Shipped','2025-02-08',34000),
(127,'ROHAN MEHTA','rohanmehta127@outlook.com','8468798461','New Delhi','Smartphone - Electronics',2,'Completed','2025-11-13',84000),
(128,'Amit Singh','amitsingh128@gmail.com','9911070030','Ahmedabad','Smartphone - Electronics',5,'pending','2025-04-20',210000),
(129,'Pooja Kumar','poojakumar129@yahoo.com','+91-86667-07262','New Delhi','Water Bottle - Lifestyle',1,'return','2025-02-21',700),
(130,'Aarav Reddy',' aaravreddy130@example.com ','(614) 329-9564','Ahmedabad','Monitor - Electronics',1,'completed','2025-05-11',14500),
(131,'Meera Patel','meerapatel131@YAHOO.COM','+91 6567622001','Kolkata','Coffee Mug - Home',3,'shipped','2025-09-09',1350),
(132,'Sneha Reddy','snehareddy132@','94638 41709','New Delhi','Smartphone - Electronics',3,'completed','2025-08-03',126000),
(133,'Rahul Kumar','rahulkumar133 @ example.com',NULL,'Kolkata','Monitor - Electronics',1,'cancelled','2025-01-09',14500),
(134,'Nisha Sharma',NULL,'7583063357',NULL,'Smartphone - Electronics',2,'Returned','2025-07-27',84000),
(135,'  pooja sharma  ','poojasharma135@yahoo.com','8024977737','Bengaluru','Pen Set - Stationery',NULL,'Cancelled','2025-10-08',NULL),
(136,'PRIYA JOSHI','priyajoshi136@outlook.com','8788462200','Pune','Wireless Mouse - Electronics',1,'Completed','2025-01-10',1200),
(137,'Divya Sharma','divyasharma137@gmail.com','+91-70084-58444','Kolkata','Keyboard - Electronics',4,'Shipped','2025-06-22',7200),
(138,'Nisha Verma','nishaverma138@yahoo.com','(980) 282-3261','Pune','Water Bottle - Lifestyle',1,'Shipped','2025-10-14',700),
(139,'Amit Singh','amitsingh139@outlook.com','+91 6933166190','Chennai','Backpack - Accessories',2,'Cancelled','2025-02-22',3600),
(140,'Pooja Rao',' poojarao140@outlook.com ','62600 60661','Pune','Desk - Furniture',2,'completed','2025-08-03',24000),
(141,'Vikram Mehta','vikrammehta141@GMAIL.COM',NULL,'Hyderabad','Office Chair - Furniture',1,'Returned','2025-04-03',8500),
(142,'Nisha Kumar','nishakumar142@','9492035954','Delhi','Monitor - Electronics',1,'Returned','2025-01-09',14500),
(143,'Rahul Patel','rahulpatel143 @ outlook.com','9429590757','Mumbai','Wireless Mouse - Electronics',1,'COMPLETE','2025-01-12',1200),
(144,'  neha mehta  ',NULL,'6067779246','Mumbai','Desk - Furniture',1,'COMPLETE','2025-12-14',12000),
(145,'SURESH SHARMA','sureshsharma145@gmail.com','+91-80454-60840','Chennai','USB Cable - Electronics',3,'shipped','2025-10-04',1500),
(146,'Karan Rao','karanrao146@yahoo.com','(864) 186-3774','Bengaluru','Smartphone - Electronics',NULL,'pending','2025-08-21',NULL),
(147,'Rajat Singh','rajatsingh147@example.com','+91 9639119547','Pune','Headphones - Electronics',1,'Shipped','2025-12-15',3200),
(148,'Priya Sharma','priyasharma148@outlook.com','86126 17557','Mumbai','Wireless Mouse - Electronics',0,'Completed','2025-10-21',0),
(149,'Manish Rao','manishrao149@outlook.com',NULL,'Ahmedabad','Notebook - Stationery',2,'Shipped','2025-09-20',500),
(150,'Meera Sharma',' meerasharma150@gmail.com ','9662716909',NULL,'Water Bottle - Lifestyle',NULL,'Pending','2025-07-15',NULL),
(151,'Neha Verma','nehaverma151@OUTLOOK.COM','9553738511','Chennai','Headphones - Electronics',4,'completed','2025-06-14',12800),
(152,'Arjun Reddy','arjunreddy152@','6655579180',NULL,'Coffee Mug - Home',5,'completed','2025-02-27',2250),
(153,'  priya sharma  ','priyasharma153 @ example.com','+91-64147-41061','Hyderabad','USB Cable - Electronics',1,'shipped','2025-01-19',500),
(154,'NISHA RAO',NULL,'(887) 768-5081','Bangalore','Headphones - Electronics',3,'return','2025-07-28',9600),
(155,'Aarav Reddy','aaravreddy155@outlook.com','+91 7510308881','Bangalore','Pen Set - Stationery',NULL,'Pending','2025-03-22',NULL),
(156,'Divya Kumar','divyakumar156@gmail.com','75037 28142','Kolkata','Monitor - Electronics',1,'pending','2025-10-08',14500),
(157,'Meera Rao','meerarao157@gmail.com',NULL,NULL,'Table Lamp - Home',2,'Completed','2025-03-09',3200),
(158,'Kavya Gupta','kavyagupta158@outlook.com','6026224160','Mumbai','Table Lamp - Home',1,'Returned','2025-11-13',1600),
(159,'Priya Patel','priyapatel159@gmail.com','6394096254','Kolkata','Office Chair - Furniture',4,NULL,'2025-08-11',34000),
(160,'Sneha Gupta',' snehagupta160@outlook.com ','9099231080','Hyderabad','USB Cable - Electronics',1,'Completed','2025-03-06',500),
(161,'Isha Singh','ishasingh161@GMAIL.COM','+91-71686-72809','Chennai','Water Bottle - Lifestyle',4,'Shipped','2025-10-15',2800),
(162,'  meera reddy  ','meerareddy162@','(924) 245-6102','Kolkata','Wireless Mouse - Electronics',3,'cancelled','2025-02-10',3600),
(163,'MANISH JOSHI','manishjoshi163 @ outlook.com','+91 6195066088','Delhi','Headphones - Electronics',1,'Completed','2025-04-10',3200),
(164,'Vikram Patel',NULL,'72431 65953','Hyderabad','Wireless Mouse - Electronics',1,'Shipped','2025-12-14',1200),
(165,'Sneha Patel','snehapatel165@example.com',NULL,'Delhi','Notebook - Stationery',NULL,'return','2025-06-03',NULL),
(166,'Rohan Singh','rohansingh166@example.com','6080494302','Chennai','Coffee Mug - Home',1,'Cancelled','2025-10-14',450),
(167,'Manish Verma','manishverma167@example.com','7243458354','Bangalore','Headphones - Electronics',1,'Cancelled','2025-03-26',3200),
(168,'Isha Joshi','ishajoshi168@outlook.com','6378514962','Pune','Table Lamp - Home',1,'Pending','2025-07-19',1600),
(169,'Rohan Rao','rohanrao169@gmail.com','+91-76998-05002','New Delhi','Smartphone - Electronics',3,'Pending','2025-06-25',126000),
(170,'Sneha Sharma',' snehasharma170@gmail.com ','(827) 893-0366','Kolkata','Office Chair - Furniture',3,'Cancelled','2025-12-27',25500),
(171,'  rahul kumar  ','rahulkumar171@GMAIL.COM','+91 6628973138','New Delhi','Office Chair - Furniture',1,'Returned','2025-03-25',8500),
(172,'PRIYA PATEL','priyapatel172@','79926 63260','Ahmedabad','USB Cable - Electronics',5,'return','2025-10-21',2500),
(173,'Isha Gupta','ishagupta173 @ outlook.com',NULL,'Chennai','Wireless Mouse - Electronics',5,'Shipped','2025-11-10',6000),
(174,'Amit Mehta',NULL,'7511580323','Kolkata','Wireless Mouse - Electronics',2,'Shipped','2025-08-02',2400),
(175,'Aarav Gupta','aaravgupta175@outlook.com','6329557138',NULL,'Table Lamp - Home',1,'Returned','2025-10-17',1600),
(176,'Rohan Joshi','rohanjoshi176@gmail.com','7931591531','Ahmedabad','Water Bottle - Lifestyle',2,'Cancelled','2025-10-16',1400),
(177,'Suresh Patel','sureshpatel177@gmail.com','+91-79349-82045','Bangalore','USB Cable - Electronics',3,'completed','2025-09-21',1500),
(178,'Sneha Singh','snehasingh178@yahoo.com','(903) 921-2077','Chennai','Backpack - Accessories',NULL,'shipped','2025-10-06',NULL),
(179,'Pooja Gupta','poojagupta179@outlook.com','+91 7663941470','Pune','USB Cable - Electronics',3,'return','2025-10-02',1500),
(180,'  arjun sharma  ',' arjunsharma180@outlook.com ','64058 99939','Kolkata','Water Bottle - Lifestyle',4,'pending','2025-05-24',2800),
(181,'ISHA PATEL','ishapatel181@OUTLOOK.COM',NULL,'Ahmedabad','Water Bottle - Lifestyle',1,'Cancelled','2025-05-21',700),
(182,'Rohan Patel','rohanpatel182@','7329644079','Kolkata','Headphones - Electronics',3,'COMPLETE','2025-11-23',9600),
(183,'Suresh Sharma','sureshsharma183 @ example.com','8183941426','Hyderabad','Laptop - Electronics',3,'pending','2025-03-07',195000),
(184,'Arjun Joshi',NULL,'6972994972','Mumbai','Keyboard - Electronics',1,'pending','2025-02-17',1800),
(185,'Nisha Rao','nisharao185@gmail.com','+91-88429-64443','Hyderabad','Coffee Mug - Home',0,'Completed','2025-07-05',0),
(186,'Sneha Patel','snehapatel186@yahoo.com','(909) 745-7395','Chennai','Laptop - Electronics',4,'Cancelled','2025-11-24',260000),
(187,'Neha Joshi','nehajoshi187@outlook.com','+91 9231495430','Chennai','Office Chair - Furniture',NULL,'Pending','2025-05-26',NULL),
(188,'Divya Kumar','divyakumar188@outlook.com','89133 05623','Ahmedabad','Backpack - Accessories',5,'pending','2025-07-17',9000),
(189,'  suresh verma  ','sureshverma189@yahoo.com',NULL,'Delhi','USB Cable - Electronics',1,'pending','2025-01-21',500),
(190,'DIVYA GUPTA',' divyagupta190@gmail.com ','9055443931','Kolkata','Table Lamp - Home',1,'pending','2025-02-25',1600),
(191,'Sneha Reddy','snehareddy191@EXAMPLE.COM','9888260570','Kolkata','Keyboard - Electronics',4,'completed','2025-04-27',7200),
(192,'Karan Gupta','karangupta192@','7781968664','Bengaluru','Headphones - Electronics',NULL,'Cancelled','2025-04-13',NULL),
(193,'Priya Gupta','priyagupta193 @ yahoo.com','+91-61210-64582','Hyderabad','Coffee Mug - Home',1,'return','2025-06-26',450),
(194,'Rahul Patel',NULL,'(723) 213-7626','Chennai','Smartphone - Electronics',1,'Shipped','2025-08-20',42000),
(195,'Rajat Sharma','rajatsharma195@gmail.com','+91 7099184899','Delhi','Table Lamp - Home',1,'shipped','2025-12-20',1600),
(196,'Suresh Verma','sureshverma196@gmail.com','93336 36070','New Delhi','Office Chair - Furniture',2,'completed','2025-01-08',17000),
(197,'Meera Mehta','meeramehta197@example.com',NULL,'Bangalore','Table Lamp - Home',5,'Returned','2025-09-01',8000),
(198,'  suresh mehta  ','sureshmehta198@yahoo.com','9086124402','Mumbai','Desk - Furniture',4,'Completed','2025-10-12',48000),
(199,'NEHA MEHTA','nehamehta199@example.com','6804507108',NULL,'Water Bottle - Lifestyle',1,'shipped','2025-06-03',700),
(200,'Suresh Rao',' sureshrao200@gmail.com ','7676986013','Chennai','Laptop - Electronics',4,'Cancelled','2025-05-24',260000);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(201,'Rajat Gupta','rajatgupta201@GMAIL.COM','+91-74809-15452','Delhi','Smartphone - Electronics',1,'Returned','2025-12-25',42000),
(202,'Arjun Patel','arjunpatel202@','(751) 311-2872','Kolkata','Monitor - Electronics',1,'return','2025-08-23',14500),
(203,'Divya Patel','divyapatel203 @ yahoo.com','+91 6271014739','Chennai','Laptop - Electronics',2,'Pending','2025-01-26',130000),
(204,'Vikram Singh',NULL,'73317 65783','Kolkata','Headphones - Electronics',NULL,'Shipped','2025-05-02',NULL),
(205,'Vikram Reddy','vikramreddy205@outlook.com',NULL,'Bengaluru','Table Lamp - Home',3,'pending','2025-02-26',4800),
(206,'Pooja Verma','poojaverma206@example.com','9192482284','Chennai','Coffee Mug - Home',4,'Cancelled','2025-03-16',1800),
(207,'  divya gupta  ','divyagupta207@outlook.com','9440904834','Bangalore','Smartphone - Electronics',4,'completed','2025-07-20',168000),
(208,'SNEHA RAO','sneharao208@outlook.com','7379592595','Bangalore','Wireless Mouse - Electronics',3,'return','2025-05-10',3600),
(209,'Karan Mehta','karanmehta209@example.com','+91-67157-33827','Chennai','Monitor - Electronics',5,'Completed','2025-12-28',72500),
(210,'Pooja Mehta',' poojamehta210@example.com ','(717) 920-6294',NULL,'USB Cable - Electronics',1,'completed','2025-11-21',500),
(211,'Rohan Gupta','rohangupta211@YAHOO.COM','+91 6133747952','Mumbai','Table Lamp - Home',5,'Completed','2025-03-03',8000),
(212,'Neha Gupta','nehagupta212@','76443 47110','Ahmedabad','Laptop - Electronics',1,NULL,'2025-08-12',65000),
(213,'Pooja Joshi','poojajoshi213 @ gmail.com',NULL,'Mumbai','Notebook - Stationery',3,'cancelled','2025-06-21',750),
(214,'Amit Kumar',NULL,'6111296943','Mumbai','Backpack - Accessories',NULL,'cancelled','2025-09-04',NULL),
(215,'Amit Reddy','amitreddy215@example.com','6921572928','Ahmedabad','Desk - Furniture',5,'Pending','2025-02-05',60000),
(216,'  priya joshi  ','priyajoshi216@yahoo.com','9859797024','Chennai','Wireless Mouse - Electronics',3,'return','2025-06-23',3600),
(217,'PRIYA RAO','priyarao217@outlook.com','+91-98282-40439','New Delhi','Table Lamp - Home',1,'return','2025-03-26',1600),
(218,'Pooja Rao','poojarao218@yahoo.com','(652) 124-7759','Delhi','USB Cable - Electronics',1,'Pending','2025-08-01',500),
(219,'Pooja Rao','poojarao219@outlook.com','+91 8007492791','Kolkata','Keyboard - Electronics',1,'completed','2025-05-13',1800),
(220,'Divya Rao',' divyarao220@example.com ','93035 36605','Pune','Table Lamp - Home',1,'COMPLETE','2025-06-21',1600),
(221,'Priya Joshi','priyajoshi221@EXAMPLE.COM',NULL,'Kolkata','Monitor - Electronics',1,'shipped','2025-11-19',14500),
(222,'Sneha Patel','snehapatel222@','8159783506','Bengaluru','Table Lamp - Home',0,'Completed','2025-03-10',0),
(223,'Sneha Patel','snehapatel223 @ outlook.com','9046558332','Delhi','Monitor - Electronics',NULL,'pending','2025-02-09',NULL),
(224,'Vikram Rao',NULL,'6537602307',NULL,'Desk - Furniture',NULL,'completed','2025-09-21',NULL),
(225,'  sneha mehta  ','snehamehta225@yahoo.com','+91-67353-01069',NULL,'Pen Set - Stationery',3,'Returned','2025-01-27',540),
(226,'RAJAT SHARMA','rajatsharma226@gmail.com','(875) 502-2797','Ahmedabad','Desk - Furniture',2,'Returned','2025-07-20',24000),
(227,'Rajat Joshi','rajatjoshi227@outlook.com','+91 8756970807','New Delhi','Backpack - Accessories',2,'return','2025-07-10',3600),
(228,'Karan Sharma','karansharma228@gmail.com','66789 50361','Chennai','Headphones - Electronics',5,'Shipped','2025-04-11',16000),
(229,'Isha Patel','ishapatel229@outlook.com',NULL,'Hyderabad','Smartphone - Electronics',3,'cancelled','2025-03-25',126000),
(230,'Pooja Rao',' poojarao230@gmail.com ','7370592316','Delhi','Backpack - Accessories',1,'pending','2025-08-08',1800),
(231,'Rahul Sharma','rahulsharma231@GMAIL.COM','7246451043','Pune','Table Lamp - Home',4,'Pending','2025-03-27',6400),
(232,'Arjun Mehta','arjunmehta232@','6815331250','Mumbai','Backpack - Accessories',NULL,'Shipped','2025-08-10',NULL),
(233,'Divya Singh','divyasingh233 @ gmail.com','+91-76889-62331','Kolkata','Backpack - Accessories',2,'Pending','2025-10-12',3600),
(234,'  aarav singh  ',NULL,'(812) 555-4417','Ahmedabad','Coffee Mug - Home',5,'pending','2025-09-01',2250),
(235,'ANANYA VERMA','ananyaverma235@yahoo.com','+91 9790118526','New Delhi','Smartphone - Electronics',3,'cancelled','2025-06-02',126000),
(236,'Rohan Singh','rohansingh236@yahoo.com','75570 27753','Kolkata','Desk - Furniture',1,'cancelled','2025-09-15',12000),
(237,'Nisha Reddy','nishareddy237@gmail.com',NULL,'Bangalore','Headphones - Electronics',3,'Cancelled','2025-09-12',9600),
(238,'Rahul Kumar','rahulkumar238@example.com','8147818256','Bengaluru','Laptop - Electronics',1,'COMPLETE','2025-12-11',65000),
(239,'Divya Rao','divyarao239@example.com','6639695273','Ahmedabad','Coffee Mug - Home',NULL,'COMPLETE','2025-06-20',NULL),
(240,'Arjun Patel',' arjunpatel240@example.com ','8647849438','New Delhi','Pen Set - Stationery',3,'shipped','2025-09-18',540),
(241,'Divya Mehta','divyamehta241@OUTLOOK.COM','+91-80396-48170','Bengaluru','Monitor - Electronics',3,'return','2025-02-14',43500),
(242,'Manish Reddy','manishreddy242@','(856) 370-7272','Chennai','Desk - Furniture',2,'Completed','2025-10-16',24000),
(243,'  sneha rao  ','sneharao243 @ example.com','+91 6634691836',NULL,'Office Chair - Furniture',1,'Returned','2025-12-04',8500),
(244,'VIKRAM SINGH',NULL,'73472 98951','Pune','Keyboard - Electronics',4,'Pending','2025-07-17',7200),
(245,'Isha Joshi','ishajoshi245@gmail.com',NULL,'Mumbai','Notebook - Stationery',2,'shipped','2025-06-22',500),
(246,'Divya Rao','divyarao246@example.com','7347557120','Mumbai','Backpack - Accessories',NULL,'Cancelled','2025-09-12',NULL),
(247,'Amit Mehta','amitmehta247@example.com','6825768309','Delhi','Desk - Furniture',NULL,'pending','2025-04-10',NULL),
(248,'Kavya Kumar','kavyakumar248@example.com','7361679629','Chennai','Monitor - Electronics',NULL,'pending','2025-05-04',NULL),
(249,'Manish Rao','manishrao249@example.com','+91-98472-61858','Pune','Table Lamp - Home',3,'COMPLETE','2025-05-02',4800),
(250,'Kavya Sharma',' kavyasharma250@outlook.com ','(996) 859-1159','Chennai','Water Bottle - Lifestyle',2,'Shipped','2025-04-07',1400),
(251,'Nisha Reddy','nishareddy251@OUTLOOK.COM','+91 6589582865','Bangalore','Pen Set - Stationery',2,'Pending','2025-01-22',360),
(252,'  suresh kumar  ','sureshkumar252@','62254 47588','Bangalore','Headphones - Electronics',3,'Shipped','2025-02-22',9600),
(253,'RAHUL SINGH','rahulsingh253 @ yahoo.com',NULL,NULL,'Coffee Mug - Home',5,'Shipped','2025-11-07',2250),
(254,'Kavya Gupta',NULL,'8774110439','Bengaluru','Coffee Mug - Home',1,'return','2025-10-08',450),
(255,'Nisha Singh','nishasingh255@yahoo.com','7794802316','Mumbai','Coffee Mug - Home',1,'cancelled','2025-08-06',450),
(256,'Kavya Singh','kavyasingh256@gmail.com','7281584789','Ahmedabad','Pen Set - Stationery',1,'Cancelled','2025-05-15',180),
(257,'Nisha Rao','nisharao257@example.com','+91-98193-42448','Mumbai','Table Lamp - Home',NULL,'Shipped','2025-05-07',NULL),
(258,'Ananya Gupta','ananyagupta258@yahoo.com','(914) 013-3190','Chennai','Water Bottle - Lifestyle',2,'COMPLETE','2025-01-24',1400),
(259,'Arjun Reddy','arjunreddy259@yahoo.com','+91 6753744909','Ahmedabad','Table Lamp - Home',0,'Completed','2025-09-11',0),
(260,'Priya Verma',' priyaverma260@gmail.com ','67936 29209','Mumbai','Backpack - Accessories',3,'Pending','2025-01-09',5400),
(261,'  rohan kumar  ','rohankumar261@EXAMPLE.COM',NULL,'New Delhi','Monitor - Electronics',2,'Returned','2025-12-19',29000),
(262,'RAJAT REDDY','rajatreddy262@','8975418439','Delhi','Laptop - Electronics',1,'Shipped','2025-05-06',65000),
(263,'Rohan Rao','rohanrao263 @ outlook.com','8964774623','Bangalore','Water Bottle - Lifestyle',2,'Cancelled','2025-10-08',1400),
(264,'Neha Patel',NULL,'6657926994','Chennai','Smartphone - Electronics',3,'cancelled','2025-12-18',126000),
(265,'Divya Rao','divyarao265@yahoo.com','+91-92721-62158','Delhi','Water Bottle - Lifestyle',1,NULL,'2025-08-17',700),
(266,'Pooja Sharma','poojasharma266@gmail.com','(626) 524-8799','Kolkata','Coffee Mug - Home',NULL,'Pending','2025-10-18',NULL),
(267,'Rahul Patel','rahulpatel267@outlook.com','+91 9669989454','Kolkata','Backpack - Accessories',1,'return','2025-04-23',1800),
(268,'Manish Joshi','manishjoshi268@gmail.com','98607 00382','Kolkata','Backpack - Accessories',1,'Shipped','2025-03-17',1800),
(269,'Meera Joshi','meerajoshi269@gmail.com',NULL,'Chennai','Water Bottle - Lifestyle',2,'Completed','2025-07-09',1400),
(270,'  rajat kumar  ',' rajatkumar270@gmail.com ','6194518221','Pune','Monitor - Electronics',1,'shipped','2025-01-03',14500),
(271,'DIVYA SINGH','divyasingh271@OUTLOOK.COM','7756070122','Mumbai','USB Cable - Electronics',1,'return','2025-12-21',500),
(272,'Meera Gupta','meeragupta272@','7926452312','Pune','Headphones - Electronics',1,'return','2025-11-28',3200),
(273,'Nisha Patel','nishapatel273 @ outlook.com','+91-65095-25588','Mumbai','Notebook - Stationery',4,'shipped','2025-03-24',1000),
(274,'Neha Singh',NULL,'(728) 145-9294','Chennai','Water Bottle - Lifestyle',NULL,'cancelled','2025-09-13',NULL),
(275,'Neha Kumar','nehakumar275@example.com','+91 7486744752','Mumbai','Desk - Furniture',2,'completed','2025-01-26',24000),
(276,'Meera Mehta','meeramehta276@gmail.com','70336 53860','Delhi','Wireless Mouse - Electronics',1,'Returned','2025-01-15',1200),
(277,'Isha Singh','ishasingh277@yahoo.com',NULL,'Bengaluru','Headphones - Electronics',5,'Pending','2025-09-07',16000),
(278,'Aarav Patel','aaravpatel278@outlook.com','7005716063','Ahmedabad','Monitor - Electronics',3,'Pending','2025-05-05',43500),
(279,'  suresh kumar  ','sureshkumar279@example.com','7290641764','New Delhi','Laptop - Electronics',NULL,'Returned','2025-12-06',NULL),
(280,'MEERA RAO',' meerarao280@example.com ','6201365642','Hyderabad','Water Bottle - Lifestyle',4,'shipped','2025-06-23',2800),
(281,'Meera Verma','meeraverma281@YAHOO.COM','+91-72880-11277','Pune','Keyboard - Electronics',NULL,'Shipped','2025-04-28',NULL),
(282,'Neha Reddy','nehareddy282@','(946) 078-2270','Chennai','Coffee Mug - Home',1,'shipped','2025-07-14',450),
(283,'Nisha Rao','nisharao283 @ yahoo.com','+91 7668247132','Delhi','Desk - Furniture',2,'Cancelled','2025-11-03',24000),
(284,'Karan Gupta',NULL,'83005 37106','Delhi','Laptop - Electronics',2,'cancelled','2025-11-20',130000),
(285,'Isha Singh','ishasingh285@gmail.com',NULL,'Ahmedabad','Smartphone - Electronics',NULL,'Pending','2025-08-07',NULL),
(286,'Arjun Reddy','arjunreddy286@gmail.com','6909707455','Delhi','Smartphone - Electronics',1,'Shipped','2025-04-23',42000),
(287,'Isha Kumar','ishakumar287@example.com','9930438209','Delhi','Notebook - Stationery',3,'pending','2025-07-15',750),
(288,'  nisha gupta  ','nishagupta288@outlook.com','7123398645','Hyderabad','Notebook - Stationery',5,'Shipped','2025-02-26',1250),
(289,'DIVYA GUPTA','divyagupta289@yahoo.com','+91-75921-65525','Hyderabad','Headphones - Electronics',1,'Returned','2025-04-24',3200),
(290,'Rahul Singh',' rahulsingh290@outlook.com ','(837) 645-5067','Ahmedabad','Pen Set - Stationery',4,'pending','2025-03-07',720),
(291,'Arjun Kumar','arjunkumar291@EXAMPLE.COM','+91 8447227327','Delhi','Backpack - Accessories',NULL,'return','2025-11-11',NULL),
(292,'Amit Joshi','amitjoshi292@','79792 45480','Mumbai','Smartphone - Electronics',3,'COMPLETE','2025-03-24',126000),
(293,'Nisha Joshi','nishajoshi293 @ yahoo.com',NULL,'Kolkata','Water Bottle - Lifestyle',1,'shipped','2025-01-27',700),
(294,'Priya Singh',NULL,'7771211118','Mumbai','Table Lamp - Home',2,'completed','2025-12-05',3200),
(295,'Rajat Kumar','rajatkumar295@example.com','7602884797','Bengaluru','Pen Set - Stationery',5,'return','2025-08-01',900),
(296,'Rajat Rao','rajatrao296@example.com','6050899550','Bengaluru','Notebook - Stationery',0,'Completed','2025-05-01',0),
(297,'  suresh verma  ','sureshverma297@yahoo.com','+91-64596-32043','Bangalore','Notebook - Stationery',1,'Pending','2025-04-20',250),
(298,'SURESH REDDY','sureshreddy298@outlook.com','(714) 815-1005','Pune','Wireless Mouse - Electronics',3,'cancelled','2025-08-19',3600),
(299,'Neha Kumar','nehakumar299@outlook.com','+91 8937936410','Bangalore','Water Bottle - Lifestyle',1,'completed','2025-07-13',700),
(300,'Rohan Rao',' rohanrao300@example.com ','62410 11818',NULL,'Laptop - Electronics',1,'completed','2025-08-28',65000);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(301,'Meera Gupta','meeragupta301@GMAIL.COM',NULL,'Kolkata','Coffee Mug - Home',1,'Pending','2025-04-28',450),
(302,'Manish Joshi','manishjoshi302@','6199982132','Bangalore','Water Bottle - Lifestyle',2,'shipped','2025-10-22',1400),
(303,'Aarav Patel','aaravpatel303 @ outlook.com','6067251004','Delhi','Pen Set - Stationery',1,'cancelled','2025-02-10',180),
(304,'Sneha Mehta',NULL,'8433940416','Pune','Water Bottle - Lifestyle',NULL,'Cancelled','2025-07-25',NULL),
(305,'Rahul Sharma','rahulsharma305@outlook.com','+91-62306-24431','Bangalore','Headphones - Electronics',2,'completed','2025-06-20',6400),
(306,'  isha mehta  ','ishamehta306@example.com','(932) 239-3065','Hyderabad','Laptop - Electronics',2,'Shipped','2025-08-08',130000),
(307,'POOJA RAO','poojarao307@example.com','+91 7854772804','Mumbai','Water Bottle - Lifestyle',4,'completed','2025-10-10',2800),
(308,'Neha Sharma','nehasharma308@gmail.com','71509 31110','Mumbai','Headphones - Electronics',1,'cancelled','2025-06-12',3200),
(309,'Ananya Sharma','ananyasharma309@gmail.com',NULL,'Chennai','Monitor - Electronics',2,'completed','2025-03-03',29000),
(310,'Sneha Verma',' snehaverma310@example.com ','8392232487','Kolkata','Notebook - Stationery',4,'completed','2025-01-03',1000),
(311,'Pooja Rao','poojarao311@GMAIL.COM','8563771436','Ahmedabad','USB Cable - Electronics',3,'cancelled','2025-01-10',1500),
(312,'Meera Verma','meeraverma312@','9113180606','Kolkata','Coffee Mug - Home',2,'Returned','2025-09-06',900),
(313,'Rohan Patel','rohanpatel313 @ yahoo.com','+91-71549-98170','New Delhi','Desk - Furniture',5,'COMPLETE','2025-02-06',60000),
(314,'Meera Reddy',NULL,'(728) 742-6116','Chennai','USB Cable - Electronics',1,'Cancelled','2025-05-08',500),
(315,'  divya mehta  ','divyamehta315@yahoo.com','+91 7966500767','Bangalore','Keyboard - Electronics',2,'Completed','2025-07-11',3600),
(316,'ISHA VERMA','ishaverma316@outlook.com','78907 43044','Hyderabad','Headphones - Electronics',1,'pending','2025-06-20',3200),
(317,'Vikram Joshi','vikramjoshi317@outlook.com',NULL,'Pune','Monitor - Electronics',2,'return','2025-08-19',29000),
(318,'Neha Gupta','nehagupta318@example.com','7203879959','Pune','Monitor - Electronics',1,NULL,'2025-04-19',14500),
(319,'Nisha Patel','nishapatel319@gmail.com','9123357626','Chennai','Smartphone - Electronics',2,'Shipped','2025-05-27',84000),
(320,'Priya Verma',' priyaverma320@example.com ','6597769760',NULL,'Desk - Furniture',2,'pending','2025-11-05',24000),
(321,'Meera Verma','meeraverma321@GMAIL.COM','+91-79287-26872','Ahmedabad','Backpack - Accessories',4,'shipped','2025-09-28',7200),
(322,'Meera Rao','meerarao322@','(939) 612-0475','Hyderabad','Smartphone - Electronics',NULL,'Returned','2025-11-03',NULL),
(323,'Ananya Kumar','ananyakumar323 @ outlook.com','+91 6714418371',NULL,'Pen Set - Stationery',1,'Returned','2025-11-22',180),
(324,'  rohan gupta  ',NULL,'64550 28401','Bengaluru','Wireless Mouse - Electronics',2,'Pending','2025-09-24',2400),
(325,'SURESH RAO','sureshrao325@yahoo.com',NULL,'Hyderabad','Headphones - Electronics',5,'return','2025-10-23',16000),
(326,'Suresh Patel','sureshpatel326@outlook.com','6105495798','Chennai','Wireless Mouse - Electronics',2,'cancelled','2025-02-04',2400),
(327,'Rahul Gupta','rahulgupta327@outlook.com','7473460179','Chennai','USB Cable - Electronics',2,'shipped','2025-08-12',1000),
(328,'Divya Sharma','divyasharma328@example.com','9100940360','Chennai','Monitor - Electronics',1,'pending','2025-01-26',14500),
(329,'Ananya Singh','ananyasingh329@outlook.com','+91-87830-09621','Bangalore','Water Bottle - Lifestyle',1,'Pending','2025-09-06',700),
(330,'Nisha Patel',' nishapatel330@outlook.com ','(840) 453-2947','Pune','Backpack - Accessories',2,'cancelled','2025-11-06',3600),
(331,'Sneha Verma','snehaverma331@EXAMPLE.COM','+91 6125379850','Ahmedabad','Coffee Mug - Home',2,'Shipped','2025-10-14',900),
(332,'Rohan Singh','rohansingh332@','68838 37629','New Delhi','USB Cable - Electronics',1,'Returned','2025-02-26',500),
(333,'  nisha patel  ','nishapatel333 @ outlook.com',NULL,'Delhi','Backpack - Accessories',0,'Completed','2025-11-28',0),
(334,'DIVYA RAO',NULL,'8563970187','Pune','Pen Set - Stationery',4,'Returned','2025-02-12',720),
(335,'Pooja Joshi','poojajoshi335@yahoo.com','9494979199',NULL,'Smartphone - Electronics',2,'Returned','2025-10-03',84000),
(336,'Rahul Gupta','rahulgupta336@gmail.com','7024662077','New Delhi','Wireless Mouse - Electronics',1,'Cancelled','2025-12-05',1200),
(337,'Suresh Verma','sureshverma337@example.com','+91-85616-29386','Mumbai','Pen Set - Stationery',4,'cancelled','2025-03-16',720),
(338,'Nisha Patel','nishapatel338@yahoo.com','(810) 299-6505','New Delhi','Keyboard - Electronics',1,'Cancelled','2025-08-20',1800),
(339,'Aarav Gupta','aaravgupta339@gmail.com','+91 8081379485','Mumbai','Office Chair - Furniture',4,'shipped','2025-09-21',34000),
(340,'Divya Verma',' divyaverma340@example.com ','77851 19108','Chennai','Backpack - Accessories',1,'completed','2025-10-01',1800),
(341,'Neha Reddy','nehareddy341@GMAIL.COM',NULL,'Delhi','Notebook - Stationery',2,'COMPLETE','2025-08-19',500),
(342,'  divya rao  ','divyarao342@','8459788151','Bangalore','Desk - Furniture',NULL,'Cancelled','2025-09-27',NULL),
(343,'AARAV JOSHI','aaravjoshi343 @ yahoo.com','7826025489','Bangalore','Smartphone - Electronics',2,'pending','2025-01-15',84000),
(344,'Amit Gupta',NULL,'7885790857','Bangalore','USB Cable - Electronics',2,'Pending','2025-12-19',1000),
(345,'Pooja Mehta','poojamehta345@example.com','+91-67128-85628','Ahmedabad','Keyboard - Electronics',2,'Pending','2025-01-19',3600),
(346,'Pooja Rao','poojarao346@outlook.com','(856) 348-4242','Kolkata','Keyboard - Electronics',3,'pending','2025-05-19',5400),
(347,'Amit Rao','amitrao347@gmail.com','+91 6582349911','Pune','Coffee Mug - Home',1,'pending','2025-11-05',450),
(348,'Rahul Kumar','rahulkumar348@yahoo.com','90554 17606','Hyderabad','Table Lamp - Home',2,'return','2025-07-16',3200),
(349,'Rahul Mehta','rahulmehta349@outlook.com',NULL,'Pune','Headphones - Electronics',5,'completed','2025-11-26',16000),
(350,'Priya Verma',' priyaverma350@outlook.com ','8983729287','Hyderabad','Backpack - Accessories',5,'Cancelled','2025-10-01',9000),
(351,'  priya joshi  ','priyajoshi351@OUTLOOK.COM','9651178503','Bangalore','USB Cable - Electronics',NULL,'cancelled','2025-04-14',NULL),
(352,'VIKRAM JOSHI','vikramjoshi352@','7386695233','New Delhi','Monitor - Electronics',NULL,'Returned','2025-03-19',NULL),
(353,'Divya Gupta','divyagupta353 @ gmail.com','+91-61973-23378','Bangalore','Water Bottle - Lifestyle',5,'Completed','2025-02-28',3500),
(354,'Sneha Joshi',NULL,'(600) 290-3074','Pune','Office Chair - Furniture',1,'return','2025-05-06',8500),
(355,'Amit Sharma','amitsharma355@outlook.com','+91 7075413763','Bangalore','Monitor - Electronics',1,'Completed','2025-07-21',14500),
(356,'Kavya Kumar','kavyakumar356@example.com','88152 87619','Bangalore','Smartphone - Electronics',1,'Completed','2025-04-16',42000),
(357,'Priya Patel','priyapatel357@yahoo.com',NULL,NULL,'Backpack - Accessories',1,'Completed','2025-12-11',1800),
(358,'Ananya Verma','ananyaverma358@yahoo.com','8051706927','Bangalore','Office Chair - Furniture',4,'completed','2025-12-26',34000),
(359,'Ananya Sharma','ananyasharma359@outlook.com','7578665411','New Delhi','Keyboard - Electronics',4,'COMPLETE','2025-11-22',7200),
(360,'  rahul sharma  ',' rahulsharma360@gmail.com ','8621301168',NULL,'Keyboard - Electronics',5,'Cancelled','2025-12-07',9000),
(361,'RAHUL VERMA','rahulverma361@EXAMPLE.COM','+91-96935-10920','Delhi','Wireless Mouse - Electronics',1,'COMPLETE','2025-02-19',1200),
(362,'Rohan Gupta','rohangupta362@','(735) 078-2959','Mumbai','Office Chair - Furniture',2,'return','2025-02-08',17000),
(363,'Nisha Mehta','nishamehta363 @ outlook.com','+91 9345649167','Bengaluru','Table Lamp - Home',2,'Pending','2025-09-20',3200),
(364,'Suresh Kumar',NULL,'72693 43434',NULL,'Laptop - Electronics',2,'Shipped','2025-07-04',130000),
(365,'Neha Joshi','nehajoshi365@gmail.com',NULL,'Bengaluru','Monitor - Electronics',3,'COMPLETE','2025-07-28',43500),
(366,'Manish Verma','manishverma366@outlook.com','8346582107',NULL,'Keyboard - Electronics',5,'completed','2025-01-19',9000),
(367,'Priya Singh','priyasingh367@outlook.com','6926608888','Bengaluru','Coffee Mug - Home',1,'cancelled','2025-09-10',450),
(368,'Suresh Verma','sureshverma368@example.com','9014253738','Pune','Wireless Mouse - Electronics',NULL,'shipped','2025-10-05',NULL),
(369,'  amit sharma  ','amitsharma369@outlook.com','+91-63393-95013','Kolkata','Coffee Mug - Home',2,'COMPLETE','2025-09-11',900),
(370,'ROHAN MEHTA',' rohanmehta370@gmail.com ','(733) 216-7822','Pune','Smartphone - Electronics',0,'Completed','2025-04-03',0),
(371,'Meera Sharma','meerasharma371@EXAMPLE.COM','+91 8629794700','Ahmedabad','Laptop - Electronics',2,NULL,'2025-12-22',130000),
(372,'Sneha Sharma','snehasharma372@','90404 09964','Mumbai','Smartphone - Electronics',1,'COMPLETE','2025-08-12',42000),
(373,'Suresh Rao','sureshrao373 @ outlook.com',NULL,'Hyderabad','Keyboard - Electronics',2,'completed','2025-01-11',3600),
(374,'Meera Reddy',NULL,'7129360134','Ahmedabad','Water Bottle - Lifestyle',1,'Shipped','2025-08-17',700),
(375,'Pooja Singh','poojasingh375@example.com','9690922160','Ahmedabad','Keyboard - Electronics',3,'COMPLETE','2025-05-25',5400),
(376,'Ananya Mehta','ananyamehta376@gmail.com','6980989514','Kolkata','Laptop - Electronics',1,'Completed','2025-04-02',65000),
(377,'Divya Gupta','divyagupta377@example.com','+91-99523-42924','Mumbai','Keyboard - Electronics',1,'shipped','2025-12-24',1800),
(378,'  meera kumar  ','meerakumar378@outlook.com','(706) 628-2253','Pune','Coffee Mug - Home',3,'pending','2025-02-19',1350),
(379,'POOJA SHARMA','poojasharma379@gmail.com','+91 6770278136','Delhi','USB Cable - Electronics',NULL,'Completed','2025-07-03',NULL),
(380,'Karan Reddy',' karanreddy380@outlook.com ','74057 46777','Bangalore','Notebook - Stationery',5,'Completed','2025-06-07',1250),
(381,'Kavya Mehta','kavyamehta381@OUTLOOK.COM',NULL,'Ahmedabad','Office Chair - Furniture',5,'Cancelled','2025-10-16',42500),
(382,'Vikram Rao','vikramrao382@','6646677686','Bengaluru','Coffee Mug - Home',4,'Completed','2025-04-18',1800),
(383,'Pooja Singh','poojasingh383 @ outlook.com','6006279398',NULL,'Headphones - Electronics',2,'completed','2025-04-17',6400),
(384,'Neha Verma',NULL,'6257247382','Mumbai','Smartphone - Electronics',2,'completed','2025-01-08',84000),
(385,'Suresh Verma','sureshverma385@outlook.com','+91-79690-62219','Bangalore','Pen Set - Stationery',1,'shipped','2025-03-21',180),
(386,'Rohan Sharma','rohansharma386@gmail.com','(786) 823-7222',NULL,'Keyboard - Electronics',2,'pending','2025-05-28',3600),
(387,'  arjun verma  ','arjunverma387@outlook.com','+91 7366047498','Chennai','Desk - Furniture',2,'completed','2025-04-05',24000),
(388,'MANISH SHARMA','manishsharma388@yahoo.com','64537 96587','Mumbai','Backpack - Accessories',5,'Cancelled','2025-07-04',9000),
(389,'Nisha Gupta','nishagupta389@yahoo.com',NULL,'New Delhi','Backpack - Accessories',2,'completed','2025-02-06',3600),
(390,'Kavya Mehta',' kavyamehta390@gmail.com ','6923507241','Hyderabad','Keyboard - Electronics',1,'Pending','2025-06-13',1800),
(391,'Suresh Singh','sureshsingh391@OUTLOOK.COM','7117407868','Mumbai','Laptop - Electronics',4,'Shipped','2025-09-24',260000),
(392,'Nisha Kumar','nishakumar392@','7984460654','Bangalore','USB Cable - Electronics',1,'completed','2025-01-02',500),
(393,'Neha Patel','nehapatel393 @ yahoo.com','+91-95376-50376','Pune','Monitor - Electronics',1,'Returned','2025-10-09',14500),
(394,'Priya Singh',NULL,'(684) 933-1223',NULL,'Backpack - Accessories',1,'completed','2025-06-04',1800),
(395,'Aarav Joshi','aaravjoshi395@gmail.com','+91 6721508131','Ahmedabad','Headphones - Electronics',4,'Shipped','2025-01-13',12800),
(396,'  meera patel  ','meerapatel396@outlook.com','69221 98636','Mumbai','Desk - Furniture',2,'Shipped','2025-03-02',24000),
(397,'ISHA MEHTA','ishamehta397@yahoo.com',NULL,'New Delhi','Backpack - Accessories',4,'shipped','2025-08-02',7200),
(398,'Priya Reddy','priyareddy398@example.com','6589424206','Pune','Office Chair - Furniture',NULL,'Pending','2025-11-26',NULL),
(399,'Nisha Singh','nishasingh399@example.com','9358302654','Hyderabad','Backpack - Accessories',NULL,'Shipped','2025-06-19',NULL),
(400,'Suresh Gupta',' sureshgupta400@example.com ','7161512446','Mumbai','Laptop - Electronics',3,'Returned','2025-04-01',195000);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(401,'Amit Singh','amitsingh401@EXAMPLE.COM','+91-82738-94381','Hyderabad','USB Cable - Electronics',2,'COMPLETE','2025-02-08',1000),
(402,'Neha Reddy','nehareddy402@','(928) 156-8562','Delhi','Pen Set - Stationery',4,'Cancelled','2025-03-06',720),
(403,'Neha Mehta','nehamehta403 @ outlook.com','+91 9462646554','Hyderabad','Coffee Mug - Home',1,'Cancelled','2025-10-19',450),
(404,'Rahul Mehta',NULL,'95935 85539','Chennai','Notebook - Stationery',2,'COMPLETE','2025-08-02',500),
(405,'  priya singh  ','priyasingh405@yahoo.com',NULL,'Delhi','Laptop - Electronics',NULL,'Shipped','2025-01-11',NULL),
(406,'ISHA KUMAR','ishakumar406@yahoo.com','7463548951','Mumbai','Coffee Mug - Home',3,'Completed','2025-01-05',1350),
(407,'Manish Patel','manishpatel407@gmail.com','9635607734','Kolkata','Table Lamp - Home',0,'Completed','2025-06-23',0),
(408,'Rohan Mehta','rohanmehta408@gmail.com','7445518797','New Delhi','Monitor - Electronics',1,'COMPLETE','2025-12-14',14500),
(409,'Divya Gupta','divyagupta409@yahoo.com','+91-90373-27498','Kolkata','Smartphone - Electronics',3,'Pending','2025-11-19',126000),
(410,'Sneha Verma',' snehaverma410@outlook.com ','(915) 248-4405','New Delhi','Keyboard - Electronics',1,'Completed','2025-12-19',1800),
(411,'Rohan Mehta','rohanmehta411@GMAIL.COM','+91 6782035199','Ahmedabad','Monitor - Electronics',2,'return','2025-10-04',29000),
(412,'Divya Patel','divyapatel412@','92012 25242','Bangalore','Office Chair - Furniture',3,'Cancelled','2025-03-21',25500),
(413,'Priya Gupta','priyagupta413 @ example.com',NULL,'New Delhi','Office Chair - Furniture',2,'completed','2025-06-09',17000),
(414,'  ananya singh  ',NULL,'7657587204','Chennai','Smartphone - Electronics',4,'COMPLETE','2025-07-16',168000),
(415,'ROHAN GUPTA','rohangupta415@example.com','6435632331','Chennai','USB Cable - Electronics',2,'COMPLETE','2025-08-03',1000),
(416,'Aarav Reddy','aaravreddy416@gmail.com','7368878709','New Delhi','Wireless Mouse - Electronics',1,'Cancelled','2025-03-13',1200),
(417,'Sneha Sharma','snehasharma417@gmail.com','+91-74514-86688','Ahmedabad','Pen Set - Stationery',5,'Completed','2025-07-21',900),
(418,'Sneha Mehta','snehamehta418@example.com','(667) 475-5608','Bengaluru','Wireless Mouse - Electronics',3,'Pending','2025-04-14',3600),
(419,'Nisha Rao','nisharao419@outlook.com','+91 8837246354','New Delhi','Desk - Furniture',2,'completed','2025-01-13',24000),
(420,'Manish Rao',' manishrao420@example.com ','66596 63750','Bengaluru','Monitor - Electronics',1,'cancelled','2025-02-10',14500),
(421,'Isha Joshi','ishajoshi421@YAHOO.COM',NULL,'Bengaluru','Office Chair - Furniture',1,'return','2025-05-03',8500),
(422,'Divya Sharma','divyasharma422@','9371019229','Pune','Backpack - Accessories',5,'return','2025-05-03',9000),
(423,'  nisha verma  ','nishaverma423 @ yahoo.com','7593521006','Pune','Monitor - Electronics',1,'Shipped','2025-01-09',14500),
(424,'KARAN JOSHI',NULL,'6971703178','New Delhi','Pen Set - Stationery',1,NULL,'2025-12-22',180),
(425,'Ananya Sharma','ananyasharma425@outlook.com','+91-94711-07346','Kolkata','Headphones - Electronics',2,'shipped','2025-01-27',6400),
(426,'Rohan Rao','rohanrao426@example.com','(830) 001-6872',NULL,'Table Lamp - Home',5,'Returned','2025-04-16',8000),
(427,'Kavya Sharma','kavyasharma427@example.com','+91 9877398554','Bengaluru','Notebook - Stationery',NULL,'Returned','2025-11-20',NULL),
(428,'Rahul Sharma','rahulsharma428@example.com','67425 09523','Mumbai','Office Chair - Furniture',2,'COMPLETE','2025-01-14',17000),
(429,'Priya Verma','priyaverma429@yahoo.com',NULL,NULL,'Keyboard - Electronics',2,'Cancelled','2025-12-26',3600),
(430,'Priya Sharma',' priyasharma430@example.com ','8389566051','Pune','Notebook - Stationery',3,'pending','2025-09-15',750),
(431,'Rajat Mehta','rajatmehta431@EXAMPLE.COM','6483264745','Pune','Keyboard - Electronics',1,'Returned','2025-10-19',1800),
(432,'  ananya sharma  ','ananyasharma432@','9374751777','New Delhi','Table Lamp - Home',NULL,'Cancelled','2025-07-09',NULL),
(433,'ROHAN JOSHI','rohanjoshi433 @ example.com','+91-61609-13827','Mumbai','Desk - Furniture',4,'COMPLETE','2025-10-20',48000),
(434,'Rohan Singh',NULL,'(982) 069-2142','Hyderabad','Smartphone - Electronics',2,'Completed','2025-12-16',84000),
(435,'Amit Gupta','amitgupta435@gmail.com','+91 7451123758','New Delhi','Desk - Furniture',2,'Shipped','2025-12-22',24000),
(436,'Ananya Kumar','ananyakumar436@yahoo.com','72905 53691','Chennai','USB Cable - Electronics',3,'pending','2025-12-14',1500),
(437,'Isha Sharma','ishasharma437@yahoo.com',NULL,'Delhi','Coffee Mug - Home',4,'Shipped','2025-09-28',1800),
(438,'Pooja Singh','poojasingh438@yahoo.com','6281822724','New Delhi','Smartphone - Electronics',NULL,'cancelled','2025-03-25',NULL),
(439,'Suresh Mehta','sureshmehta439@gmail.com','6746196273','Delhi','Coffee Mug - Home',2,'Completed','2025-04-02',900),
(440,'Karan Singh',' karansingh440@outlook.com ','9026379752','Delhi','Desk - Furniture',3,'Shipped','2025-09-13',36000),
(441,'  ananya singh  ','ananyasingh441@YAHOO.COM','+91-75997-32557','Chennai','Pen Set - Stationery',5,'COMPLETE','2025-08-19',900),
(442,'NISHA GUPTA','nishagupta442@','(670) 228-5630','New Delhi','Smartphone - Electronics',1,'pending','2025-01-13',42000),
(443,'Aarav Patel','aaravpatel443 @ yahoo.com','+91 9681264539','Delhi','Water Bottle - Lifestyle',2,'return','2025-04-09',1400),
(444,'Meera Rao',NULL,'97135 57275',NULL,'Laptop - Electronics',0,'Completed','2025-11-06',0),
(445,'Isha Singh','ishasingh445@yahoo.com',NULL,'Ahmedabad','USB Cable - Electronics',2,'return','2025-05-14',1000),
(446,'Rohan Gupta','rohangupta446@example.com','7082326234','Delhi','Backpack - Accessories',2,'return','2025-09-27',3600),
(447,'Isha Verma','ishaverma447@gmail.com','6031557592','Kolkata','Water Bottle - Lifestyle',3,'shipped','2025-11-20',2100),
(448,'Isha Reddy','ishareddy448@outlook.com','8939532043','Bangalore','Backpack - Accessories',1,'Cancelled','2025-05-21',1800),
(449,'Arjun Reddy','arjunreddy449@outlook.com','+91-88180-12241',NULL,'Desk - Furniture',2,'COMPLETE','2025-09-25',24000),
(450,'  neha singh  ',' nehasingh450@example.com ','(883) 695-6156','Hyderabad','Water Bottle - Lifestyle',1,'Completed','2025-11-16',700),
(451,'KAVYA REDDY','kavyareddy451@EXAMPLE.COM','+91 7737739017','Pune','Smartphone - Electronics',1,'Returned','2025-12-19',42000),
(452,'Vikram Gupta','vikramgupta452@','89477 13853','Kolkata','Water Bottle - Lifestyle',5,'return','2025-06-17',3500),
(453,'Kavya Patel','kavyapatel453 @ yahoo.com',NULL,'Bangalore','Backpack - Accessories',1,'pending','2025-12-26',1800),
(454,'Nisha Patel',NULL,'8810775408','Bangalore','Office Chair - Furniture',3,'Pending','2025-12-28',25500),
(455,'Kavya Verma','kavyaverma455@outlook.com','7596363878','New Delhi','Pen Set - Stationery',2,'Shipped','2025-02-16',360),
(456,'Aarav Mehta','aaravmehta456@gmail.com','8028168087','Delhi','Notebook - Stationery',1,'return','2025-07-17',250),
(457,'Kavya Verma','kavyaverma457@gmail.com','+91-97402-68586','Mumbai','Keyboard - Electronics',2,'Cancelled','2025-07-19',3600),
(458,'Karan Patel','karanpatel458@outlook.com','(970) 395-3781','Mumbai','USB Cable - Electronics',1,'Shipped','2025-06-21',500),
(459,'  sneha gupta  ','snehagupta459@gmail.com','+91 6020244331','Chennai','Desk - Furniture',2,'COMPLETE','2025-10-25',24000),
(460,'SNEHA JOSHI',' snehajoshi460@gmail.com ','65557 94362','Ahmedabad','Headphones - Electronics',4,'cancelled','2025-07-16',12800),
(461,'Rohan Singh','rohansingh461@GMAIL.COM',NULL,'Delhi','Smartphone - Electronics',3,'Completed','2025-06-25',126000),
(462,'Suresh Kumar','sureshkumar462@','8906611156','Bengaluru','Water Bottle - Lifestyle',2,'Pending','2025-12-12',1400),
(463,'Kavya Patel','kavyapatel463 @ gmail.com','7647336743','Kolkata','Pen Set - Stationery',2,'COMPLETE','2025-02-27',360),
(464,'Aarav Reddy',NULL,'7958188576','Kolkata','Pen Set - Stationery',NULL,'Cancelled','2025-07-22',NULL),
(465,'Rahul Gupta','rahulgupta465@example.com','+91-75429-70785','Delhi','Keyboard - Electronics',4,'Completed','2025-04-08',7200),
(466,'Rahul Kumar','rahulkumar466@gmail.com','(853) 271-1433','Kolkata','Keyboard - Electronics',1,'Cancelled','2025-12-21',1800),
(467,'Aarav Verma','aaravverma467@outlook.com','+91 9312492080','Kolkata','Pen Set - Stationery',1,'Returned','2025-01-22',180),
(468,'  ananya singh  ','ananyasingh468@gmail.com','89624 52613','Bangalore','Headphones - Electronics',5,'cancelled','2025-02-18',16000),
(469,'AMIT JOSHI','amitjoshi469@yahoo.com',NULL,NULL,'Water Bottle - Lifestyle',1,'pending','2025-07-22',700),
(470,'Ananya Rao',' ananyarao470@outlook.com ','8674896065','Ahmedabad','Smartphone - Electronics',1,'cancelled','2025-02-17',42000),
(471,'Isha Sharma','ishasharma471@OUTLOOK.COM','6489680170','Bangalore','Backpack - Accessories',2,'Returned','2025-04-25',3600),
(472,'Amit Rao','amitrao472@','7537262560','Pune','Desk - Furniture',1,'Completed','2025-09-16',12000),
(473,'Vikram Joshi','vikramjoshi473 @ outlook.com','+91-70071-92464','Bengaluru','Laptop - Electronics',1,'completed','2025-10-22',65000),
(474,'Divya Patel',NULL,'(934) 803-9631','Kolkata','Wireless Mouse - Electronics',1,'pending','2025-11-08',1200),
(475,'Karan Reddy','karanreddy475@outlook.com','+91 7994056084','Bengaluru','Wireless Mouse - Electronics',1,'Completed','2025-05-12',1200),
(476,'Arjun Verma','arjunverma476@gmail.com','64080 15311','Bengaluru','Laptop - Electronics',1,'return','2025-11-06',65000),
(477,'  arjun gupta  ','arjungupta477@example.com',NULL,'New Delhi','Coffee Mug - Home',1,NULL,'2025-06-06',450),
(478,'ANANYA VERMA','ananyaverma478@example.com','7960818751','New Delhi','Table Lamp - Home',4,'Shipped','2025-07-21',6400),
(479,'Sneha Sharma','snehasharma479@yahoo.com','8990026838','Bengaluru','Table Lamp - Home',1,'completed','2025-07-19',1600),
(480,'Divya Mehta',' divyamehta480@example.com ','6778508164','Ahmedabad','Headphones - Electronics',3,'Returned','2025-01-28',9600),
(481,'Rahul Joshi','rahuljoshi481@EXAMPLE.COM','+91-64850-62769','Pune','Backpack - Accessories',0,'Completed','2025-05-21',0),
(482,'Arjun Singh','arjunsingh482@','(887) 695-9590','Hyderabad','Notebook - Stationery',NULL,'Returned','2025-02-14',NULL),
(483,'Neha Joshi','nehajoshi483 @ outlook.com','+91 8850615512',NULL,'Water Bottle - Lifestyle',4,'COMPLETE','2025-09-20',2800),
(484,'Aarav Singh',NULL,'81713 96180','Chennai','Table Lamp - Home',5,'COMPLETE','2025-02-25',8000),
(485,'Divya Gupta','divyagupta485@yahoo.com',NULL,'New Delhi','Laptop - Electronics',NULL,'Pending','2025-09-21',NULL),
(486,'  rohan verma  ','rohanverma486@yahoo.com','6338574832','Chennai','Backpack - Accessories',5,'completed','2025-08-15',9000),
(487,'ARJUN SHARMA','arjunsharma487@example.com','9200776977',NULL,'Laptop - Electronics',1,'cancelled','2025-07-02',65000),
(488,'Nisha Rao','nisharao488@gmail.com','9547251133','Bangalore','USB Cable - Electronics',2,'shipped','2025-09-07',1000),
(489,'Karan Gupta','karangupta489@outlook.com','+91-95446-83724','Bengaluru','Table Lamp - Home',2,'Shipped','2025-06-18',3200),
(490,'Isha Mehta',' ishamehta490@example.com ','(907) 802-2953',NULL,'Monitor - Electronics',5,'completed','2025-02-25',72500),
(491,'Neha Singh','nehasingh491@OUTLOOK.COM','+91 7525310290',NULL,'USB Cable - Electronics',2,'shipped','2025-09-12',1000),
(492,'Ananya Singh','ananyasingh492@','81149 37010','Mumbai','Table Lamp - Home',4,'completed','2025-05-20',6400),
(493,'Vikram Kumar','vikramkumar493 @ gmail.com',NULL,'Pune','Office Chair - Furniture',5,'Pending','2025-12-11',42500),
(494,'Ananya Verma',NULL,'9979830631',NULL,'Table Lamp - Home',1,'Shipped','2025-08-22',1600),
(495,'  manish rao  ','manishrao495@yahoo.com','8142452709','Bengaluru','Notebook - Stationery',1,'shipped','2025-07-27',250),
(496,'MANISH JOSHI','manishjoshi496@yahoo.com','8971334438','Ahmedabad','Keyboard - Electronics',1,'completed','2025-07-22',1800),
(497,'Isha Mehta','ishamehta497@outlook.com','+91-81651-36471','Pune','Headphones - Electronics',2,'pending','2025-07-11',6400),
(498,'Kavya Joshi','kavyajoshi498@yahoo.com','(659) 347-8613','Pune','Pen Set - Stationery',NULL,'pending','2025-12-18',NULL),
(499,'Arjun Rao','arjunrao499@yahoo.com','+91 6862812038','Delhi','Pen Set - Stationery',2,'return','2025-06-22',360),
(500,'Rahul Patel',' rahulpatel500@outlook.com ','90509 41750','Bangalore','USB Cable - Electronics',3,'shipped','2025-08-19',1500);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(501,'Manish Verma','manishverma501@OUTLOOK.COM',NULL,'Pune','USB Cable - Electronics',1,'shipped','2025-02-01',500),
(502,'Rohan Patel','rohanpatel502@','8878719791','Bengaluru','Office Chair - Furniture',2,'COMPLETE','2025-05-22',17000),
(503,'Amit Patel','amitpatel503 @ gmail.com','8966082283','New Delhi','Office Chair - Furniture',NULL,'Completed','2025-06-27',NULL),
(504,'  karan sharma  ',NULL,'9188638426',NULL,'Notebook - Stationery',4,'Pending','2025-09-26',1000),
(505,'KAVYA SINGH','kavyasingh505@example.com','+91-76645-34549','Pune','USB Cable - Electronics',3,'shipped','2025-01-01',1500),
(506,'Amit Kumar','amitkumar506@example.com','(956) 475-1926','Delhi','Coffee Mug - Home',3,'Returned','2025-09-24',1350),
(507,'Isha Kumar','ishakumar507@yahoo.com','+91 7263483694','Chennai','Keyboard - Electronics',1,'COMPLETE','2025-03-24',1800),
(508,'Suresh Sharma','sureshsharma508@example.com','61745 22691','Pune','Desk - Furniture',NULL,'pending','2025-03-06',NULL),
(509,'Manish Reddy','manishreddy509@gmail.com',NULL,'Chennai','Smartphone - Electronics',1,'Completed','2025-03-11',42000),
(510,'Isha Singh',' ishasingh510@outlook.com ','8106900240','Ahmedabad','Notebook - Stationery',3,'completed','2025-12-11',750),
(511,'Suresh Kumar','sureshkumar511@YAHOO.COM','8235986982','Bangalore','USB Cable - Electronics',NULL,'COMPLETE','2025-07-18',NULL),
(512,'Nisha Verma','nishaverma512@','7500674245','Delhi','Coffee Mug - Home',2,'return','2025-06-11',900),
(513,'  pooja reddy  ','poojareddy513 @ yahoo.com','+91-92326-31578','Ahmedabad','Notebook - Stationery',5,'shipped','2025-11-01',1250),
(514,'ANANYA GUPTA',NULL,'(703) 228-6260',NULL,'Pen Set - Stationery',2,'Completed','2025-11-11',360),
(515,'Rohan Sharma','rohansharma515@example.com','+91 7102048042','Kolkata','Smartphone - Electronics',2,'Completed','2025-09-27',84000),
(516,'Pooja Rao','poojarao516@example.com','80908 10307','Bengaluru','Desk - Furniture',2,'Cancelled','2025-09-03',24000),
(517,'Ananya Patel','ananyapatel517@gmail.com',NULL,'Bangalore','Office Chair - Furniture',2,'return','2025-07-27',17000),
(518,'Ananya Kumar','ananyakumar518@example.com','8776959016','Bangalore','Smartphone - Electronics',0,'Completed','2025-08-23',0),
(519,'Arjun Singh','arjunsingh519@gmail.com','6314597900','Bengaluru','Keyboard - Electronics',2,'shipped','2025-02-19',3600),
(520,'Neha Reddy',' nehareddy520@example.com ','7666587357','Chennai','Water Bottle - Lifestyle',4,'cancelled','2025-06-01',2800),
(521,'Rohan Sharma','rohansharma521@GMAIL.COM','+91-87548-89723','Ahmedabad','Wireless Mouse - Electronics',1,'completed','2025-06-17',1200),
(522,'  ananya reddy  ','ananyareddy522@','(860) 518-0473','Bangalore','Desk - Furniture',5,'cancelled','2025-07-27',60000),
(523,'RAJAT JOSHI','rajatjoshi523 @ yahoo.com','+91 8291226621','Delhi','Keyboard - Electronics',4,'shipped','2025-05-21',7200),
(524,'Rahul Reddy',NULL,'60478 89782','Kolkata','Table Lamp - Home',NULL,'COMPLETE','2025-02-02',NULL),
(525,'Rajat Mehta','rajatmehta525@example.com',NULL,'Kolkata','Wireless Mouse - Electronics',2,'Pending','2025-12-24',2400),
(526,'Pooja Kumar','poojakumar526@example.com','9889642781',NULL,'Table Lamp - Home',NULL,'COMPLETE','2025-03-06',NULL),
(527,'Neha Mehta','nehamehta527@outlook.com','6834624758','Bangalore','Keyboard - Electronics',1,'shipped','2025-08-21',1800),
(528,'Nisha Sharma','nishasharma528@outlook.com','8884866198','Bangalore','Desk - Furniture',1,'Pending','2025-12-19',12000),
(529,'Divya Gupta','divyagupta529@outlook.com','+91-65506-79848',NULL,'Water Bottle - Lifestyle',2,'completed','2025-05-20',1400),
(530,'Priya Kumar',' priyakumar530@outlook.com ','(808) 675-8111','Chennai','Monitor - Electronics',2,NULL,'2025-03-19',29000),
(531,'  manish gupta  ','manishgupta531@OUTLOOK.COM','+91 7839566253','Mumbai','Laptop - Electronics',3,'Pending','2025-04-23',195000),
(532,'MEERA REDDY','meerareddy532@','65768 39151',NULL,'Smartphone - Electronics',3,'Shipped','2025-08-15',126000),
(533,'Pooja Reddy','poojareddy533 @ example.com',NULL,'Bangalore','Keyboard - Electronics',1,'pending','2025-03-18',1800),
(534,'Vikram Reddy',NULL,'9124268175','Bangalore','Coffee Mug - Home',1,'shipped','2025-11-01',450),
(535,'Manish Mehta','manishmehta535@example.com','9303689934','Ahmedabad','Office Chair - Furniture',1,'shipped','2025-05-18',8500),
(536,'Nisha Joshi','nishajoshi536@yahoo.com','7571179066','Pune','Office Chair - Furniture',2,'COMPLETE','2025-08-17',17000),
(537,'Suresh Sharma','sureshsharma537@example.com','+91-75627-90683','Kolkata','Laptop - Electronics',2,'Returned','2025-11-06',130000),
(538,'Suresh Patel','sureshpatel538@example.com','(668) 385-5081','Mumbai','Pen Set - Stationery',1,'Shipped','2025-06-02',180),
(539,'Neha Joshi','nehajoshi539@yahoo.com','+91 6269986628','New Delhi','Monitor - Electronics',2,'Completed','2025-11-07',29000),
(540,'  suresh gupta  ',' sureshgupta540@example.com ','80172 35435','Chennai','Coffee Mug - Home',1,'Completed','2025-11-11',450),
(541,'ANANYA RAO','ananyarao541@OUTLOOK.COM',NULL,'New Delhi','Pen Set - Stationery',NULL,'Returned','2025-03-13',NULL),
(542,'Rohan Gupta','rohangupta542@','8219050244','New Delhi','Headphones - Electronics',2,'shipped','2025-07-12',6400),
(543,'Pooja Joshi','poojajoshi543 @ example.com','9810374469','Ahmedabad','Laptop - Electronics',NULL,'COMPLETE','2025-08-06',NULL),
(544,'Neha Sharma',NULL,'6908459040','Mumbai','Keyboard - Electronics',1,'Cancelled','2025-10-23',1800),
(545,'Ananya Kumar','ananyakumar545@example.com','+91-94839-59915','Hyderabad','Smartphone - Electronics',1,'Shipped','2025-11-16',42000),
(546,'Divya Kumar','divyakumar546@yahoo.com','(877) 995-7226','Pune','Laptop - Electronics',2,'Completed','2025-03-19',130000),
(547,'Manish Patel','manishpatel547@yahoo.com','+91 8703855522','Kolkata','Laptop - Electronics',1,'Completed','2025-03-09',65000),
(548,'Sneha Rao','sneharao548@example.com','85742 20936','Ahmedabad','Water Bottle - Lifestyle',1,'return','2025-05-03',700),
(549,'  vikram joshi  ','vikramjoshi549@example.com',NULL,'Chennai','Keyboard - Electronics',2,'cancelled','2025-10-05',3600),
(550,'MANISH PATEL',' manishpatel550@outlook.com ','6720359227',NULL,'Monitor - Electronics',5,'Returned','2025-10-03',72500),
(551,'Neha Verma','nehaverma551@EXAMPLE.COM','6567851370','Bangalore','Laptop - Electronics',2,'shipped','2025-09-22',130000),
(552,'Meera Patel','meerapatel552@','6762022478','Chennai','Coffee Mug - Home',1,'shipped','2025-09-25',450),
(553,'Ananya Sharma','ananyasharma553 @ example.com','+91-88320-69709','Mumbai','Coffee Mug - Home',NULL,'Completed','2025-11-21',NULL),
(554,'Meera Rao',NULL,'(759) 075-9039','Bengaluru','Smartphone - Electronics',NULL,'cancelled','2025-04-26',NULL),
(555,'Divya Verma','divyaverma555@outlook.com','+91 8529942267','Ahmedabad','Wireless Mouse - Electronics',0,'Completed','2025-05-16',0),
(556,'Neha Sharma','nehasharma556@outlook.com','85696 46059','Kolkata','Headphones - Electronics',2,'Pending','2025-01-23',6400),
(557,'Rajat Mehta','rajatmehta557@gmail.com',NULL,'Bengaluru','Headphones - Electronics',2,'Cancelled','2025-07-12',6400),
(558,'  ananya patel  ','ananyapatel558@example.com','8798497340','Ahmedabad','Desk - Furniture',2,'shipped','2025-07-19',24000),
(559,'POOJA MEHTA','poojamehta559@outlook.com','8923179238','Pune','USB Cable - Electronics',2,'cancelled','2025-09-26',1000),
(560,'Nisha Joshi',' nishajoshi560@yahoo.com ','7590052587','Kolkata','Notebook - Stationery',5,'pending','2025-05-19',1250),
(561,'Pooja Verma','poojaverma561@YAHOO.COM','+91-96721-92390',NULL,'Wireless Mouse - Electronics',2,'Shipped','2025-12-06',2400),
(562,'Ananya Kumar','ananyakumar562@','(937) 619-2710','Hyderabad','USB Cable - Electronics',NULL,'Returned','2025-12-22',NULL),
(563,'Aarav Patel','aaravpatel563 @ example.com','+91 8731069282','Bengaluru','USB Cable - Electronics',1,'COMPLETE','2025-08-20',500),
(564,'Meera Sharma',NULL,'71299 71523','Delhi','Monitor - Electronics',1,'Returned','2025-01-24',14500),
(565,'Rohan Verma','rohanverma565@outlook.com',NULL,'Ahmedabad','Laptop - Electronics',1,'return','2025-08-15',65000),
(566,'Rajat Kumar','rajatkumar566@outlook.com','6836429847','Bengaluru','USB Cable - Electronics',NULL,'shipped','2025-12-08',NULL),
(567,'  isha patel  ','ishapatel567@gmail.com','7545071541','Delhi','Water Bottle - Lifestyle',1,'COMPLETE','2025-02-09',700),
(568,'ROHAN GUPTA','rohangupta568@example.com','7741398650','Ahmedabad','Office Chair - Furniture',NULL,'Completed','2025-12-23',NULL),
(569,'Priya Sharma','priyasharma569@outlook.com','+91-91187-41999','Kolkata','Coffee Mug - Home',3,'Cancelled','2025-05-08',1350),
(570,'Isha Kumar',' ishakumar570@example.com ','(999) 309-0528','Pune','Pen Set - Stationery',1,'pending','2025-03-14',180),
(571,'Suresh Sharma','sureshsharma571@GMAIL.COM','+91 8161095131','New Delhi','Monitor - Electronics',1,'shipped','2025-05-18',14500),
(572,'Manish Reddy','manishreddy572@','76195 47472','Ahmedabad','Backpack - Accessories',2,'Cancelled','2025-08-22',3600),
(573,'Karan Mehta','karanmehta573 @ gmail.com',NULL,'Bangalore','Desk - Furniture',1,'cancelled','2025-11-26',12000),
(574,'Neha Kumar',NULL,'7771356036','Hyderabad','Notebook - Stationery',NULL,'Completed','2025-12-27',NULL),
(575,'Amit Kumar','amitkumar575@outlook.com','6399472479','Pune','Water Bottle - Lifestyle',3,'completed','2025-09-06',2100),
(576,'  divya gupta  ','divyagupta576@outlook.com','6938734379','Ahmedabad','Desk - Furniture',1,'return','2025-04-16',12000),
(577,'VIKRAM KUMAR','vikramkumar577@yahoo.com','+91-97484-00480','New Delhi','Office Chair - Furniture',2,'Pending','2025-04-27',17000),
(578,'Isha Gupta','ishagupta578@yahoo.com','(934) 551-5321','Bangalore','Wireless Mouse - Electronics',1,'return','2025-11-16',1200),
(579,'Isha Singh','ishasingh579@gmail.com','+91 9642177784','Chennai','Monitor - Electronics',3,'Shipped','2025-10-28',43500),
(580,'Amit Joshi',' amitjoshi580@yahoo.com ','92824 81668','Kolkata','Desk - Furniture',4,'Pending','2025-10-05',48000),
(581,'Aarav Rao','aaravrao581@EXAMPLE.COM',NULL,'Kolkata','Laptop - Electronics',NULL,'Cancelled','2025-07-28',NULL),
(582,'Sneha Joshi','snehajoshi582@','8998937576','Kolkata','Backpack - Accessories',3,'Completed','2025-01-22',5400),
(583,'Vikram Verma','vikramverma583 @ gmail.com','7397737837','Hyderabad','Pen Set - Stationery',2,NULL,'2025-09-09',360),
(584,'Neha Reddy',NULL,'8633175934','Hyderabad','Monitor - Electronics',1,'Shipped','2025-07-07',14500),
(585,'  meera gupta  ','meeragupta585@outlook.com','+91-96693-02613','Pune','Desk - Furniture',5,'COMPLETE','2025-10-05',60000),
(586,'MANISH KUMAR','manishkumar586@gmail.com','(909) 587-8831','New Delhi','USB Cable - Electronics',2,'shipped','2025-07-28',1000),
(587,'Rohan Kumar','rohankumar587@yahoo.com','+91 9436134704','Mumbai','Backpack - Accessories',1,'COMPLETE','2025-07-16',1800),
(588,'Rahul Rao','rahulrao588@outlook.com','93729 79284','Chennai','Desk - Furniture',2,'shipped','2025-10-02',24000),
(589,'Rohan Sharma','rohansharma589@yahoo.com',NULL,'Delhi','Table Lamp - Home',2,'Shipped','2025-11-04',3200),
(590,'Karan Gupta',' karangupta590@outlook.com ','7550320086','Hyderabad','Notebook - Stationery',NULL,'pending','2025-06-01',NULL),
(591,'Meera Sharma','meerasharma591@OUTLOOK.COM','9725319704',NULL,'Pen Set - Stationery',2,'Returned','2025-10-21',360),
(592,'Nisha Patel','nishapatel592@','7525181720','Hyderabad','Water Bottle - Lifestyle',0,'Completed','2025-12-15',0),
(593,'Priya Verma','priyaverma593 @ outlook.com','+91-79918-00019',NULL,'Keyboard - Electronics',1,'return','2025-06-14',1800),
(594,'  isha mehta  ',NULL,'(964) 600-1048','Bangalore','Wireless Mouse - Electronics',1,'Cancelled','2025-04-11',1200),
(595,'ARJUN REDDY','arjunreddy595@outlook.com','+91 8600108647',NULL,'Headphones - Electronics',2,'Shipped','2025-06-24',6400),
(596,'Manish Rao','manishrao596@example.com','77780 69478','Mumbai','Keyboard - Electronics',1,'COMPLETE','2025-12-08',1800),
(597,'Amit Sharma','amitsharma597@yahoo.com',NULL,'Pune','Wireless Mouse - Electronics',1,'completed','2025-08-18',1200),
(598,'Aarav Singh','aaravsingh598@example.com','8250488948','Bangalore','Wireless Mouse - Electronics',2,'Returned','2025-03-03',2400),
(599,'Rohan Reddy','rohanreddy599@yahoo.com','7062559949','New Delhi','Backpack - Accessories',1,'COMPLETE','2025-09-27',1800),
(600,'Sneha Singh',' snehasingh600@gmail.com ','8849921830','Hyderabad','Table Lamp - Home',3,'Shipped','2025-08-28',4800);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(601,'Nisha Reddy','nishareddy601@EXAMPLE.COM','+91-65803-14097','Kolkata','Keyboard - Electronics',5,'return','2025-12-21',9000),
(602,'Manish Verma','manishverma602@','(990) 379-5231','Hyderabad','Backpack - Accessories',NULL,'Pending','2025-02-15',NULL),
(603,'  kavya gupta  ','kavyagupta603 @ example.com','+91 7115862756','Mumbai','Desk - Furniture',1,'Completed','2025-09-27',12000),
(604,'RAHUL GUPTA',NULL,'80151 89868','Kolkata','Laptop - Electronics',5,'Shipped','2025-05-01',325000),
(605,'Meera Reddy','meerareddy605@yahoo.com',NULL,'Bengaluru','Notebook - Stationery',3,'Pending','2025-07-18',750),
(606,'Meera Verma','meeraverma606@yahoo.com','6701237129',NULL,'Headphones - Electronics',4,'Pending','2025-05-03',12800),
(607,'Meera Kumar','meerakumar607@outlook.com','7222677762',NULL,'Smartphone - Electronics',NULL,'pending','2025-07-07',NULL),
(608,'Priya Patel','priyapatel608@yahoo.com','7243802345','Bangalore','Water Bottle - Lifestyle',5,'Returned','2025-08-09',3500),
(609,'Isha Joshi','ishajoshi609@yahoo.com','+91-73771-54307','Bengaluru','Keyboard - Electronics',1,'shipped','2025-01-06',1800),
(610,'Ananya Reddy',' ananyareddy610@outlook.com ','(653) 703-9291','Chennai','Smartphone - Electronics',1,'Pending','2025-02-05',42000),
(611,'Rajat Joshi','rajatjoshi611@YAHOO.COM','+91 7468504537','Pune','Desk - Furniture',5,'Cancelled','2025-08-23',60000),
(612,'  aarav gupta  ','aaravgupta612@','96230 03768','Mumbai','Laptop - Electronics',2,'cancelled','2025-02-18',130000),
(613,'DIVYA PATEL','divyapatel613 @ yahoo.com',NULL,'New Delhi','Table Lamp - Home',4,'Completed','2025-02-25',6400),
(614,'Neha Verma',NULL,'7061553531','Bengaluru','Office Chair - Furniture',5,'completed','2025-09-22',42500),
(615,'Vikram Joshi','vikramjoshi615@example.com','8926772459','New Delhi','Coffee Mug - Home',3,'COMPLETE','2025-11-24',1350),
(616,'Aarav Rao','aaravrao616@gmail.com','7087969934','Chennai','Water Bottle - Lifestyle',2,'Pending','2025-06-02',1400),
(617,'Vikram Sharma','vikramsharma617@yahoo.com','+91-87183-23324','Pune','Monitor - Electronics',1,'COMPLETE','2025-05-19',14500),
(618,'Ananya Verma','ananyaverma618@yahoo.com','(603) 835-3417','Bengaluru','Pen Set - Stationery',5,'Returned','2025-03-12',900),
(619,'Priya Kumar','priyakumar619@yahoo.com','+91 8147136659','Bangalore','Water Bottle - Lifestyle',3,'return','2025-01-02',2100),
(620,'Pooja Patel',' poojapatel620@gmail.com ','65404 24819','Chennai','Office Chair - Furniture',3,'shipped','2025-11-25',25500),
(621,'  pooja joshi  ','poojajoshi621@YAHOO.COM',NULL,'Pune','Monitor - Electronics',1,'pending','2025-01-16',14500),
(622,'KARAN RAO','karanrao622@','8331025091','Chennai','Office Chair - Furniture',1,'shipped','2025-06-11',8500),
(623,'Karan Reddy','karanreddy623 @ yahoo.com','6295822679','Kolkata','Keyboard - Electronics',5,'pending','2025-05-18',9000),
(624,'Pooja Joshi',NULL,'9332542030',NULL,'Notebook - Stationery',4,'COMPLETE','2025-01-20',1000),
(625,'Pooja Mehta','poojamehta625@yahoo.com','+91-73773-70646','Bangalore','Water Bottle - Lifestyle',NULL,'cancelled','2025-04-17',NULL),
(626,'Divya Rao','divyarao626@yahoo.com','(863) 298-3517','New Delhi','Monitor - Electronics',4,'return','2025-06-04',58000),
(627,'Ananya Rao','ananyarao627@gmail.com','+91 6188021892','Mumbai','Keyboard - Electronics',1,'Pending','2025-02-16',1800),
(628,'Vikram Sharma','vikramsharma628@gmail.com','84524 78646',NULL,'Table Lamp - Home',4,'return','2025-08-17',6400),
(629,'Isha Mehta','ishamehta629@outlook.com',NULL,'Hyderabad','Office Chair - Furniture',0,'Completed','2025-04-21',0),
(630,'  divya sharma  ',' divyasharma630@example.com ','9440354470',NULL,'Laptop - Electronics',3,'shipped','2025-12-14',195000),
(631,'POOJA SINGH','poojasingh631@OUTLOOK.COM','8272127173','Bengaluru','Smartphone - Electronics',1,'pending','2025-02-07',42000),
(632,'Suresh Sharma','sureshsharma632@','9114589739','Delhi','Notebook - Stationery',4,'Pending','2025-04-17',1000),
(633,'Neha Mehta','nehamehta633 @ yahoo.com','+91-83984-10571','Kolkata','Headphones - Electronics',1,'return','2025-10-12',3200),
(634,'Karan Verma',NULL,'(671) 644-0566','Mumbai','Notebook - Stationery',4,'shipped','2025-06-22',1000),
(635,'Sneha Rao','sneharao635@example.com','+91 7513220374','Hyderabad','Notebook - Stationery',3,'Cancelled','2025-07-25',750),
(636,'Meera Gupta','meeragupta636@yahoo.com','84186 88092','Kolkata','Office Chair - Furniture',4,NULL,'2025-12-09',34000),
(637,'Pooja Joshi','poojajoshi637@example.com',NULL,'Bengaluru','Smartphone - Electronics',1,'pending','2025-10-01',42000),
(638,'Suresh Patel','sureshpatel638@outlook.com','6028212913','New Delhi','Office Chair - Furniture',2,'Cancelled','2025-01-25',17000),
(639,'  amit rao  ','amitrao639@yahoo.com','6404960131','Bengaluru','Backpack - Accessories',3,'COMPLETE','2025-03-09',5400),
(640,'POOJA MEHTA',' poojamehta640@yahoo.com ','7000702246','New Delhi','USB Cable - Electronics',2,'completed','2025-10-13',1000),
(641,'Manish Kumar','manishkumar641@GMAIL.COM','+91-91077-54709','Hyderabad','USB Cable - Electronics',5,'COMPLETE','2025-08-27',2500),
(642,'Manish Sharma','manishsharma642@','(616) 050-9766','Ahmedabad','Headphones - Electronics',1,'Completed','2025-06-12',3200),
(643,'Meera Verma','meeraverma643 @ gmail.com','+91 9735704638','Delhi','Smartphone - Electronics',1,'return','2025-11-13',42000),
(644,'Aarav Reddy',NULL,'73714 54094','Kolkata','Pen Set - Stationery',1,'Cancelled','2025-09-23',180),
(645,'Neha Patel','nehapatel645@gmail.com',NULL,'Pune','Backpack - Accessories',NULL,'completed','2025-04-14',NULL),
(646,'Kavya Verma','kavyaverma646@yahoo.com','6567747634','Hyderabad','Wireless Mouse - Electronics',5,'Returned','2025-12-02',6000),
(647,'Nisha Verma','nishaverma647@outlook.com','6365411459','Pune','Notebook - Stationery',4,'COMPLETE','2025-03-16',1000),
(648,'  nisha kumar  ','nishakumar648@example.com','7697881328',NULL,'Pen Set - Stationery',2,'shipped','2025-10-24',360),
(649,'SURESH KUMAR','sureshkumar649@yahoo.com','+91-63077-08574','New Delhi','USB Cable - Electronics',4,'Cancelled','2025-11-19',2000),
(650,'Priya Sharma',' priyasharma650@example.com ','(781) 909-3035','Hyderabad','Monitor - Electronics',2,'Cancelled','2025-06-20',29000),
(651,'Rajat Reddy','rajatreddy651@YAHOO.COM','+91 7502020490','Ahmedabad','Table Lamp - Home',5,'Returned','2025-03-15',8000),
(652,'Aarav Kumar','aaravkumar652@','89435 95471','Hyderabad','Keyboard - Electronics',1,'completed','2025-12-02',1800),
(653,'Neha Mehta','nehamehta653 @ yahoo.com',NULL,'New Delhi','Laptop - Electronics',3,'completed','2025-05-15',195000),
(654,'Divya Singh',NULL,'6897689138','Kolkata','Office Chair - Furniture',2,'shipped','2025-09-25',17000),
(655,'Amit Rao','amitrao655@example.com','8675944972','Mumbai','Smartphone - Electronics',1,'cancelled','2025-10-22',42000),
(656,'Suresh Singh','sureshsingh656@outlook.com','6731517326','Bengaluru','Desk - Furniture',2,'Returned','2025-05-02',24000),
(657,'  karan singh  ','karansingh657@gmail.com','+91-76692-18196',NULL,'Desk - Furniture',3,'completed','2025-01-10',36000),
(658,'ROHAN KUMAR','rohankumar658@example.com','(818) 416-4080','Bangalore','Coffee Mug - Home',3,'Shipped','2025-10-18',1350),
(659,'Priya Patel','priyapatel659@yahoo.com','+91 8150278891','Chennai','Notebook - Stationery',1,'Completed','2025-04-17',250),
(660,'Kavya Gupta',' kavyagupta660@example.com ','76896 39333','Mumbai','Laptop - Electronics',3,'return','2025-06-12',195000),
(661,'Kavya Kumar','kavyakumar661@OUTLOOK.COM',NULL,'Bengaluru','Water Bottle - Lifestyle',2,'cancelled','2025-01-18',1400),
(662,'Amit Kumar','amitkumar662@','7467960342','Pune','Water Bottle - Lifestyle',1,'completed','2025-12-13',700),
(663,'Suresh Mehta','sureshmehta663 @ yahoo.com','7792433036','Delhi','Pen Set - Stationery',1,'cancelled','2025-05-20',180),
(664,'Arjun Joshi',NULL,'6888015719',NULL,'Keyboard - Electronics',NULL,'return','2025-04-28',NULL),
(665,'Rahul Reddy','rahulreddy665@yahoo.com','+91-78471-12068','Mumbai','Water Bottle - Lifestyle',1,'Cancelled','2025-02-18',700),
(666,'  nisha sharma  ','nishasharma666@yahoo.com','(736) 407-1251','Mumbai','Smartphone - Electronics',0,'Completed','2025-07-14',0),
(667,'KAVYA JOSHI','kavyajoshi667@outlook.com','+91 6652650570','Delhi','Wireless Mouse - Electronics',1,'COMPLETE','2025-01-25',1200),
(668,'Isha Mehta','ishamehta668@outlook.com','86010 51560','Ahmedabad','Pen Set - Stationery',2,'Returned','2025-04-08',360),
(669,'Rajat Gupta','rajatgupta669@gmail.com',NULL,'Chennai','Keyboard - Electronics',NULL,'Returned','2025-08-23',NULL),
(670,'Pooja Patel',' poojapatel670@example.com ','8110742781','Chennai','Keyboard - Electronics',1,'Pending','2025-04-02',1800),
(671,'Meera Singh','meerasingh671@OUTLOOK.COM','7774010584','Delhi','Smartphone - Electronics',2,'Pending','2025-02-06',84000),
(672,'Karan Mehta','karanmehta672@','8954347827','Hyderabad','Table Lamp - Home',5,'Pending','2025-07-13',8000),
(673,'Aarav Mehta','aaravmehta673 @ example.com','+91-90932-39371','Hyderabad','Headphones - Electronics',NULL,'shipped','2025-11-23',NULL),
(674,'Aarav Rao',NULL,'(793) 964-8421','Chennai','Table Lamp - Home',1,'Pending','2025-09-18',1600),
(675,'  rohan singh  ','rohansingh675@example.com','+91 8216747224',NULL,'Laptop - Electronics',2,'pending','2025-08-13',130000),
(676,'KAVYA REDDY','kavyareddy676@example.com','67150 54503','Pune','Desk - Furniture',1,'shipped','2025-03-15',12000),
(677,'Karan Sharma','karansharma677@gmail.com',NULL,'Ahmedabad','Coffee Mug - Home',NULL,'COMPLETE','2025-07-14',NULL),
(678,'Arjun Joshi','arjunjoshi678@gmail.com','6768277634','Chennai','Pen Set - Stationery',2,'Shipped','2025-02-09',360),
(679,'Arjun Patel','arjunpatel679@gmail.com','6391663395','Bangalore','Smartphone - Electronics',5,'return','2025-06-03',210000),
(680,'Suresh Verma',' sureshverma680@yahoo.com ','7626412328','Kolkata','Headphones - Electronics',1,'COMPLETE','2025-06-19',3200),
(681,'Rahul Patel','rahulpatel681@YAHOO.COM','+91-67682-26906','Bengaluru','Headphones - Electronics',2,'pending','2025-12-25',6400),
(682,'Karan Reddy','karanreddy682@','(650) 489-0477','Mumbai','Office Chair - Furniture',1,'Returned','2025-05-01',8500),
(683,'Karan Joshi','karanjoshi683 @ example.com','+91 8334319685','Bengaluru','Pen Set - Stationery',5,'Pending','2025-04-19',900),
(684,'  divya joshi  ',NULL,'78978 40239','Bangalore','Pen Set - Stationery',1,'Pending','2025-09-09',180),
(685,'ISHA RAO','isharao685@yahoo.com',NULL,'Mumbai','Keyboard - Electronics',1,'return','2025-06-02',1800),
(686,'Rahul Singh','rahulsingh686@outlook.com','7422111278','Bangalore','Laptop - Electronics',1,'cancelled','2025-03-06',65000),
(687,'Kavya Mehta','kavyamehta687@yahoo.com','7955661068','Ahmedabad','Monitor - Electronics',1,'completed','2025-05-11',14500),
(688,'Pooja Verma','poojaverma688@gmail.com','9257483542','Pune','Table Lamp - Home',NULL,'completed','2025-05-16',NULL),
(689,'Rahul Sharma','rahulsharma689@outlook.com','+91-74139-39856','Kolkata','Headphones - Electronics',NULL,NULL,'2025-12-07',NULL),
(690,'Isha Singh',' ishasingh690@gmail.com ','(845) 400-2884',NULL,'Notebook - Stationery',1,'Shipped','2025-12-23',250),
(691,'Isha Reddy','ishareddy691@EXAMPLE.COM','+91 8614967674','Hyderabad','Desk - Furniture',NULL,'Returned','2025-10-12',NULL),
(692,'Rahul Mehta','rahulmehta692@','82321 19411',NULL,'Backpack - Accessories',5,'COMPLETE','2025-10-08',9000),
(693,'  kavya kumar  ','kavyakumar693 @ gmail.com',NULL,'Bengaluru','Backpack - Accessories',1,'Pending','2025-10-14',1800),
(694,'MEERA SINGH',NULL,'7501735492','Kolkata','USB Cable - Electronics',2,'Completed','2025-11-07',1000),
(695,'Kavya Reddy','kavyareddy695@gmail.com','7321873046','New Delhi','Notebook - Stationery',NULL,'Cancelled','2025-01-04',NULL),
(696,'Arjun Gupta','arjungupta696@example.com','9111259884','Ahmedabad','Pen Set - Stationery',1,'COMPLETE','2025-04-11',180),
(697,'Arjun Joshi','arjunjoshi697@example.com','+91-94241-81518','Bengaluru','Water Bottle - Lifestyle',1,'Shipped','2025-03-21',700),
(698,'Karan Rao','karanrao698@outlook.com','(798) 629-3827','Pune','Coffee Mug - Home',1,'shipped','2025-05-19',450),
(699,'Arjun Rao','arjunrao699@gmail.com','+91 6894480510','Ahmedabad','Water Bottle - Lifestyle',3,'Cancelled','2025-02-05',2100),
(700,'Amit Singh',' amitsingh700@outlook.com ','76116 46876',NULL,'Notebook - Stationery',1,'Returned','2025-10-13',250);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(701,'Sneha Mehta','snehamehta701@GMAIL.COM',NULL,'New Delhi','Smartphone - Electronics',3,'Completed','2025-05-14',126000),
(702,'  priya joshi  ','priyajoshi702@','7595939306','Chennai','Table Lamp - Home',2,'Pending','2025-09-10',3200),
(703,'SNEHA SHARMA','snehasharma703 @ outlook.com','9371308737','Bengaluru','USB Cable - Electronics',0,'Completed','2025-08-17',0),
(704,'Rajat Joshi',NULL,'6816952955','Hyderabad','Coffee Mug - Home',5,'shipped','2025-05-25',2250),
(705,'Arjun Patel','arjunpatel705@gmail.com','+91-95310-58020','Kolkata','Water Bottle - Lifestyle',1,'Pending','2025-12-02',700),
(706,'Karan Verma','karanverma706@gmail.com','(601) 765-1775','New Delhi','Coffee Mug - Home',1,'return','2025-10-28',450),
(707,'Priya Gupta','priyagupta707@example.com','+91 9819024279','Bengaluru','Wireless Mouse - Electronics',NULL,'return','2025-12-10',NULL),
(708,'Rajat Mehta','rajatmehta708@outlook.com','87438 43492','Delhi','Monitor - Electronics',2,'Pending','2025-05-09',29000),
(709,'Nisha Gupta','nishagupta709@example.com',NULL,'Bangalore','Desk - Furniture',1,'COMPLETE','2025-05-04',12000),
(710,'Rajat Mehta',' rajatmehta710@gmail.com ','6887243074','Kolkata','Monitor - Electronics',NULL,'Cancelled','2025-05-05',NULL),
(711,'  kavya mehta  ','kavyamehta711@YAHOO.COM','6735620429','Bangalore','Desk - Furniture',3,'shipped','2025-08-02',36000),
(712,'RAHUL SINGH','rahulsingh712@','9879611333',NULL,'Laptop - Electronics',1,'cancelled','2025-01-03',65000),
(713,'Meera Verma','meeraverma713 @ yahoo.com','+91-90265-67207','Ahmedabad','Coffee Mug - Home',5,'Returned','2025-06-10',2250),
(714,'Arjun Kumar',NULL,'(996) 332-7064','Chennai','Pen Set - Stationery',1,'completed','2025-12-15',180),
(715,'Ananya Joshi','ananyajoshi715@outlook.com','+91 8939810510',NULL,'Smartphone - Electronics',5,'Shipped','2025-04-08',210000),
(716,'Rahul Mehta','rahulmehta716@outlook.com','99207 10774','Hyderabad','Headphones - Electronics',1,'return','2025-06-26',3200),
(717,'Arjun Joshi','arjunjoshi717@example.com',NULL,'Bangalore','Backpack - Accessories',1,'Cancelled','2025-08-15',1800),
(718,'Sneha Reddy','snehareddy718@outlook.com','8596051033','Ahmedabad','Keyboard - Electronics',NULL,'completed','2025-07-27',NULL),
(719,'Ananya Gupta','ananyagupta719@gmail.com','9403464975','New Delhi','Notebook - Stationery',5,'cancelled','2025-10-14',1250),
(720,'  neha mehta  ',' nehamehta720@yahoo.com ','8353423112','Mumbai','Backpack - Accessories',4,'completed','2025-06-07',7200),
(721,'MANISH VERMA','manishverma721@EXAMPLE.COM','+91-84361-53527','Hyderabad','Notebook - Stationery',2,'COMPLETE','2025-11-22',500),
(722,'Priya Mehta','priyamehta722@','(649) 101-2945','Ahmedabad','Pen Set - Stationery',5,'Cancelled','2025-09-04',900),
(723,'Karan Patel','karanpatel723 @ outlook.com','+91 7742870683','Bangalore','Pen Set - Stationery',1,'return','2025-10-25',180),
(724,'Rohan Gupta',NULL,'87702 07149',NULL,'Laptop - Electronics',1,'Pending','2025-03-19',65000),
(725,'Rajat Patel','rajatpatel725@yahoo.com',NULL,'Kolkata','Desk - Furniture',4,'Returned','2025-10-15',48000),
(726,'Vikram Kumar','vikramkumar726@outlook.com','7287353440','Ahmedabad','USB Cable - Electronics',2,'cancelled','2025-12-12',1000),
(727,'Priya Mehta','priyamehta727@gmail.com','8626332786','Kolkata','Headphones - Electronics',1,'pending','2025-01-12',3200),
(728,'Nisha Singh','nishasingh728@gmail.com','9020882958','Kolkata','Table Lamp - Home',3,'completed','2025-05-28',4800),
(729,'  rajat kumar  ','rajatkumar729@example.com','+91-90160-20016','Ahmedabad','Headphones - Electronics',3,'cancelled','2025-07-13',9600),
(730,'MEERA RAO',' meerarao730@yahoo.com ','(884) 536-2401','Mumbai','Backpack - Accessories',1,'Pending','2025-09-13',1800),
(731,'Pooja Verma','poojaverma731@YAHOO.COM','+91 7238972936',NULL,'Keyboard - Electronics',1,'Completed','2025-02-21',1800),
(732,'Rajat Patel','rajatpatel732@','88257 73649','Pune','Keyboard - Electronics',1,'COMPLETE','2025-11-26',1800),
(733,'Meera Joshi','meerajoshi733 @ example.com',NULL,'Mumbai','Backpack - Accessories',NULL,'cancelled','2025-09-27',NULL),
(734,'Karan Verma',NULL,'6969549862','Mumbai','Headphones - Electronics',1,'Returned','2025-08-28',3200),
(735,'Neha Rao','neharao735@outlook.com','7764534958','Kolkata','Pen Set - Stationery',3,'Completed','2025-01-19',540),
(736,'Divya Gupta','divyagupta736@gmail.com','8492235444','Chennai','Smartphone - Electronics',1,'COMPLETE','2025-12-24',42000),
(737,'Suresh Reddy','sureshreddy737@example.com','+91-82202-81423','Bangalore','Notebook - Stationery',1,'Pending','2025-08-21',250),
(738,'  priya rao  ','priyarao738@outlook.com','(863) 298-2968','Bengaluru','Coffee Mug - Home',3,'shipped','2025-01-16',1350),
(739,'KARAN RAO','karanrao739@example.com','+91 8465162177','Hyderabad','Headphones - Electronics',3,'pending','2025-05-06',9600),
(740,'Aarav Mehta',' aaravmehta740@outlook.com ','91223 19712','Ahmedabad','Desk - Furniture',0,'Completed','2025-08-19',0),
(741,'Sneha Mehta','snehamehta741@GMAIL.COM',NULL,'New Delhi','USB Cable - Electronics',1,'pending','2025-08-03',500),
(742,'Rahul Rao','rahulrao742@','9656929513','New Delhi','Desk - Furniture',1,NULL,'2025-05-09',12000),
(743,'Amit Singh','amitsingh743 @ gmail.com','8593393772','Mumbai','Coffee Mug - Home',1,'return','2025-08-12',450),
(744,'Sneha Reddy',NULL,'8082709180','Mumbai','USB Cable - Electronics',NULL,'Completed','2025-06-03',NULL),
(745,'Rahul Mehta','rahulmehta745@yahoo.com','+91-95975-25665','Chennai','USB Cable - Electronics',4,'cancelled','2025-04-22',2000),
(746,'Karan Patel','karanpatel746@yahoo.com','(848) 144-9107','Hyderabad','Laptop - Electronics',2,'completed','2025-01-06',130000),
(747,'  karan verma  ','karanverma747@example.com','+91 7294361972','Chennai','Smartphone - Electronics',NULL,'Pending','2025-07-22',NULL),
(748,'ROHAN JOSHI','rohanjoshi748@outlook.com','66234 13787','Kolkata','Table Lamp - Home',4,'Completed','2025-05-26',6400),
(749,'Karan Verma','karanverma749@outlook.com',NULL,NULL,'Laptop - Electronics',1,'shipped','2025-11-12',65000),
(750,'Meera Mehta',' meeramehta750@outlook.com ','7438674062','New Delhi','Desk - Furniture',1,'pending','2025-11-19',12000),
(751,'Rohan Joshi','rohanjoshi751@YAHOO.COM','9153852268',NULL,'Pen Set - Stationery',2,'shipped','2025-06-22',360),
(752,'Sneha Gupta','snehagupta752@','8889662004','Bengaluru','Table Lamp - Home',1,'Completed','2025-07-04',1600),
(753,'Suresh Sharma','sureshsharma753 @ example.com','+91-75097-51531','Delhi','Smartphone - Electronics',2,'pending','2025-04-02',84000),
(754,'Rajat Mehta',NULL,'(624) 430-5931','Ahmedabad','Water Bottle - Lifestyle',2,'Returned','2025-11-04',1400),
(755,'Ananya Sharma','ananyasharma755@yahoo.com','+91 7614729199',NULL,'USB Cable - Electronics',1,'completed','2025-12-06',500),
(756,'  amit reddy  ','amitreddy756@example.com','88367 30724','Bangalore','Water Bottle - Lifestyle',5,'pending','2025-07-23',3500),
(757,'ARJUN REDDY','arjunreddy757@yahoo.com',NULL,'Bangalore','Desk - Furniture',1,'cancelled','2025-07-11',12000),
(758,'Aarav Reddy','aaravreddy758@outlook.com','6764201331','Chennai','Wireless Mouse - Electronics',5,'Pending','2025-10-13',6000),
(759,'Sneha Joshi','snehajoshi759@gmail.com','6617928099','Kolkata','USB Cable - Electronics',4,'Pending','2025-10-21',2000),
(760,'Ananya Joshi',' ananyajoshi760@outlook.com ','6443614797','Bengaluru','Wireless Mouse - Electronics',1,'Returned','2025-12-09',1200),
(761,'Karan Singh','karansingh761@EXAMPLE.COM','+91-66393-24232',NULL,'Water Bottle - Lifestyle',1,'Completed','2025-11-13',700),
(762,'Amit Patel','amitpatel762@','(988) 530-2779','Pune','Pen Set - Stationery',1,'shipped','2025-12-25',180),
(763,'Divya Joshi','divyajoshi763 @ example.com','+91 7734792059','Bangalore','Notebook - Stationery',2,'Completed','2025-07-23',500),
(764,'Divya Sharma',NULL,'74321 12664',NULL,'Desk - Furniture',4,'Completed','2025-11-21',48000),
(765,'  priya gupta  ','priyagupta765@outlook.com',NULL,'Chennai','USB Cable - Electronics',2,'return','2025-04-06',1000),
(766,'NISHA SINGH','nishasingh766@example.com','8837831301','Delhi','Desk - Furniture',4,'completed','2025-11-23',48000),
(767,'Pooja Joshi','poojajoshi767@gmail.com','9801965834',NULL,'Backpack - Accessories',2,'COMPLETE','2025-01-07',3600),
(768,'Rajat Mehta','rajatmehta768@yahoo.com','8101237808','Pune','Wireless Mouse - Electronics',NULL,'return','2025-05-16',NULL),
(769,'Nisha Joshi','nishajoshi769@gmail.com','+91-61590-97113','Hyderabad','Laptop - Electronics',3,'Completed','2025-07-04',195000),
(770,'Vikram Rao',' vikramrao770@example.com ','(891) 232-2067','Kolkata','Keyboard - Electronics',2,'completed','2025-01-24',3600),
(771,'Rahul Joshi','rahuljoshi771@GMAIL.COM','+91 8023872904','Ahmedabad','Laptop - Electronics',2,'return','2025-03-01',130000),
(772,'Sneha Singh','snehasingh772@','95250 48115','Bangalore','Backpack - Accessories',1,'Returned','2025-02-27',1800),
(773,'Ananya Sharma','ananyasharma773 @ example.com',NULL,'Ahmedabad','Office Chair - Furniture',1,'Pending','2025-07-11',8500),
(774,'  rohan gupta  ',NULL,'8938137245','Ahmedabad','Notebook - Stationery',1,'Cancelled','2025-04-25',250),
(775,'AARAV MEHTA','aaravmehta775@yahoo.com','7440977557','Bangalore','Wireless Mouse - Electronics',2,'COMPLETE','2025-07-06',2400),
(776,'Pooja Rao','poojarao776@yahoo.com','7884035554','Delhi','Coffee Mug - Home',1,'COMPLETE','2025-02-26',450),
(777,'Isha Verma','ishaverma777@yahoo.com','+91-60671-31712','Chennai','Wireless Mouse - Electronics',0,'Completed','2025-03-03',0),
(778,'Manish Reddy','manishreddy778@example.com','(897) 857-4975','Chennai','Smartphone - Electronics',1,'Pending','2025-03-21',42000),
(779,'Amit Rao','amitrao779@example.com','+91 7769661076','Delhi','Keyboard - Electronics',1,'Returned','2025-03-23',1800),
(780,'Divya Mehta',' divyamehta780@gmail.com ','86937 67622','New Delhi','Monitor - Electronics',4,'Completed','2025-09-08',58000),
(781,'Vikram Sharma','vikramsharma781@GMAIL.COM',NULL,'Hyderabad','Table Lamp - Home',NULL,'shipped','2025-04-15',NULL),
(782,'Vikram Reddy','vikramreddy782@','6832016743','Bangalore','USB Cable - Electronics',1,'return','2025-08-16',500),
(783,'  sneha patel  ','snehapatel783 @ gmail.com','6232046822',NULL,'Monitor - Electronics',2,'Pending','2025-07-09',29000),
(784,'ARJUN MEHTA',NULL,'6186047172','Bangalore','Smartphone - Electronics',1,'shipped','2025-03-06',42000),
(785,'Rajat Joshi','rajatjoshi785@gmail.com','+91-63043-39206','Delhi','Smartphone - Electronics',5,'Returned','2025-10-11',210000),
(786,'Meera Kumar','meerakumar786@outlook.com','(698) 811-4061','Bangalore','Monitor - Electronics',2,'completed','2025-04-24',29000),
(787,'Meera Kumar','meerakumar787@example.com','+91 9828384170','Delhi','Wireless Mouse - Electronics',5,'Returned','2025-08-02',6000),
(788,'Meera Patel','meerapatel788@yahoo.com','99852 44812','Ahmedabad','Backpack - Accessories',1,'cancelled','2025-06-05',1800),
(789,'Karan Kumar','karankumar789@outlook.com',NULL,'Delhi','Monitor - Electronics',1,'Completed','2025-12-19',14500),
(790,'Aarav Reddy',' aaravreddy790@yahoo.com ','6477210657','Chennai','Backpack - Accessories',4,'COMPLETE','2025-06-08',7200),
(791,'Kavya Mehta','kavyamehta791@YAHOO.COM','9391078386',NULL,'Pen Set - Stationery',1,'Returned','2025-09-28',180),
(792,'  neha sharma  ','nehasharma792@','9680674295','Kolkata','Backpack - Accessories',2,'Returned','2025-08-27',3600),
(793,'KARAN REDDY','karanreddy793 @ gmail.com','+91-91354-02392','Pune','Smartphone - Electronics',2,'Pending','2025-06-14',84000),
(794,'Manish Kumar',NULL,'(992) 454-6630','Ahmedabad','Coffee Mug - Home',1,'cancelled','2025-01-02',450),
(795,'Divya Rao','divyarao795@gmail.com','+91 7828357471','Kolkata','Headphones - Electronics',5,NULL,'2025-08-16',16000),
(796,'Neha Sharma','nehasharma796@gmail.com','89770 98835','Pune','Office Chair - Furniture',1,'Cancelled','2025-05-08',8500),
(797,'Priya Singh','priyasingh797@example.com',NULL,'New Delhi','Keyboard - Electronics',5,'Returned','2025-12-19',9000),
(798,'Rajat Joshi','rajatjoshi798@example.com','9315006135','Mumbai','Table Lamp - Home',4,'COMPLETE','2025-06-21',6400),
(799,'Karan Singh','karansingh799@gmail.com','7653043870','Hyderabad','Notebook - Stationery',1,'pending','2025-07-25',250),
(800,'Amit Mehta',' amitmehta800@yahoo.com ','9383110711',NULL,'Wireless Mouse - Electronics',3,'Completed','2025-09-22',3600);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(801,'  pooja singh  ','poojasingh801@GMAIL.COM','+91-76447-79176','Hyderabad','Backpack - Accessories',1,'Cancelled','2025-06-06',1800),
(802,'NISHA SHARMA','nishasharma802@','(659) 444-8391','Hyderabad','Office Chair - Furniture',NULL,'completed','2025-11-16',NULL),
(803,'Manish Kumar','manishkumar803 @ yahoo.com','+91 7376381611','Hyderabad','Coffee Mug - Home',2,'shipped','2025-11-14',900),
(804,'Amit Singh',NULL,'76012 22993','Hyderabad','Backpack - Accessories',5,'shipped','2025-09-27',9000),
(805,'Ananya Joshi','ananyajoshi805@outlook.com',NULL,'Ahmedabad','Monitor - Electronics',1,'Pending','2025-08-03',14500),
(806,'Priya Verma','priyaverma806@yahoo.com','7238551232','Bangalore','Wireless Mouse - Electronics',1,'pending','2025-02-23',1200),
(807,'Rahul Joshi','rahuljoshi807@yahoo.com','9758066922','Delhi','Notebook - Stationery',1,'pending','2025-07-22',250),
(808,'Nisha Patel','nishapatel808@example.com','7489066210','Pune','Backpack - Accessories',1,'pending','2025-04-03',1800),
(809,'Rajat Kumar','rajatkumar809@outlook.com','+91-77682-02514','Ahmedabad','Monitor - Electronics',3,'Shipped','2025-10-22',43500),
(810,'  suresh rao  ',' sureshrao810@example.com ','(796) 712-5474','New Delhi','Pen Set - Stationery',1,'pending','2025-03-26',180),
(811,'AMIT KUMAR','amitkumar811@EXAMPLE.COM','+91 7597308268','New Delhi','USB Cable - Electronics',1,'COMPLETE','2025-06-10',500),
(812,'Karan Patel','karanpatel812@','90572 10014','Kolkata','Desk - Furniture',1,'COMPLETE','2025-12-23',12000),
(813,'Rahul Patel','rahulpatel813 @ yahoo.com',NULL,'Bengaluru','Monitor - Electronics',1,'Shipped','2025-05-12',14500),
(814,'Sneha Kumar',NULL,'8858529583','Hyderabad','Monitor - Electronics',0,'Completed','2025-08-18',0),
(815,'Sneha Rao','sneharao815@outlook.com','6521795675','Bengaluru','Headphones - Electronics',5,'COMPLETE','2025-08-11',16000),
(816,'Rahul Singh','rahulsingh816@outlook.com','8779891609','New Delhi','Backpack - Accessories',2,'Returned','2025-11-05',3600),
(817,'Manish Joshi','manishjoshi817@outlook.com','+91-89598-63754','Bangalore','Smartphone - Electronics',5,'Completed','2025-03-22',210000),
(818,'Nisha Sharma','nishasharma818@outlook.com','(610) 649-6266','Pune','Pen Set - Stationery',2,'Shipped','2025-06-03',360),
(819,'  arjun singh  ','arjunsingh819@yahoo.com','+91 8505818950','Kolkata','Office Chair - Furniture',2,'Pending','2025-01-03',17000),
(820,'NISHA JOSHI',' nishajoshi820@gmail.com ','81981 10658','Pune','Office Chair - Furniture',5,'Cancelled','2025-10-20',42500),
(821,'Suresh Singh','sureshsingh821@OUTLOOK.COM',NULL,'Mumbai','Smartphone - Electronics',4,'Cancelled','2025-07-12',168000),
(822,'Rajat Reddy','rajatreddy822@','7509058380','New Delhi','Backpack - Accessories',NULL,'completed','2025-04-24',NULL),
(823,'Karan Verma','karanverma823 @ example.com','7239673672','Mumbai','USB Cable - Electronics',4,'cancelled','2025-03-27',2000),
(824,'Manish Mehta',NULL,'6616926023','Delhi','Desk - Furniture',5,'shipped','2025-06-03',60000),
(825,'Manish Verma','manishverma825@gmail.com','+91-60284-27814','Pune','Water Bottle - Lifestyle',2,'cancelled','2025-03-18',1400),
(826,'Karan Mehta','karanmehta826@yahoo.com','(685) 580-4722','Mumbai','Table Lamp - Home',4,'pending','2025-09-16',6400),
(827,'Aarav Reddy','aaravreddy827@outlook.com','+91 8122145416','Kolkata','Smartphone - Electronics',5,'Pending','2025-01-26',210000),
(828,'  rajat patel  ','rajatpatel828@outlook.com','72892 17783',NULL,'Table Lamp - Home',5,'completed','2025-11-22',8000),
(829,'KAVYA VERMA','kavyaverma829@yahoo.com',NULL,NULL,'Office Chair - Furniture',1,'completed','2025-05-16',8500),
(830,'Priya Mehta',' priyamehta830@outlook.com ','8495658464','Chennai','Pen Set - Stationery',4,'pending','2025-11-22',720),
(831,'Divya Sharma','divyasharma831@OUTLOOK.COM','8201281828','Ahmedabad','Laptop - Electronics',2,'COMPLETE','2025-10-02',130000),
(832,'Rahul Gupta','rahulgupta832@','9772343920','Mumbai','Monitor - Electronics',1,'Completed','2025-05-12',14500),
(833,'Meera Gupta','meeragupta833 @ gmail.com','+91-72449-22910','New Delhi','Notebook - Stationery',1,'shipped','2025-04-25',250),
(834,'Sneha Sharma',NULL,'(833) 522-6700','Hyderabad','Table Lamp - Home',3,'return','2025-05-09',4800),
(835,'Pooja Sharma','poojasharma835@outlook.com','+91 9536110214','Mumbai','Laptop - Electronics',1,'shipped','2025-05-12',65000),
(836,'Divya Verma','divyaverma836@outlook.com','99552 67061','Mumbai','Wireless Mouse - Electronics',2,'COMPLETE','2025-09-08',2400),
(837,'  vikram rao  ','vikramrao837@gmail.com',NULL,'Chennai','Coffee Mug - Home',1,'completed','2025-03-01',450),
(838,'DIVYA GUPTA','divyagupta838@outlook.com','8968040186','Hyderabad','Keyboard - Electronics',5,'Returned','2025-09-25',9000),
(839,'Arjun Patel','arjunpatel839@outlook.com','6123521259','Bangalore','Office Chair - Furniture',1,'COMPLETE','2025-12-08',8500),
(840,'Kavya Patel',' kavyapatel840@yahoo.com ','6559283112','Bangalore','Headphones - Electronics',1,'completed','2025-01-25',3200),
(841,'Divya Verma','divyaverma841@GMAIL.COM','+91-68433-21095','Bangalore','Laptop - Electronics',NULL,'Returned','2025-01-16',NULL),
(842,'Ananya Reddy','ananyareddy842@','(628) 453-0257','New Delhi','Water Bottle - Lifestyle',1,'completed','2025-02-20',700),
(843,'Vikram Mehta','vikrammehta843 @ yahoo.com','+91 6793631899',NULL,'Monitor - Electronics',1,'completed','2025-03-28',14500),
(844,'Amit Mehta',NULL,'75127 01547','Mumbai','Table Lamp - Home',NULL,'Returned','2025-04-17',NULL),
(845,'Manish Sharma','manishsharma845@gmail.com',NULL,'Ahmedabad','USB Cable - Electronics',1,'shipped','2025-04-23',500),
(846,'  vikram reddy  ','vikramreddy846@yahoo.com','9872601458','Kolkata','Laptop - Electronics',1,'Pending','2025-09-28',65000),
(847,'DIVYA GUPTA','divyagupta847@yahoo.com','7888350356',NULL,'Wireless Mouse - Electronics',1,'Cancelled','2025-07-14',1200),
(848,'Vikram Rao','vikramrao848@yahoo.com','7750534060','Bangalore','USB Cable - Electronics',3,NULL,'2025-08-04',1500),
(849,'Suresh Patel','sureshpatel849@example.com','+91-92739-40533','Hyderabad','Smartphone - Electronics',2,'shipped','2025-12-02',84000),
(850,'Priya Gupta',' priyagupta850@example.com ','(649) 702-4805','Pune','Desk - Furniture',5,'Returned','2025-12-10',60000),
(851,'Karan Kumar','karankumar851@EXAMPLE.COM','+91 7248071617','Pune','Office Chair - Furniture',0,'Completed','2025-11-12',0),
(852,'Sneha Singh','snehasingh852@','88866 28103','Bangalore','Headphones - Electronics',5,'shipped','2025-11-22',16000),
(853,'Priya Sharma','priyasharma853 @ yahoo.com',NULL,'Pune','Smartphone - Electronics',1,'COMPLETE','2025-02-12',42000),
(854,'Vikram Gupta',NULL,'8555337302','Pune','Wireless Mouse - Electronics',2,'cancelled','2025-12-16',2400),
(855,'  amit mehta  ','amitmehta855@outlook.com','9248296389',NULL,'Headphones - Electronics',3,'Shipped','2025-11-20',9600),
(856,'ROHAN JOSHI','rohanjoshi856@outlook.com','6632966915','Chennai','Wireless Mouse - Electronics',1,'pending','2025-08-16',1200),
(857,'Neha Patel','nehapatel857@gmail.com','+91-64277-93293','Bengaluru','Table Lamp - Home',1,'Shipped','2025-11-01',1600),
(858,'Sneha Verma','snehaverma858@outlook.com','(665) 599-8939','New Delhi','Pen Set - Stationery',1,'completed','2025-11-25',180),
(859,'Suresh Joshi','sureshjoshi859@example.com','+91 6867290276','New Delhi','Water Bottle - Lifestyle',5,'Shipped','2025-09-09',3500),
(860,'Nisha Gupta',' nishagupta860@gmail.com ','92812 04295','Bengaluru','Headphones - Electronics',1,'cancelled','2025-08-11',3200),
(861,'Rohan Joshi','rohanjoshi861@EXAMPLE.COM',NULL,'Bengaluru','Keyboard - Electronics',NULL,'return','2025-05-23',NULL),
(862,'Sneha Joshi','snehajoshi862@','6577622607','New Delhi','Smartphone - Electronics',4,'Shipped','2025-02-19',168000),
(863,'Divya Rao','divyarao863 @ example.com','8044022431','Kolkata','Table Lamp - Home',1,'shipped','2025-01-13',1600),
(864,'  amit joshi  ',NULL,'8649735743',NULL,'Monitor - Electronics',2,'Cancelled','2025-01-01',29000),
(865,'MANISH SINGH','manishsingh865@yahoo.com','+91-95946-04802','Hyderabad','Monitor - Electronics',1,'return','2025-06-13',14500),
(866,'Ananya Verma','ananyaverma866@outlook.com','(753) 487-5624','Pune','Monitor - Electronics',1,'return','2025-04-08',14500),
(867,'Neha Reddy','nehareddy867@gmail.com','+91 9910091063','Bangalore','Table Lamp - Home',2,'completed','2025-06-06',3200),
(868,'Rajat Rao','rajatrao868@outlook.com','61605 35661','Chennai','Water Bottle - Lifestyle',4,'Returned','2025-09-14',2800),
(869,'Amit Singh','amitsingh869@example.com',NULL,'Bengaluru','Monitor - Electronics',4,'Returned','2025-07-11',58000),
(870,'Manish Sharma',' manishsharma870@example.com ','6429740169',NULL,'Office Chair - Furniture',3,'Shipped','2025-09-26',25500),
(871,'Arjun Patel','arjunpatel871@OUTLOOK.COM','7560508934','Pune','Office Chair - Furniture',5,'return','2025-02-27',42500),
(872,'Nisha Kumar','nishakumar872@','7138832493','Bengaluru','Desk - Furniture',4,'Pending','2025-10-24',48000),
(873,'  priya mehta  ','priyamehta873 @ gmail.com','+91-85420-39357','Hyderabad','Desk - Furniture',1,'Returned','2025-09-16',12000),
(874,'MEERA KUMAR',NULL,'(941) 729-8242','Bangalore','Water Bottle - Lifestyle',2,'shipped','2025-05-14',1400),
(875,'Nisha Gupta','nishagupta875@yahoo.com','+91 7779466167','Pune','Desk - Furniture',NULL,'Shipped','2025-11-25',NULL),
(876,'Nisha Patel','nishapatel876@gmail.com','86965 69154','Kolkata','Table Lamp - Home',1,'Returned','2025-08-07',1600),
(877,'Karan Reddy','karanreddy877@example.com',NULL,NULL,'Laptop - Electronics',NULL,'Pending','2025-06-15',NULL),
(878,'Rahul Kumar','rahulkumar878@yahoo.com','9205907540',NULL,'USB Cable - Electronics',2,'cancelled','2025-07-11',1000),
(879,'Priya Kumar','priyakumar879@example.com','7146476046','New Delhi','Water Bottle - Lifestyle',1,'pending','2025-11-20',700),
(880,'Neha Verma',' nehaverma880@yahoo.com ','6487730383','Mumbai','Office Chair - Furniture',1,'Pending','2025-05-15',8500),
(881,'Divya Rao','divyarao881@EXAMPLE.COM','+91-78125-58340',NULL,'Coffee Mug - Home',1,'Pending','2025-03-09',450),
(882,'  rahul singh  ','rahulsingh882@','(939) 160-6121','New Delhi','Water Bottle - Lifestyle',NULL,'COMPLETE','2025-11-28',NULL),
(883,'AARAV JOSHI','aaravjoshi883 @ gmail.com','+91 6237628826','Bangalore','Monitor - Electronics',2,'completed','2025-07-12',29000),
(884,'Priya Verma',NULL,'70137 89043','Bangalore','Pen Set - Stationery',NULL,'completed','2025-09-22',NULL),
(885,'Manish Rao','manishrao885@outlook.com',NULL,'Bangalore','Office Chair - Furniture',1,'Cancelled','2025-06-27',8500),
(886,'Manish Verma','manishverma886@yahoo.com','7816208531','Delhi','Keyboard - Electronics',1,'COMPLETE','2025-04-09',1800),
(887,'Karan Verma','karanverma887@outlook.com','9706126985','Ahmedabad','Laptop - Electronics',5,'shipped','2025-06-23',325000),
(888,'Ananya Gupta','ananyagupta888@example.com','8039482919',NULL,'Office Chair - Furniture',0,'Completed','2025-06-16',0),
(889,'Pooja Reddy','poojareddy889@gmail.com','+91-87719-61511','Ahmedabad','Laptop - Electronics',1,'return','2025-04-09',65000),
(890,'Nisha Verma',' nishaverma890@outlook.com ','(874) 426-5294','Hyderabad','Coffee Mug - Home',1,'shipped','2025-04-28',450),
(891,'  karan verma  ','karanverma891@GMAIL.COM','+91 9907514416','Pune','Coffee Mug - Home',2,'pending','2025-02-27',900),
(892,'NEHA REDDY','nehareddy892@','96911 66761','Mumbai','Coffee Mug - Home',5,'return','2025-06-26',2250),
(893,'Meera Singh','meerasingh893 @ outlook.com',NULL,'Bangalore','Table Lamp - Home',5,'Shipped','2025-12-14',8000),
(894,'Arjun Verma',NULL,'9540774757','Mumbai','Smartphone - Electronics',2,'shipped','2025-02-12',84000),
(895,'Meera Mehta','meeramehta895@outlook.com','7946744390','Bengaluru','USB Cable - Electronics',1,'return','2025-11-06',500),
(896,'Karan Patel','karanpatel896@gmail.com','7720829540','Delhi','Water Bottle - Lifestyle',2,'Cancelled','2025-10-03',1400),
(897,'Ananya Patel','ananyapatel897@yahoo.com','+91-82177-74604',NULL,'USB Cable - Electronics',1,'Returned','2025-11-14',500),
(898,'Arjun Joshi','arjunjoshi898@example.com','(975) 167-9013','Mumbai','Desk - Furniture',1,'return','2025-10-27',12000),
(899,'Arjun Reddy','arjunreddy899@yahoo.com','+91 6362490731','Pune','Monitor - Electronics',1,'cancelled','2025-07-27',14500),
(900,'  manish kumar  ',' manishkumar900@gmail.com ','60986 55791','Kolkata','Water Bottle - Lifestyle',2,'completed','2025-08-07',1400);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(901,'AMIT PATEL','amitpatel901@GMAIL.COM',NULL,'Ahmedabad','Headphones - Electronics',2,NULL,'2025-02-12',6400),
(902,'Sneha Mehta','snehamehta902@','6060623056','Kolkata','Headphones - Electronics',5,'return','2025-08-04',16000),
(903,'Neha Kumar','nehakumar903 @ yahoo.com','9701990020','New Delhi','Desk - Furniture',5,'cancelled','2025-03-14',60000),
(904,'Vikram Mehta',NULL,'9539434845','New Delhi','Smartphone - Electronics',2,'cancelled','2025-03-14',84000),
(905,'Rahul Singh','rahulsingh905@outlook.com','+91-71244-20145','Delhi','Pen Set - Stationery',5,'Pending','2025-06-19',900),
(906,'Karan Sharma','karansharma906@gmail.com','(801) 383-1172','Mumbai','Table Lamp - Home',3,'cancelled','2025-11-07',4800),
(907,'Rohan Verma','rohanverma907@outlook.com','+91 6313771499','Bangalore','Notebook - Stationery',1,'Completed','2025-06-08',250),
(908,'Divya Gupta','divyagupta908@gmail.com','60230 25260','New Delhi','Notebook - Stationery',4,'pending','2025-07-22',1000),
(909,'  pooja patel  ','poojapatel909@gmail.com',NULL,'Mumbai','Desk - Furniture',1,'shipped','2025-08-11',12000),
(910,'KARAN PATEL',' karanpatel910@gmail.com ','7362867804','Kolkata','Headphones - Electronics',1,'pending','2025-02-11',3200),
(911,'Aarav Patel','aaravpatel911@EXAMPLE.COM','9743835172','New Delhi','Smartphone - Electronics',3,'cancelled','2025-05-09',126000),
(912,'Isha Reddy','ishareddy912@','7871640952','Mumbai','Monitor - Electronics',5,'COMPLETE','2025-09-28',72500),
(913,'Karan Singh','karansingh913 @ yahoo.com','+91-66383-21534','Bengaluru','Office Chair - Furniture',1,'Completed','2025-08-09',8500),
(914,'Sneha Joshi',NULL,'(649) 831-9477','Chennai','Laptop - Electronics',5,'Cancelled','2025-12-18',325000),
(915,'Divya Joshi','divyajoshi915@example.com','+91 6483144641','Mumbai','Wireless Mouse - Electronics',3,'completed','2025-04-28',3600),
(916,'Kavya Patel','kavyapatel916@yahoo.com','92209 53403','Kolkata','Table Lamp - Home',2,'Returned','2025-11-19',3200),
(917,'Vikram Mehta','vikrammehta917@gmail.com',NULL,'Ahmedabad','Keyboard - Electronics',4,'completed','2025-04-25',7200),
(918,'  divya sharma  ','divyasharma918@outlook.com','6111506668','New Delhi','Water Bottle - Lifestyle',1,'cancelled','2025-06-19',700),
(919,'ANANYA GUPTA','ananyagupta919@yahoo.com','6124015059','Bangalore','Backpack - Accessories',5,'Shipped','2025-11-09',9000),
(920,'Isha Singh',' ishasingh920@outlook.com ','6188321417',NULL,'Pen Set - Stationery',5,'Cancelled','2025-12-24',900),
(921,'Manish Patel','manishpatel921@YAHOO.COM','+91-97077-54422','Bengaluru','USB Cable - Electronics',2,'Cancelled','2025-01-24',1000),
(922,'Priya Rao','priyarao922@','(639) 750-3555','Pune','Desk - Furniture',1,'Pending','2025-07-03',12000),
(923,'Rajat Kumar','rajatkumar923 @ yahoo.com','+91 7668607252','Pune','Desk - Furniture',1,'completed','2025-05-16',12000),
(924,'Meera Reddy',NULL,'75420 83341',NULL,'Wireless Mouse - Electronics',3,'shipped','2025-04-16',3600),
(925,'Karan Verma','karanverma925@example.com',NULL,'Ahmedabad','Pen Set - Stationery',0,'Completed','2025-07-26',0),
(926,'Pooja Mehta','poojamehta926@yahoo.com','7864470731',NULL,'Headphones - Electronics',1,'Completed','2025-09-11',3200),
(927,'  karan kumar  ','karankumar927@yahoo.com','9997186975','Chennai','Notebook - Stationery',NULL,'completed','2025-05-15',NULL),
(928,'MEERA SHARMA','meerasharma928@example.com','7290179231','Mumbai','Keyboard - Electronics',2,'Pending','2025-09-14',3600),
(929,'Kavya Mehta','kavyamehta929@gmail.com','+91-83665-02646','Bangalore','Coffee Mug - Home',1,'shipped','2025-02-17',450),
(930,'Meera Verma',' meeraverma930@gmail.com ','(799) 568-4432',NULL,'Smartphone - Electronics',2,'Cancelled','2025-05-19',84000),
(931,'Priya Rao','priyarao931@GMAIL.COM','+91 6489349186',NULL,'Backpack - Accessories',1,'COMPLETE','2025-07-02',1800),
(932,'Priya Verma','priyaverma932@','73483 89334','Ahmedabad','Smartphone - Electronics',5,'return','2025-08-20',210000),
(933,'Amit Gupta','amitgupta933 @ yahoo.com',NULL,'Mumbai','Wireless Mouse - Electronics',2,'return','2025-02-14',2400),
(934,'Nisha Singh',NULL,'7696227959','Bangalore','Laptop - Electronics',1,'return','2025-08-15',65000),
(935,'Rohan Mehta','rohanmehta935@example.com','7300516022','Ahmedabad','Table Lamp - Home',3,'return','2025-12-22',4800),
(936,'  rohan reddy  ','rohanreddy936@gmail.com','6537255294','Mumbai','Laptop - Electronics',2,'completed','2025-01-23',130000),
(937,'VIKRAM SINGH','vikramsingh937@yahoo.com','+91-80663-82608',NULL,'Keyboard - Electronics',2,'cancelled','2025-11-28',3600),
(938,'Nisha Kumar','nishakumar938@gmail.com','(729) 243-2406','Chennai','Keyboard - Electronics',5,'cancelled','2025-01-04',9000),
(939,'Sneha Patel','snehapatel939@example.com','+91 8083260305','Chennai','Laptop - Electronics',5,'Returned','2025-04-07',325000),
(940,'Kavya Mehta',' kavyamehta940@example.com ','62187 09107','Hyderabad','Laptop - Electronics',1,'return','2025-12-14',65000),
(941,'Meera Joshi','meerajoshi941@OUTLOOK.COM',NULL,'Chennai','Headphones - Electronics',5,'shipped','2025-10-24',16000),
(942,'Isha Joshi','ishajoshi942@','9067853612','Bengaluru','Notebook - Stationery',1,'cancelled','2025-10-11',250),
(943,'Nisha Sharma','nishasharma943 @ outlook.com','9834878346',NULL,'Headphones - Electronics',5,'completed','2025-08-20',16000),
(944,'Pooja Joshi',NULL,'6089365072','Mumbai','Desk - Furniture',2,'Shipped','2025-06-15',24000),
(945,'  neha rao  ','neharao945@yahoo.com','+91-85239-74937',NULL,'Monitor - Electronics',5,'COMPLETE','2025-05-24',72500),
(946,'ROHAN VERMA','rohanverma946@outlook.com','(941) 867-6546','Chennai','USB Cable - Electronics',1,'Returned','2025-04-10',500),
(947,'Priya Joshi','priyajoshi947@yahoo.com','+91 6744279636','Delhi','Keyboard - Electronics',5,'completed','2025-07-16',9000),
(948,'Kavya Kumar','kavyakumar948@yahoo.com','83915 68856','Bengaluru','Laptop - Electronics',3,'pending','2025-06-22',195000),
(949,'Sneha Patel','snehapatel949@gmail.com',NULL,'Bangalore','Monitor - Electronics',4,'completed','2025-10-08',58000),
(950,'Ananya Rao',' ananyarao950@yahoo.com ','8088923070','New Delhi','Monitor - Electronics',3,'Completed','2025-09-09',43500),
(951,'Rahul Rao','rahulrao951@GMAIL.COM','9033986022','Bengaluru','Coffee Mug - Home',5,'Shipped','2025-02-04',2250),
(952,'Isha Mehta','ishamehta952@','9537378995','Kolkata','Laptop - Electronics',NULL,'completed','2025-03-21',NULL),
(953,'Ananya Kumar','ananyakumar953 @ outlook.com','+91-66744-49642','New Delhi','Smartphone - Electronics',5,'shipped','2025-08-24',210000),
(954,'  ananya patel  ',NULL,'(743) 712-8353','Mumbai','Wireless Mouse - Electronics',2,NULL,'2025-07-25',2400),
(955,'RAJAT KUMAR','rajatkumar955@example.com','+91 7465958548','New Delhi','Notebook - Stationery',1,'completed','2025-05-12',250),
(956,'Meera Gupta','meeragupta956@yahoo.com','66511 65188','Kolkata','Headphones - Electronics',2,'COMPLETE','2025-07-14',6400),
(957,'Meera Joshi','meerajoshi957@outlook.com',NULL,'Chennai','Keyboard - Electronics',1,'shipped','2025-02-03',1800),
(958,'Arjun Gupta','arjungupta958@example.com','9317315247','Mumbai','Headphones - Electronics',1,'cancelled','2025-01-22',3200),
(959,'Rahul Mehta','rahulmehta959@gmail.com','8712733822',NULL,'Coffee Mug - Home',NULL,'pending','2025-07-13',NULL),
(960,'Nisha Reddy',' nishareddy960@outlook.com ','9905116793','Hyderabad','Laptop - Electronics',2,'shipped','2025-10-05',130000),
(961,'Rohan Joshi','rohanjoshi961@YAHOO.COM','+91-98121-26034','Kolkata','Pen Set - Stationery',5,'Cancelled','2025-11-13',900),
(962,'Vikram Reddy','vikramreddy962@','(615) 878-5695','Kolkata','Monitor - Electronics',0,'Completed','2025-09-18',0),
(963,'  kavya kumar  ','kavyakumar963 @ gmail.com','+91 8197612808','Kolkata','Desk - Furniture',NULL,'Cancelled','2025-11-06',NULL),
(964,'RAJAT SINGH',NULL,'70365 46460','New Delhi','Smartphone - Electronics',4,'shipped','2025-02-24',168000),
(965,'Aarav Gupta','aaravgupta965@outlook.com',NULL,'Kolkata','Monitor - Electronics',1,'Completed','2025-11-04',14500),
(966,'Karan Reddy','karanreddy966@gmail.com','7946252225','Hyderabad','Office Chair - Furniture',NULL,'Returned','2025-04-12',NULL),
(967,'Kavya Reddy','kavyareddy967@yahoo.com','9068114086','Pune','Notebook - Stationery',2,'completed','2025-06-17',500),
(968,'Manish Kumar','manishkumar968@outlook.com','7951244854','Bangalore','Keyboard - Electronics',4,'cancelled','2025-02-03',7200),
(969,'Aarav Verma','aaravverma969@yahoo.com','+91-80454-91387','Delhi','Backpack - Accessories',1,'Cancelled','2025-11-17',1800),
(970,'Rohan Mehta',' rohanmehta970@example.com ','(974) 527-5018','New Delhi','Pen Set - Stationery',5,'return','2025-07-15',900),
(971,'Divya Verma','divyaverma971@YAHOO.COM','+91 6619962132','Kolkata','Keyboard - Electronics',5,'Shipped','2025-03-23',9000),
(972,'  suresh rao  ','sureshrao972@','89827 28970','Delhi','Backpack - Accessories',5,'Completed','2025-12-06',9000),
(973,'NISHA GUPTA','nishagupta973 @ gmail.com',NULL,'Pune','Wireless Mouse - Electronics',1,'Cancelled','2025-10-10',1200),
(974,'Aarav Rao',NULL,'6505698967','Hyderabad','Desk - Furniture',3,'pending','2025-05-16',36000),
(975,'Rajat Patel','rajatpatel975@yahoo.com','9366363141','Ahmedabad','Headphones - Electronics',1,'pending','2025-05-07',3200),
(976,'Sneha Joshi','snehajoshi976@gmail.com','6525394346','Kolkata','Monitor - Electronics',1,'Completed','2025-07-16',14500),
(977,'Manish Reddy','manishreddy977@example.com','+91-98667-04459','Hyderabad','USB Cable - Electronics',4,'Shipped','2025-12-27',2000),
(978,'Isha Patel','ishapatel978@yahoo.com','(816) 794-4263',NULL,'Backpack - Accessories',5,'return','2025-08-05',9000),
(979,'Arjun Sharma','arjunsharma979@example.com','+91 7663162195','Delhi','Coffee Mug - Home',4,'Cancelled','2025-09-02',1800),
(980,'Karan Reddy',' karanreddy980@gmail.com ','97192 42291','Mumbai','Smartphone - Electronics',1,'Returned','2025-11-26',42000),
(981,'  kavya rao  ','kavyarao981@GMAIL.COM',NULL,'Kolkata','Wireless Mouse - Electronics',2,'Returned','2025-09-19',2400),
(982,'AARAV MEHTA','aaravmehta982@','9223624529','Chennai','Notebook - Stationery',1,'completed','2025-11-18',250),
(983,'Sneha Singh','snehasingh983 @ outlook.com','9379095790','Delhi','Office Chair - Furniture',5,'completed','2025-09-20',42500),
(984,'Arjun Verma',NULL,'8110860631','Bengaluru','Monitor - Electronics',4,'COMPLETE','2025-07-01',58000),
(985,'Suresh Gupta','sureshgupta985@example.com','+91-71045-70218','Bangalore','Wireless Mouse - Electronics',1,'shipped','2025-03-10',1200),
(986,'Rahul Patel','rahulpatel986@outlook.com','(929) 984-3529','Bangalore','Keyboard - Electronics',2,'cancelled','2025-11-06',3600),
(987,'Aarav Mehta','aaravmehta987@outlook.com','+91 6779355497','Bengaluru','Smartphone - Electronics',1,'pending','2025-07-04',42000),
(988,'Arjun Patel','arjunpatel988@example.com','98354 53149','Hyderabad','Desk - Furniture',4,'completed','2025-01-07',48000),
(989,'Neha Mehta','nehamehta989@yahoo.com',NULL,'Kolkata','USB Cable - Electronics',NULL,'cancelled','2025-02-09',NULL),
(990,'  aarav gupta  ',' aaravgupta990@example.com ','8375636986','Pune','Wireless Mouse - Electronics',5,'Completed','2025-07-21',6000),
(991,'NEHA SINGH','nehasingh991@OUTLOOK.COM','8379735122','Ahmedabad','Water Bottle - Lifestyle',1,'Pending','2025-09-21',700),
(992,'Rahul Reddy','rahulreddy992@','7915479210','Bangalore','Table Lamp - Home',NULL,'Pending','2025-03-12',NULL),
(993,'Nisha Patel','nishapatel993 @ yahoo.com','+91-83086-97931','Pune','Coffee Mug - Home',NULL,'Shipped','2025-01-01',NULL),
(994,'Karan Mehta',NULL,'(880) 486-6399','Mumbai','Laptop - Electronics',1,'Shipped','2025-05-20',65000),
(995,'Amit Verma','amitverma995@outlook.com','+91 9618246531',NULL,'Office Chair - Furniture',NULL,'pending','2025-01-06',NULL),
(996,'Nisha Mehta','nishamehta996@gmail.com','72912 31895','Bangalore','Headphones - Electronics',1,'COMPLETE','2025-12-18',3200),
(997,'Amit Verma','amitverma997@yahoo.com',NULL,'Kolkata','USB Cable - Electronics',3,'return','2025-06-21',1500),
(998,'Amit Joshi','amitjoshi998@outlook.com','7056253950',NULL,'Monitor - Electronics',3,'Pending','2025-08-20',43500),
(999,'  arjun singh  ','arjunsingh999@yahoo.com','8776452788','Bengaluru','Pen Set - Stationery',0,'Completed','2025-01-22',0),
(1000,'SNEHA VERMA',' snehaverma1000@example.com ','9274763284','Pune','Notebook - Stationery',1,'return','2025-11-03',250);

INSERT INTO orders_raw
(order_id,customer_name,email,phone,city,product,quantity,order_status,order_date,order_total)
VALUES
(1001,'Nisha Joshi','nishajoshi101@EXAMPLE.COM',NULL,'Ahmedabad','Laptop - Electronics',4,'Cancelled','2025-10-09',260000),
(1002,'Rajat Sharma','rajatsharma102@','8896089430','Ahmedabad','Pen Set - Stationery',1,'return','2025-05-19',180),
(1003,'Aarav Patel','aaravpatel103 @ example.com','8228932714',NULL,'Backpack - Accessories',2,'COMPLETE','2025-10-14',3600),
(1004,'Divya Sharma',NULL,'7494481363','Pune','Monitor - Electronics',3,'return','2025-02-28',43500),
(1005,'Sneha Gupta','snehagupta105@example.com','+91-89793-05739','Chennai','Desk - Furniture',4,'shipped','2025-01-15',48000),
(1006,'Priya Gupta','priyagupta106@outlook.com','(738) 845-0337','Bangalore','USB Cable - Electronics',4,NULL,'2025-01-22',2000),
(1007,'Nisha Joshi','nishajoshi107@example.com','+91 6232804774','Delhi','Notebook - Stationery',3,'Returned','2025-08-21',750),
(1008,'  karan singh  ','karansingh108@yahoo.com','71469 97816','Kolkata','Keyboard - Electronics',2,'Shipped','2025-12-16',3600),
(1009,'ANANYA SINGH','ananyasingh109@yahoo.com',NULL,'Mumbai','Desk - Furniture',NULL,'Completed','2025-09-14',NULL),
(1010,'Priya Kumar',' priyakumar110@gmail.com ','7981903597','Bangalore','Water Bottle - Lifestyle',1,'Shipped','2025-12-10',700),
(1011,'Suresh Reddy','sureshreddy111@EXAMPLE.COM','9585112032','Chennai','Backpack - Accessories',0,'Completed','2025-09-05',0),
(1012,'Rohan Kumar','rohankumar112@','9710967433','Bangalore','Desk - Furniture',4,'Cancelled','2025-09-09',48000),
(1013,'Rajat Reddy','rajatreddy113 @ outlook.com','+91-95969-31684','Ahmedabad','Pen Set - Stationery',5,'COMPLETE','2025-08-18',900),
(1014,'Divya Gupta',NULL,'(837) 046-7256','Kolkata','Headphones - Electronics',5,'Cancelled','2025-04-23',16000),
(1015,'Neha Mehta','nehamehta115@example.com','+91 7003143045','Pune','Laptop - Electronics',3,'Shipped','2025-12-26',195000),
(1016,'Rohan Verma','rohanverma116@yahoo.com','81274 20335','Bengaluru','Keyboard - Electronics',NULL,'Returned','2025-06-28',NULL),
(1017,'  ananya joshi  ','ananyajoshi117@gmail.com',NULL,'Chennai','Laptop - Electronics',1,'cancelled','2025-11-05',65000),
(1018,'PRIYA JOSHI','priyajoshi118@outlook.com','7454109425','Ahmedabad','Smartphone - Electronics',4,'return','2025-02-28',168000),
(1019,'Arjun Rao','arjunrao119@example.com','7360049298',NULL,'Smartphone - Electronics',5,'shipped','2025-01-20',210000),
(1020,'Priya Kumar',' priyakumar120@outlook.com ','6977046129','Bangalore','Headphones - Electronics',1,'return','2025-12-28',3200);

-- ============================================================
-- 2. DATA PROFILING BEFORE CLEANING
-- ============================================================

SELECT COUNT(*) AS total_records FROM orders_raw;

SELECT
    SUM(customer_name IS NULL OR TRIM(customer_name) = '') AS missing_names,
    SUM(email IS NULL OR TRIM(email) = '') AS missing_emails,
    SUM(phone IS NULL OR TRIM(phone) = '') AS missing_phones,
    SUM(city IS NULL OR TRIM(city) = '') AS missing_cities,
    SUM(quantity IS NULL) AS missing_quantity,
    SUM(order_status IS NULL OR TRIM(order_status) = '') AS missing_status
FROM orders_raw;

SELECT order_status, COUNT(*) AS record_count
FROM orders_raw
GROUP BY order_status
ORDER BY record_count DESC;

SELECT city, COUNT(*) AS record_count
FROM orders_raw
GROUP BY city
ORDER BY city;

-- ============================================================
-- 3. CREATE CLEAN WORKING TABLE
-- ============================================================

DROP TABLE IF EXISTS orders_clean;

CREATE TABLE orders_clean AS
SELECT * FROM orders_raw;

-- Add cleaned / transformed columns.
ALTER TABLE orders_clean
    ADD COLUMN clean_customer_name VARCHAR(100),
    ADD COLUMN clean_email VARCHAR(150),
    ADD COLUMN clean_phone VARCHAR(20),
    ADD COLUMN standard_city VARCHAR(50),
    ADD COLUMN product_name VARCHAR(100),
    ADD COLUMN product_category VARCHAR(50),
    ADD COLUMN clean_status VARCHAR(30),
    ADD COLUMN clean_quantity INT,
    ADD COLUMN calculated_total DECIMAL(12,2),
    ADD COLUMN data_quality_flag VARCHAR(100);

-- ============================================================
-- 4. NAME CLEANING
--    TRIM removes leading/trailing spaces.
--    LOWER + CONCAT/substring creates consistent title case.
-- ============================================================

UPDATE orders_clean
SET clean_customer_name =
    CONCAT(
        UPPER(LEFT(TRIM(customer_name),1)),
        LOWER(SUBSTRING(TRIM(customer_name),2))
    )
WHERE customer_name IS NOT NULL
  AND TRIM(customer_name) <> '';

-- More robust name standardisation for two-word names.
UPDATE orders_clean
SET clean_customer_name =
    CONCAT(
        UPPER(LEFT(SUBSTRING_INDEX(TRIM(customer_name),' ',1),1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(customer_name),' ',1),2)),
        ' ',
        UPPER(LEFT(SUBSTRING_INDEX(TRIM(customer_name),' ',-1),1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(customer_name),' ',-1),2))
    )
WHERE customer_name IS NOT NULL
  AND TRIM(customer_name) <> ''
  AND LENGTH(TRIM(customer_name)) - LENGTH(REPLACE(TRIM(customer_name),' ',''))
      >= 1;

-- Handle missing names.
UPDATE orders_clean
SET clean_customer_name = 'Unknown Customer'
WHERE clean_customer_name IS NULL OR TRIM(clean_customer_name) = '';

-- ============================================================
-- 5. EMAIL CLEANING
-- ============================================================

UPDATE orders_clean
SET clean_email = LOWER(REPLACE(TRIM(email),' ',''))
WHERE email IS NOT NULL
  AND TRIM(email) <> '';

-- Basic validity rule.
UPDATE orders_clean
SET clean_email = NULL
WHERE clean_email IS NOT NULL
  AND (
      clean_email NOT LIKE '%@%'
      OR clean_email NOT LIKE '%.%'
      OR clean_email LIKE '%@%@%'
  );

-- ============================================================
-- 6. PHONE NUMBER CLEANING
--    Keep digits only and remove country-code prefix 91.
-- ============================================================

UPDATE orders_clean
SET clean_phone =
    REGEXP_REPLACE(TRIM(phone), '[^0-9]', '')
WHERE phone IS NOT NULL
  AND TRIM(phone) <> '';

UPDATE orders_clean
SET clean_phone =
    CASE
        WHEN clean_phone LIKE '91%' AND LENGTH(clean_phone) = 12
            THEN SUBSTRING(clean_phone, 3)
        WHEN LENGTH(clean_phone) = 10
            THEN clean_phone
        ELSE NULL
    END;

-- ============================================================
-- 7. CITY STANDARDISATION
-- ============================================================

UPDATE orders_clean
SET standard_city =
    CASE
        WHEN LOWER(TRIM(city)) IN ('bengaluru','bangalore') THEN 'Bengaluru'
        WHEN LOWER(TRIM(city)) IN ('delhi','new delhi') THEN 'Delhi'
        WHEN LOWER(TRIM(city)) = 'mumbai' THEN 'Mumbai'
        WHEN LOWER(TRIM(city)) = 'hyderabad' THEN 'Hyderabad'
        WHEN LOWER(TRIM(city)) = 'pune' THEN 'Pune'
        WHEN LOWER(TRIM(city)) = 'chennai' THEN 'Chennai'
        WHEN LOWER(TRIM(city)) = 'kolkata' THEN 'Kolkata'
        WHEN LOWER(TRIM(city)) = 'ahmedabad' THEN 'Ahmedabad'
        ELSE 'Unknown'
    END;

-- ============================================================
-- 8. PRODUCT TRANSFORMATION
--    Example: "Laptop - Electronics"
--    becomes product_name = Laptop
--    and product_category = Electronics.
-- ============================================================

UPDATE orders_clean
SET product_name = TRIM(SUBSTRING_INDEX(product,'-',1)),
    product_category = TRIM(SUBSTRING_INDEX(product,'-',-1));

-- ============================================================
-- 9. ORDER STATUS STANDARDISATION
-- ============================================================

UPDATE orders_clean
SET clean_status =
    CASE
        WHEN LOWER(TRIM(order_status)) IN ('completed','complete') THEN 'Completed'
        WHEN LOWER(TRIM(order_status)) = 'pending' THEN 'Pending'
        WHEN LOWER(TRIM(order_status)) = 'cancelled' THEN 'Cancelled'
        WHEN LOWER(TRIM(order_status)) = 'shipped' THEN 'Shipped'
        WHEN LOWER(TRIM(order_status)) = 'returned' THEN 'Returned'
        ELSE 'Unknown'
    END;

-- ============================================================
-- 10. QUANTITY / MISSING VALUE HANDLING
-- ============================================================

UPDATE orders_clean
SET clean_quantity = COALESCE(quantity, 0);

-- Keep invalid negative quantities from entering analysis.
UPDATE orders_clean
SET clean_quantity = 0
WHERE clean_quantity < 0;

-- ============================================================
-- 11. CALCULATED TOTAL
-- ============================================================

UPDATE orders_clean
SET calculated_total =
    CASE
        WHEN clean_quantity > 0 THEN
            ROUND((order_total / NULLIF(quantity,0)) * clean_quantity, 2)
        ELSE 0
    END;

-- If source total is unavailable, use zero rather than NULL for analysis.
UPDATE orders_clean
SET calculated_total = 0
WHERE calculated_total IS NULL;

-- ============================================================
-- 12. DUPLICATE DETECTION
-- ============================================================

-- Find duplicate customer/email combinations.
SELECT
    clean_customer_name,
    clean_email,
    COUNT(*) AS duplicate_count
FROM orders_clean
GROUP BY clean_customer_name, clean_email
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Find duplicate business records based on customer + product + date.
SELECT
    clean_customer_name,
    clean_email,
    product_name,
    order_date,
    COUNT(*) AS duplicate_count
FROM orders_clean
GROUP BY clean_customer_name, clean_email, product_name, order_date
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- ============================================================
-- 13. DATA INCONSISTENCY / CONDITIONAL LOGIC
-- ============================================================

UPDATE orders_clean
SET data_quality_flag =
    CASE
        WHEN clean_email IS NULL THEN 'Invalid/Missing Email'
        WHEN clean_phone IS NULL THEN 'Invalid/Missing Phone'
        WHEN clean_quantity = 0 AND clean_status = 'Completed'
            THEN 'Completed Order With Zero Quantity'
        WHEN clean_status = 'Cancelled' AND clean_quantity > 0
            THEN 'Check Cancelled Order'
        WHEN clean_status = 'Unknown'
            THEN 'Unknown Status'
        WHEN standard_city = 'Unknown'
            THEN 'Unknown City'
        ELSE 'OK'
    END;

-- Show problematic records.
SELECT *
FROM orders_clean
WHERE data_quality_flag <> 'OK'
ORDER BY data_quality_flag, order_id;

-- ============================================================
-- 14. NULL HANDLING REPORT
-- ============================================================

SELECT
    SUM(clean_customer_name = 'Unknown Customer') AS missing_name_count,
    SUM(clean_email IS NULL) AS invalid_email_count,
    SUM(clean_phone IS NULL) AS invalid_phone_count,
    SUM(standard_city = 'Unknown') AS unknown_city_count,
    SUM(clean_status = 'Unknown') AS unknown_status_count,
    SUM(clean_quantity = 0) AS zero_quantity_count
FROM orders_clean;

-- ============================================================
-- 15. CLEANED DATA VIEW
-- ============================================================

DROP VIEW IF EXISTS vw_clean_orders;

CREATE VIEW vw_clean_orders AS
SELECT
    order_id,
    clean_customer_name AS customer_name,
    clean_email AS email,
    clean_phone AS phone,
    standard_city AS city,
    product_name,
    product_category,
    clean_quantity AS quantity,
    clean_status AS order_status,
    order_date,
    calculated_total AS order_total,
    data_quality_flag
FROM orders_clean;

SELECT * FROM vw_clean_orders
ORDER BY order_id
LIMIT 100;

-- ============================================================
-- 16. ORDER ANALYSIS
-- ============================================================

SELECT
    clean_status AS order_status,
    COUNT(*) AS total_orders,
    SUM(calculated_total) AS total_value
FROM orders_clean
GROUP BY clean_status
ORDER BY total_orders DESC;

SELECT
    product_category,
    COUNT(*) AS orders,
    SUM(clean_quantity) AS units_sold,
    SUM(calculated_total) AS sales_value
FROM orders_clean
GROUP BY product_category
ORDER BY sales_value DESC;

SELECT
    standard_city AS city,
    COUNT(*) AS orders,
    SUM(calculated_total) AS sales_value
FROM orders_clean
GROUP BY standard_city
ORDER BY sales_value DESC;

-- ============================================================
-- 17. PRODUCT TRANSFORMATION ANALYSIS
-- ============================================================

SELECT
    product_name,
    product_category,
    COUNT(*) AS order_count,
    SUM(clean_quantity) AS units_sold,
    SUM(calculated_total) AS revenue
FROM orders_clean
GROUP BY product_name, product_category
ORDER BY revenue DESC;

-- ============================================================
-- 18. DATA QUALITY SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_records,
    SUM(data_quality_flag = 'OK') AS clean_records,
    SUM(data_quality_flag <> 'OK') AS records_needing_review,
    ROUND(100 * SUM(data_quality_flag = 'OK') / COUNT(*), 2) AS clean_record_percentage
FROM orders_clean;

-- ============================================================
-- 19. FINAL VALIDATION QUERIES
-- ============================================================

-- Names should not have leading/trailing spaces.
SELECT COUNT(*) AS bad_name_spacing
FROM orders_clean
WHERE clean_customer_name <> TRIM(clean_customer_name);

-- Valid cleaned phone numbers should contain exactly 10 digits.
SELECT COUNT(*) AS bad_phone_values
FROM orders_clean
WHERE clean_phone IS NOT NULL
  AND (clean_phone NOT REGEXP '^[0-9]{10}$');

-- Cleaned emails should contain one @ and a domain.
SELECT COUNT(*) AS bad_email_values
FROM orders_clean
WHERE clean_email IS NOT NULL
  AND (
      clean_email NOT REGEXP '^[^@ ]+@[^@ ]+\\.[^@ ]+$'
  );

-- Standard status list.
SELECT DISTINCT clean_status
FROM orders_clean
ORDER BY clean_status;

-- Standard city list.
SELECT DISTINCT standard_city
FROM orders_clean
ORDER BY standard_city;

-- ============================================================
-- 20. OPTIONAL: REMOVE EXACT DUPLICATE BUSINESS RECORDS
--     Run only if the project requires physical deletion.
-- ============================================================

-- First inspect duplicate IDs:
SELECT
    MIN(order_id) AS keep_order_id,
    clean_customer_name,
    clean_email,
    product_name,
    order_date,
    COUNT(*) AS duplicate_count
FROM orders_clean
GROUP BY clean_customer_name, clean_email, product_name, order_date
HAVING COUNT(*) > 1;

-- Example deletion pattern:
-- DELETE c1
-- FROM orders_clean c1
-- JOIN orders_clean c2
--   ON c1.clean_customer_name = c2.clean_customer_name
--  AND COALESCE(c1.clean_email,'') = COALESCE(c2.clean_email,'')
--  AND c1.product_name = c2.product_name
--  AND c1.order_date = c2.order_date
--  AND c1.order_id > c2.order_id;

-- ============================================================
-- END OF MINI PROJECT 03
-- ============================================================
