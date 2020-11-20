CREATE SCHEMA scheduleMe;
go

CREATE TABLE scheduleMe._user (
	username VARCHAR(40) PRIMARY KEY,
	password VARCHAR(20),
	type CHAR(3)
);

CREATE TABLE scheduleMe.part (
	part_no VARCHAR(15) PRIMARY KEY,
	quantity_on_hand INT,
	resource VARCHAR(15),
	machine VARCHAR(10),
	time_to_make DECIMAL(5,2),
	quantity_per_container SMALLINT,
	avg_changeover DECIMAL(6,2),
	avg_efficiency DECIMAL(3,2)
);

CREATE TABLE scheduleMe._order (
	order_id INT IDENTITY(1,1) PRIMARY KEY,
	part_no VARCHAR(15),
	quantity INT,
	company VARCHAR(100),
	location VARCHAR(100),
	time_received SMALLDATETIME,
	time_to_receive_by SMALLDATETIME,
	time_to_ship DECIMAL(5,2),
	_user VARCHAR(40),
	status VARCHAR(2),
	FOREIGN KEY (part_no) REFERENCES scheduleMe.part (part_no),
	FOREIGN KEY (_user) REFERENCES scheduleMe._user (username) 
);

CREATE TABLE scheduleMe.schedule (
	id INT IDENTITY(1,1) PRIMARY KEY,
	order_id INT,
	standard_queue_position SMALLINT,
	urgent_queue_position SMALLINT,
	part_no VARCHAR(15),
	quantity INT,
	start_time SMALLDATETIME,
	completion_time SMALLDATETIME,
	est_time_needed DECIMAL(5,2),
	no_of_containers SMALLINT,
	FOREIGN KEY (part_no) REFERENCES scheduleMe.part (part_no),
	FOREIGN KEY (order_id) REFERENCES scheduleMe._order (order_id) ON DELETE CASCADE ON UPDATE CASCADE
);