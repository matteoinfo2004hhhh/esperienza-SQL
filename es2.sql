-- Selezionare tutti gli attori nati dopo il 1980
SELECT * FROM ATTORI WHERE AnnoNascita > 1980;

-- Selezionare i film di un dato genere (ad esempio, Azione)
SELECT * FROM FILM WHERE Genere = 'Azione';

-- Recuperare tutti i film in cui ha recitato un attore specifico (utilizzando il CodAttore)
SELECT FILM.Titolo, FILM.AnnoProduzione, FILM.Nazionalità 
FROM FILM 
INNER JOIN RECITA ON FILM.CodFilm = RECITA.CodFilm 
WHERE RECITA.CodAttore = 'CodAttoreDesiderato';

-- Calcolare l'incasso totale per ogni sala di proiezione
SELECT SALE.Nome, SUM(PROIEZIONI.Incasso) AS IncassoTotale
FROM SALE
INNER JOIN PROIEZIONI ON SALE.CodSala = PROIEZIONI.CodSala
GROUP BY SALE.Nome;

-- Trova i film proiettati in una sala di una data città
SELECT FILM.Titolo, FILM.AnnoProduzione 
FROM FILM 
INNER JOIN PROIEZIONI ON FILM.CodFilm = PROIEZIONI.CodFilm 
INNER JOIN SALE ON PROIEZIONI.CodSala = SALE.CodSala 
WHERE SALE.Città = 'NomeCittàDesiderata';
