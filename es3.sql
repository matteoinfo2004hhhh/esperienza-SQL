CREATE DATABASE PROVA;

SHOW DATABASES;

USE PROVA;

SHOW TABLES;

CREATE TABLE Anagrafica ( 
nome VARCHAR(30) NOT NULL,
cognome VARCHAR(30) NOT NULL,
telefono VARCHAR(30) NOT NULL,
e_mail VARCHAR(50) 
);

DESCRIBE Anagrafica;

DROP TABLE Anagrafica;

SELECT * FROM Anagrafica;

INSERT INTO Anagrafica 
(nome,cognome,telefono,e_mail) 
VALUES 
('Marco','Paiola','0544353','mpaiola66@gmail.com');

INSERT INTO Anagrafica 
(nome,telefono,e_mail) 
VALUES 
('Marco','068456544353','marco@gmail.com');

INSERT INTO Anagrafica 
(nome,cognome,telefono,e_mail) 
VALUES 
('Abcd','Efgh','045635546546','abcd@tim.it'),
('Xyz','Vvv','546604','vvv@tim.it');

SELECT Cognome,Telefono FROM Anagrafica;

SELECT Cognome,Nome FROM Anagrafica;

SELECT Cognome,Nome FROM Anagrafica 
WHERE Cognome<'P';

SELECT Cognome,Nome FROM Anagrafica 
WHERE Cognome='Paiola';

SELECT Cognome,Nome FROM Anagrafica 
WHERE Nome='Marco';

SELECT Cognome,Nome FROM Anagrafica 
WHERE Nome='Marco' OR Nome='Abcd';

SELECT Cognome,Nome FROM Anagrafica 
WHERE Cognome='Paiola' AND Nome='Abcd';

DELETE FROM Anagrafica
WHERE Nome='Abcd';

UPDATE Anagrafica SET Nome='Pippo',Telefono='777' 
WHERE Nome='Gianni';

SELECT * FROM Anagrafica 
ORDER
 BY Cognome DESC,Nome;

CREATE TABLE Studenti ( 
ID_Studenti INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
nome VARCHAR(30) NOT NULL,
cognome VARCHAR(30) NOT NULL,
eta INT(3),
e_mail VARCHAR(50) 
);

INSERT INTO Studenti 
(nome,cognome,eta,e_mail) 
VALUES
('Giuseppe','Verdi',51,'45fsdd'),
('Carlo','Bianchi',49,'fghdfghsdd');

DELETE FROM Studenti 
WHERE ID_Studenti=2;