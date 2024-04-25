CREATE DATABASE scuola;
USE scuola;

CREATE TABLE Studenti (
ID_Studenti INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(30) NOT NULL,
cognome VARCHAR(30) NOT NULL 
);

CREATE TABLE Voti (
ID_Voti INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Voto DECIMAL(4,1) NOT NULL,
ID_Studenti INT NOT NULL 
);

INSERT INTO Studenti (nome,cognome) 
VALUES
('Mario','Bianchi'),
('Gianni','Rossi'),
('Roberto','Verdi'),
('Francesco','Neri'),
('Antonio','Rosa')

INSERT INTO Voti (voto,ID_Studenti) 
VALUES 
(5.5,3),
(4.5,2),
(6,2),
(8,1),
(3,5),
(5,1),
(6.5,3),
(7.5,2),
(9,1),
(2,5),
(10,5),
(8.5,1),
(6.5,1),
(4,2)


Voti di uno specifico studente
SELECT Studenti.nome, Studenti.cognome, Voti.voto 
FROM Voti
INNER JOIN Studenti ON Voti.ID_Studenti=Studenti.ID_Studenti
WHERE Studenti.ID_Studenti=2;

Conteggio voti per ogni studente
SELECT Studenti.nome, Studenti.cognome, COUNT(Voti.ID_Voti) AS conta_voti 
FROM Voti
RIGHT JOIN Studenti ON Voti.ID_Studenti=Studenti.ID_Studenti
GROUP BY Studenti.ID_Studenti 
ORDER BY Studenti.nome, Studenti.cognome;

Media voti per ogni studente
SELECT Studenti.nome, Studenti.cognome, AVG(Voti.voto) AS media_voti 
FROM Voti
INNER JOIN Studenti ON Voti.ID_Studenti=Studenti.ID_Studenti
GROUP BY Studenti.ID_Studenti 
ORDER BY Studenti.nome, Studenti.cognome;

Media voti complessiva
SELECT  AVG(Voti.voto) AS media_totale 
FROM Voti;

Voto max per ogni studente
SELECT Studenti.nome, Studenti.cognome, MAX(Voti.voto) AS voto_massimo  
FROM Voti
INNER JOIN Studenti ON Voti.ID_Studenti=Studenti.ID_Studenti
GROUP BY Studenti.ID_Studenti 
ORDER BY Studenti.nome, Studenti.cognome;