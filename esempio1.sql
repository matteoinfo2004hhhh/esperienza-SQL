CREATE TABLE Utenti (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Email VARCHAR(50)
);

CREATE TABLE Ordini (
    ID INT PRIMARY KEY,
    ProdottoID INT,
    UtenteID INT,
    Quantita INT,
    FOREIGN KEY (ProdottoID) REFERENCES Prodotti(ID),
    FOREIGN KEY (UtenteID) REFERENCES Utenti(ID)
);
