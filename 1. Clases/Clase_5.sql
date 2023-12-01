-- Momento 1 (creacion de tablas)
CREATE TABLE customers(
    customerid INT primary key,
    name VARCHAR(50),
    occupation VARCHAR(50),
    email VARCHAR(50),
    company VARCHAR(50),
    phonenumber VARCHAR(20),
    age INT
);

CREATE TABLE agents(
    agentid INT primary key,
    name VARCHAR(50)
);

CREATE TABLE calls(
    callid INT primary key,
    agentid INT,
    customerid INT,
    pickedup SMALLINT,
    duration INT,
    productsold SMALLINT
);



-- la supuesta optimizada
CREATE TABLE agentsx (
    agentid INTEGER PRIMARY KEY,
    name VARCHAR(50)
)
DISTSTYLE ALL
SORTKEY(name);

CREATE TABLE callsx (
    callid INTEGER PRIMARY KEY,
    agentid INTEGER REFERENCES agents(agentid),
    customerid INTEGER,
    pickedup TIMESTAMP,
    duration INTEGER,
    productsold VARCHAR(50)
)
DISTSTYLE KEY
DISTKEY(agentid) -- podria ser la callid tambien
SORTKEY(pickedup);

CREATE TABLE customersx (
    customerid INTEGER PRIMARY KEY,
    name VARCHAR(50),
    occupation VARCHAR(50),
    email VARCHAR(50),
    company VARCHAR(50),
    phonenumber VARCHAR(50),
    age INTEGER
)
DISTSTYLE KEY
DISTKEY(customerid)
SORTKEY(name);