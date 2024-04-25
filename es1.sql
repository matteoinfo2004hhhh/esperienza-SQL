-- Blocco 4: Interrogazioni sui Prodotti

-- Selezionare tutti i prodotti
SELECT * FROM Prodotti;

-- Selezionare i prodotti con un prezzo superiore a 100 euro
SELECT * FROM Prodotti WHERE Prezzo > 100;

-- Aggiornare il prezzo di un prodotto
UPDATE Prodotti SET Prezzo = 120 WHERE ID_Prodotto = 123;

-- Blocco 5: Interrogazioni sugli Ordini

-- Selezionare tutti gli ordini effettuati da un determinato cliente
SELECT * FROM Ordini WHERE ID_Cliente = 'cliente123';

-- Calcolare il totale degli ordini per ogni cliente
SELECT ID_Cliente, SUM(Totale) AS Totale_Ordini 
FROM Ordini 
GROUP BY ID_Cliente;

-- Eliminare un ordine specifico
DELETE FROM Ordini WHERE ID_Ordine = 456;
