-- 1. Trova il nome del prodotto e la quantità in magazzino per i prodotti con un prezzo superiore a 50 ed inferiore a 150
SELECT nome_prodotto, stock
FROM Prodotti
WHERE prezzo > 50 AND prezzo < 150;

-- 2. Visualizza il totale delle vendite per ogni cliente
SELECT id_cliente, SUM(totale_vendita) AS totale_vendite
FROM Vendite
GROUP BY id_cliente;

-- 3. Visualizza il prezzo medio dei prodotti
SELECT AVG(prezzo) AS prezzo_medio
FROM Prodotti;

-- 4. Visualizza la somma delle vendite effettuate nell’anno 2023
SELECT SUM(totale_vendita) AS totale_vendite_2023
FROM Vendite
WHERE YEAR(data_vendita) = 2023;

-- 5. Trova il nome e il totale delle vendite per un cliente specifico (ad esempio, cliente con id_cliente uguale a 1)
SELECT c.nome, SUM(v.totale_vendita) AS totale_vendite
FROM Clienti c
JOIN Vendite v ON c.id_cliente = v.id_cliente
WHERE c.id_cliente = 1
GROUP BY c.nome;

-- 6. Trova il cliente con il numero massimo di vendite
SELECT id_cliente, COUNT(*) AS numero_vendite
FROM Vendite
GROUP BY id_cliente
ORDER BY numero_vendite DESC
LIMIT 1;

-- 7. Contare il numero di vendite per ciascun cliente e visualizzare solo quelli con almeno 2 vendite
SELECT id_cliente, COUNT(*) AS numero_vendite
FROM Vendite
GROUP BY id_cliente
HAVING COUNT(*) >= 2;

-- 8. Contare il numero di prodotti con prezzo superiore a 50 per ogni categoria di prodotti e visualizzare solo le categorie con almeno 3 prodotti
SELECT p.id_prodotto, COUNT(*) AS numero_prodotti
FROM Prodotti p
WHERE p.prezzo > 50
GROUP BY p.id_prodotto
HAVING COUNT(*) >= 3;
