CREATE TABLE memberData(
  memberId VARCHAR (255) NOT NULL,
  pw VARCHAR (255) DEFAULT NULL,
  name VARCHAR (50) DEFAULT NULL,
  positionNo INT (11) DEFAULT NULL,
  spotNo INT(11) DEFAULT NULL,
  departmentNo INT(11) DEFAULT NULL,
  email VARCHAR (50) DEFAULT NULL,
  entryDate DATETIME DEFAULT NULL,
  modifyDate DATETIME DEFAULT NULL,
  registrationDate DATETIME DEFAULT NULL,
  lastAccessTime DATETIME DEFAULT NULL,
  used tinyint(1) DEFAULT NULL,
  securityRating INT(11) DEFAULT NULL,
  businessNo VARCHAR (50) DEFAULT NULL,
  jibunAddr VARCHAR (50) DEFAULT NULL,
  zipCode VARCHAR (11) DEFAULT NULL,
  streetAddr VARCHAR (50) DEFAULT NULL,
  PRIMARY KEY (memberId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8