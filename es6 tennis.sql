-- Creazione del database
CREATE DATABASE tennis_db;
USE tennis_db;

-- Creazione delle tabelle
CREATE TABLE Giocatori (
    ID_Giocatore INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL
);

CREATE TABLE Incontri (
    ID_Incontro INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Giocatore1_ID INT REFERENCES Giocatori(ID_Giocatore),
    Giocatore2_ID INT REFERENCES Giocatori(ID_Giocatore),
    Risultato_Giocatore1 INT NOT NULL,
    Risultato_Giocatore2 INT NOT NULL,
    Set1_Giocatore1 INT NOT NULL,
    Set1_Giocatore2 INT NOT NULL,
    Set2_Giocatore1 INT NOT NULL,
    Set2_Giocatore2 INT NOT NULL,
    Set3_Giocatore1 INT NOT NULL,
    Set3_Giocatore2 INT NOT NULL
);

-- Inserimento di dati di esempio
INSERT INTO Giocatori (Nome, Cognome) VALUES
    ('Roger', 'Federer'),
    ('Rafael', 'Nadal'),
    ('Novak', 'Djokovic'),
    ('Andy', 'Murray');

INSERT INTO Incontri (Giocatore1_ID, Giocatore2_ID, Risultato_Giocatore1, Risultato_Giocatore2, Set1_Giocatore1, Set1_Giocatore2, Set2_Giocatore1, Set2_Giocatore2, Set3_Giocatore1, Set3_Giocatore2)
VALUES
    (1, 2, 2, 1, 6, 7, 6, 3, 4, 6),
    (3, 4, 2, 0, 6, 4, 6, 3, 0, 0),
    (2, 3, 1, 2, 7, 6, 4, 6, 5, 7),
    (1, 4, 0, 2, 4, 6, 2, 6, 0, 0),
    (2, 4, 2, 1, 6, 3, 4, 6, 6, 2);

-- Numero vittorie di ciascun giocatore e percentuale di vittorie
SELECT
    G.ID_Giocatore,
    G.Nome,
    G.Cognome,
    COUNT(I.ID_Incontro) AS NumeroVittorie,
    (COUNT(I.ID_Incontro) * 100.0 / (SELECT COUNT(*) FROM Incontri)) AS PercentualeVittorie
FROM
    Giocatori G
LEFT JOIN
    Incontri I ON G.ID_Giocatore = I.Giocatore1_ID AND I.Risultato_Giocatore1 > I.Risultato_Giocatore2
GROUP BY
    G.ID_Giocatore, G.Nome, G.Cognome

UNION ALL

SELECT
    G.ID_Giocatore,
    G.Nome,
    G.Cognome,
    COUNT(I.ID_Incontro) AS NumeroVittorie,
    (COUNT(I.ID_Incontro) * 100.0 / (SELECT COUNT(*) FROM Incontri)) AS PercentualeVittorie
FROM
    Giocatori G
LEFT JOIN
    Incontri I ON G.ID_Giocatore = I.Giocatore2_ID AND I.Risultato_Giocatore2 > I.Risultato_Giocatore1
GROUP BY
    G.ID_Giocatore, G.Nome, G.Cognome;

-- Totale set vinti e set persi di ciascun giocatore
SELECT
    G.ID_Giocatore,
    G.Nome,
    G.Cognome,
    SUM(I.Set1_Giocatore1 + I.Set2_Giocatore1 + I.Set3_Giocatore1) AS TotaleSetVinti,
    SUM(I.Set1_Giocatore2 + I.Set2_Giocatore2 + I.Set3_Giocatore2) AS TotaleSetPersi
FROM
    Giocatori G
LEFT JOIN
    Incontri I ON G.ID_Giocatore = I.Giocatore1_ID OR G.ID_Giocatore = I.Giocatore2_ID
GROUP BY
    G.ID_Giocatore, G.Nome, G.Cognome;

-- Totale giochi vinti e giochi persi di ciascun giocatore
SELECT
    G.ID_Giocatore,
    G.Nome,
    G.Cognome,
    SUM(I.Set1_Giocatore1 + I.Set1_Giocatore2 + I.Set2_Giocatore1 + I.Set2_Giocatore2 + I.Set3_Giocatore1 + I.Set3_Giocatore2) AS TotaleGiochiVinti,
    SUM(I.Set1_Giocatore2 + I.Set1_Giocatore1 + I.Set2_Giocatore2 + I.Set2_Giocatore1 + I.Set3_Giocatore2 + I.Set3_Giocatore1) AS TotaleGiochiPersi
FROM
    Giocatori G
LEFT JOIN
    Incontri I ON G.ID_Giocatore = I.Giocatore1_ID OR G.ID_Giocatore = I.Giocatore2_ID
GROUP BY
    G.ID_Giocatore, G.Nome, G.Cognome;

-- Incontri giocati tra due giocatori
SELECT
    G1.Nome AS NomeGiocatore1,
    G1.Cognome AS CognomeGiocatore1,
    G2.Nome AS NomeGiocatore2,
    G2.Cognome AS CognomeGiocatore2,
    COUNT(*) AS IncontriGiocati
FROM
    Incontri I
JOIN
    Giocatori G1 ON I.Giocatore1_ID = G1.ID_Giocatore
JOIN
    Giocatori G2 ON I.Giocatore2_ID = G2.ID_Giocatore
GROUP BY
    G1.Nome, G1.Cognome, G2.Nome, G2.Cognome;