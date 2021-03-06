CREATE TABLE reservationSystem(
  reservationNo int(11) NOT NULL AUTO_INCREMENT,
  startTime DATETIME NOT NULL,
  endTime DATETIME NOT NULL,
  place VARCHAR(50) NOT NULL,
  memberId VARCHAR (50) NOT NULL,
  PRIMARY KEY (reservationNo)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE place(
  placeNo int (11) NOT NULL AUTO_INCREMENT,
  place VARCHAR (50) NOT NULL,
  startHour INTEGER NOT NULL,
  startMin INTEGER NOT NULL,
  endHour INTEGER NOT NULL,
  endMin INTEGER NOT NULL,
  PRIMARY KEY (placeNo)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

