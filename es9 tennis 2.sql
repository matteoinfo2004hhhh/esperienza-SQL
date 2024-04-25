CREATE TABLE Giocatori ( 
ID_Giocatori INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
nome VARCHAR(30) NOT NULL,
cognome VARCHAR(30) NOT NULL,
eta INT(3),
classifica INT(4)
);

INSERT INTO Giocatori 
(ID_Giocatori,nome,cognome,eta,classifica) 
VALUES
(1,'Novak','Djokovic',36,1),
(2,'Carlos','Alcaraz',20,2),
(3,'Daniil','Medvedev',27,3),
(4,'Jannik','Sinner',22,4),
(5,'Andrey','Rublev',26,5),
(6,'Alexander','Zverev',26,6),
(7,'Stefanos','Tsitsipas',25,7),
(8,'Holger','Rune',20,8);

CREATE TABLE Incontri ( 
ID_Incontri INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
ID_gioc_1 INT NOT NULL,
ID_gioc_2 INT NOT NULL,
set1_1 INT(1),
set1_2 INT(1),
vinc1 INT,
set2_1 INT(1),
set2_2 INT(1),
vinc2 INT,
set3_1 INT(1),
set3_2 INT(1),
vinc3 INT,
vincente INT
);

INSERT INTO Incontri 
(ID_gioc_1,ID_gioc_2,set1_1,set1_2,vinc1,set2_1,set2_2,vinc2,set3_1,set3_2,vinc3,vincente) 
VALUES 
(4,8,6,3,4,6,4,4,0,0,0,4),
(3,2,3,6,2,6,1,3,6,4,3,3),
(2,1,7,6,2,5,3,2,0,0,0,2),
(6,3,1,6,3,6,4,6,2,6,3,3),
(8,3,2,6,3,5,7,3,0,0,0,3),
(5,6,6,1,5,6,1,5,0,0,0,5),
(5,2,0,0,0,0,0,0,0,0,0,5),
(6,1,7,5,6,5,7,1,6,7,1,1),
(1,2,6,3,1,4,6,2,6,2,1,1),
(4,5,2,6,5,6,3,4,6,1,4,4),
(3,5,6,3,3,6,1,3,0,0,0,3);


SELECT t1.cognome AS g1,t2.cognome AS g2,
Incontri.set1_1,Incontri.set1_2,
Incontri.set2_1,Incontri.set2_2, 
Incontri.set3_1,Incontri.set3_2,
t3.cognome AS g3  
FROM Incontri
INNER JOIN Giocatori t1 ON Incontri.ID_gioc_1=t1.ID_giocatori 
INNER JOIN Giocatori t2 ON Incontri.ID_gioc_2=t2.ID_giocatori 
INNER JOIN Giocatori t3 ON Incontri.vincente=t3.ID_giocatori 



Produrre le seguenti query:

- numero vittorie di ciascun giocatore e percentuale di vittorie;

SELECT TBL.cognome, 
SUM(TBL.vittorie) AS vittorie, 
SUM(TBL.incontri) AS incontri, 
(SUM(TBL.vittorie)/SUM(TBL.incontri))*100 AS perc 
FROM 
(

SELECT Giocatori.cognome, 
COUNT(Incontri.vincente) AS vittorie,0 AS incontri  
FROM Incontri
INNER JOIN Giocatori ON Incontri.vincente=Giocatori.ID_giocatori 
WHERE Incontri.vincente=[1] 

UNION

SELECT 
CASE WHEN Incontri.ID_gioc_1=2 THEN t1.cognome ELSE t2.cognome END AS cognome,
0 AS vittorie, COUNT(Incontri.ID_Incontri) AS incontri 
FROM Incontri
INNER JOIN Giocatori t1 ON Incontri.ID_gioc_1=t1.ID_giocatori 
INNER JOIN Giocatori t2 ON Incontri.ID_gioc_2=t2.ID_giocatori 
WHERE Incontri.ID_gioc_1=[1] OR Incontri.ID_gioc_2=[1]

) 
TBL
GROUP BY TBL.cognome

-------------------

- totale set vinti e set persi di ciascun giocatore;

SELECT TBL.cognome, SUM(TBL.set1+TBL.set2+TBL.set3) AS totsetv, SUM(TBL.nset1+TBL.nset2+TBL.nset3) AS totsetp 
FROM 
(

SELECT Incontri.ID_Incontri,
CASE WHEN Incontri.ID_gioc_1=[1] THEN t1.cognome ELSE t2.cognome END AS cognome,
CASE WHEN Incontri.vinc1=[1] THEN 1 ELSE 0 END AS set1,
CASE WHEN Incontri.vinc2=[1] THEN 1 ELSE 0 END AS set2,
CASE WHEN Incontri.vinc3=[1] THEN 1 ELSE 0 END AS set3, 
CASE WHEN (Incontri.vinc1!=[1] AND Incontri.vinc1!=0) THEN 1 ELSE 0 END AS nset1,
CASE WHEN (Incontri.vinc1!=[1] AND Incontri.vinc1!=0) THEN 1 ELSE 0 END AS nset2,
CASE WHEN (Incontri.vinc1!=[1] AND Incontri.vinc1!=0) THEN 1 ELSE 0 END AS nset3 
FROM Incontri
INNER JOIN Giocatori t1 ON Incontri.ID_gioc_1=t1.ID_giocatori 
INNER JOIN Giocatori t2 ON Incontri.ID_gioc_2=t2.ID_giocatori 
WHERE Incontri.ID_gioc_1=[1] OR Incontri.ID_gioc_2=[1]

) 
TBL
GROUP BY TBL.cognome

-------------------

- totale giochi vinti e giochi persi di ciascun giocatore;

SELECT TBL.cognome, 
SUM(TBL.set1)+SUM(TBL.set2)+SUM(TBL.set3) AS tgamevinti,
SUM(TBL.nset1)+SUM(TBL.nset2)+SUM(TBL.nset3) AS tgamepersi 
FROM 
(

SELECT Incontri.ID_Incontri,Giocatori.cognome,
Incontri.set1_1 AS set1,0 AS nset1,
Incontri.set2_1 AS set2,0 AS nset2,
Incontri.set3_1 AS set3,0 AS nset3 
FROM Incontri
INNER JOIN Giocatori ON Incontri.ID_gioc_1=Giocatori.ID_giocatori 
WHERE Incontri.ID_gioc_1=[1] 

UNION 

SELECT Incontri.ID_Incontri,Giocatori.cognome,
Incontri.set1_2 AS set1,0 AS nset1,
Incontri.set2_2 AS set2,0 AS nset2,
Incontri.set3_2 AS set3,0 AS nset3 
FROM Incontri
INNER JOIN Giocatori ON Incontri.ID_gioc_2=Giocatori.ID_giocatori 
WHERE Incontri.ID_gioc_2=[1]

UNION

SELECT Incontri.ID_Incontri,Giocatori.cognome,
0 AS set1,Incontri.set1_2 AS nset1,
0 AS set2,Incontri.set2_2 AS nset2,
0 AS set3,Incontri.set3_2 AS nset3 
FROM Incontri
INNER JOIN Giocatori ON Incontri.ID_gioc_1=Giocatori.ID_giocatori 
WHERE Incontri.ID_gioc_1=[1]  

UNION 

SELECT Incontri.ID_Incontri,Giocatori.cognome,
0 AS set1,Incontri.set1_1 AS nset1,
0 AS set2,Incontri.set2_1 AS nset2,
0 AS set3,Incontri.set3_1 AS nset3 
FROM Incontri
INNER JOIN Giocatori ON Incontri.ID_gioc_2=Giocatori.ID_giocatori 
WHERE Incontri.ID_gioc_2=[1]

) 
TBL
GROUP BY TBL.cognome

-------------------

- incontri giocati tra due giocatori.

SELECT t1.cognome AS g1,t2.cognome AS g2,
Incontri.set1_1,Incontri.set1_2,
Incontri.set2_1,Incontri.set2_2, 
Incontri.set3_1,Incontri.set3_2,
t3.cognome AS g3  
FROM Incontri
INNER JOIN Giocatori t1 ON Incontri.ID_gioc_1=t1.ID_giocatori 
INNER JOIN Giocatori t2 ON Incontri.ID_gioc_2=t2.ID_giocatori 
INNER JOIN Giocatori t3 ON Incontri.vincente=t3.ID_giocatori 
WHERE Incontri.ID_gioc_1=[1] AND Incontri.ID_gioc_2=[2]
OR Incontri.ID_gioc_1=[2] AND Incontri.ID_gioc_2=[1]

-------------------