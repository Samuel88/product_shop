-- Svuotiamo le tabelle prima di reinserire i dati di test, così possiamo
-- rieseguire questo script tutte le volte che vogliamo (idempotenza).
-- TRUNCATE è più "drastico" di DELETE: svuota la tabella e resetta anche
-- il contatore AUTO_INCREMENT (gli id ripartono da 1).
--
-- Problema: TRUNCATE non è permesso su una tabella referenziata da una
-- FOREIGN KEY, anche se la tabella che la referenzia è vuota o viene
-- svuotata prima. Per questo disabilitiamo temporaneamente i controlli
-- sulle foreign key (FOREIGN_KEY_CHECKS = 0), facciamo i TRUNCATE, e poi
-- li riattiviamo (FOREIGN_KEY_CHECKS = 1).
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE product_category; -- tabella "ponte" tra prodotti e categorie
TRUNCATE TABLE reviews;          -- referenzia products.id
TRUNCATE TABLE categories;       -- referenziata da product_category
TRUNCATE TABLE products;         -- referenziata da reviews e product_category
SET FOREIGN_KEY_CHECKS = 1;

-- In alternativa, senza toccare FOREIGN_KEY_CHECKS, si può usare DELETE
-- rispettando l'ordine "figli prima dei genitori": cancellando prima le
-- righe che contengono le foreign key, non si viola mai il vincolo.
-- Però DELETE non resetta l'AUTO_INCREMENT, quindi va fatto a mano con
-- ALTER TABLE: serve perché qui sotto inseriamo i collegamenti in
-- product_category usando id "1, 2, 3..." che devono corrispondere
-- esattamente ai nuovi id generati per products e categories.
-- DELETE FROM product_category;
-- DELETE FROM reviews;
-- DELETE FROM categories;
-- DELETE FROM products;

-- ALTER TABLE products AUTO_INCREMENT = 1;
-- ALTER TABLE categories AUTO_INCREMENT = 1;

-- Categorie
INSERT INTO categories (name, slug, description)
VALUES
('Freschi', 'freschi', 'Prodotti freschi di mare'),
('Griglia', 'griglia', 'Specialità cotte alla griglia'),
('Panini marini', 'panini-marini', 'Panini ispirati al mare'),
('Specialità della casa', 'specialita-della-casa', 'Piatti simbolo del locale'),
('Edizioni limitate', 'edizioni-limitate', 'Piatti speciali a disponibilità limitata'),
('Antipasti', 'antipasti', 'Piccoli assaggi per iniziare'),
('Primi piatti', 'primi-piatti', 'Pasta, riso e zuppe di mare'),
('Fritti', 'fritti', 'Fritture croccanti di pesce e crostacei'),
('Crudi', 'crudi', 'Pesce crudo e tartare'),
('Dolci', 'dolci', 'Dessert per chiudere in bellezza');

-- Prodotti (25 totali: 20 polpo-based + 5 nuovi in stile comico)
INSERT INTO products (name, slug, description, price, image)
VALUES
('Polpo Arrosto Director''s Cut', 'polpo-arrosto-directors-cut', 'Polpo arrosto intenso e scenografico, il finale che tutti aspettavano.', 18.50, 'https://picsum.photos/seed/polpo1/600/400'),
('Insalata di Polpo Edizione Restaurata', 'insalata-di-polpo-edizione-restaurata', 'Classico intramontabile rimasterizzato con agrumi e prezzemolo.', 14.00, 'https://picsum.photos/seed/polpo2/600/400'),
('Panino Cult Assoluto', 'panino-cult-assoluto', 'Panino marino con polpo grigliato, salsa della casa e finale da applausi.', 12.50, 'https://picsum.photos/seed/polpo3/600/400'),
('Spaghetti al Sugo di Polpo Anteprima Mondiale', 'spaghetti-al-sugo-di-polpo-anteprima-mondiale', 'Spaghetti con sugo ricco di polpo, un debutto che conquista al primo assaggio.', 16.00, 'https://picsum.photos/seed/spaghetti1/600/400'),
('Polpetti Fritti Backstage', 'polpetti-fritti-backstage', 'Un dietro le quinte croccante di polpetti piccoli fritti al momento.', 15.50, 'https://picsum.photos/seed/frittura1/600/400'),
('Polpo alla Luciana Scena Madre', 'polpo-alla-luciana-scena-madre', 'Polpo in guazzetto di pomodoro e olive alla maniera napoletana, il momento clou della serata.', 19.00, 'https://picsum.photos/seed/polpo4/600/400'),
('Polpo Crudo Marinato Trailer', 'polpo-crudo-marinato-trailer', 'Un assaggio crudo e raffinato di polpo marinato agli agrumi, l''anteprima perfetta prima del piatto principale.', 17.50, 'https://picsum.photos/seed/polpo5/600/400'),
('Risotto Cremoso al Polpo Colonna Sonora', 'risotto-cremoso-al-polpo-colonna-sonora', 'Risotto mantecato con polpo a pezzi, la colonna sonora ideale per la cena.', 16.50, 'https://picsum.photos/seed/risotto1/600/400'),
('Polpo in Guazzetto Ciak Si Gira', 'polpo-in-guazzetto-ciak-si-gira', 'Polpo stufato in salsa di pomodoro fresco, pronto sul set in pochi minuti.', 11.00, 'https://picsum.photos/seed/polpo6/600/400'),
('Polpo Fritto Croccante Sequel', 'polpo-fritto-croccante-sequel', 'Il sequel croccante del polpo fritto, ancora più gustoso del primo capitolo.', 13.00, 'https://picsum.photos/seed/polpo7/600/400'),
('Polpo al Sale Premiere', 'polpo-al-sale-premiere', 'Polpo in crosta di sale, una prima assoluta da non perdere.', 22.00, 'https://picsum.photos/seed/polpo8/600/400'),
('Antipasto Misto di Polpo Casting', 'antipasto-misto-di-polpo-casting', 'Una selezione di assaggi di polpo in tutte le sue forme, il casting perfetto per iniziare.', 14.50, 'https://picsum.photos/seed/antipasto1/600/400'),
('Linguine al Polpo Gran Finale', 'linguine-al-polpo-gran-finale', 'Linguine con polpo fresco al pomodoro, il gran finale che lascia il pubblico senza parole.', 24.00, 'https://picsum.photos/seed/linguine1/600/400'),
('Panino al Polpo Scottato Spin-off', 'panino-al-polpo-scottato-spin-off', 'Panino con polpo scottato e maionese alle erbe, lo spin-off del nostro grande classico.', 11.50, 'https://picsum.photos/seed/panino1/600/400'),
('Tartare di Polpo Fresco Flashback', 'tartare-di-polpo-fresco-flashback', 'Tartare di polpo fresco con agrumi e capperi, un flashback di sapori intensi.', 16.00, 'https://picsum.photos/seed/polpo9/600/400'),
('Gran Piatto di Polpo Mixology Set', 'gran-piatto-di-polpo-mixology-set', 'Maxi piatto di polpo in tutte le preparazioni, pensato per essere condiviso come in un set cinematografico.', 18.00, 'https://picsum.photos/seed/polpo10/600/400'),
('Polpo Marinato in Agrodolce Cult Movie', 'polpo-marinato-in-agrodolce-cult-movie', 'Polpo marinato con aceto e miele, un piccolo cult intramontabile.', 9.50, 'https://picsum.photos/seed/polpo11/600/400'),
('Polpo alla Brace Stunt Double', 'polpo-alla-brace-stunt-double', 'Polpo grigliato sulla brace viva, la controfigura perfetta del piatto principale.', 21.00, 'https://picsum.photos/seed/polpo12/600/400'),
('Tiramisù al Limone Titoli di Coda', 'tiramisu-al-limone-titoli-di-coda', 'Un dolce fresco al limone per chiudere lo spettacolo in bellezza.', 7.00, 'https://picsum.photos/seed/tiramisu1/600/400'),
('Cheesecake al Lime Backstage Pass', 'cheesecake-al-lime-backstage-pass', 'Cheesecake al lime cremosa, l''accesso esclusivo al lieto fine.', 7.50, 'https://picsum.photos/seed/cheesecake1/600/400'),
-- Nuovi prodotti (stile comico)
('Polpo con Otto Scuse', 'polpo-con-otto-scuse', 'Ha otto tentacoli e altrettante scuse per non finirlo mai. Fritto, croccante, irresistibile. Alla fine lo finisci lo stesso.', 13.00, 'https://picsum.photos/seed/polpo13/600/400'),
('Polpo in Crisi d''Identità', 'polpo-in-crisi-didentita', 'Non sa se è un piatto o un personaggio di Nemo. Lo abbiamo convinto a stare nel piatto con fatica, aglio e un po'' di senso di colpa.', 15.00, 'https://picsum.photos/seed/polpo14/600/400'),
('Polpo Mimetico alla Griglia', 'polpo-mimetico-alla-griglia', 'Così fresco che quando l''abbiamo pescato cercava ancora di cambiare colore. Non ci è riuscito. Il risultato è delizioso.', 17.00, 'https://picsum.photos/seed/polpo15/600/400'),
('Polpo del Lunedì Mattina', 'polpo-del-lunedi-mattina', 'Freschissimo ma umoralmente instabile. Non garantiamo sia contento di essere qui. Garantiamo che sia buonissimo.', 11.50, 'https://picsum.photos/seed/polpo16/600/400'),
('Il Polpo che Non Voleva Essere Mangiato', 'il-polpo-che-non-voleva-essere-mangiato', 'Una storia di coraggio, marinatura lenta e resa finale. Spoiler: viene mangiato. Ogni volta. Senza rimpianti.', 19.50, 'https://picsum.photos/seed/polpo17/600/400');

-- Collegamenti prodotto-categoria
INSERT INTO product_category (product_id, category_id)
VALUES
(1, 2),
(1, 4),
(2, 1),
(2, 4),
(3, 3),
(3, 5),
(4, 7),
(4, 5),
(5, 8),
(5, 2),
(6, 4),
(6, 1),
(7, 9),
(7, 1),
(8, 7),
(8, 4),
(9, 6),
(9, 1),
(10, 8),
(10, 6),
(11, 2),
(11, 4),
(12, 6),
(12, 1),
(13, 7),
(13, 5),
(14, 3),
(14, 1),
(15, 9),
(15, 5),
(16, 7),
(16, 4),
(17, 6),
(17, 1),
(18, 2),
(18, 4),
(19, 10),
(19, 5),
(20, 10),
(20, 5),
(21, 8),
(21, 6),
(22, 2),
(22, 4),
(23, 2),
(23, 5),
(24, 1),
(24, 6),
(25, 4),
(25, 5);

-- Reviews (20 esistenti + 30 nuove = 50 totali)
-- Prodotti con media ~1-2 stelle: 6 (Polpo alla Luciana), 9 (Polpo in Guazzetto), 22 (Polpo in Crisi d'Identità)
-- Prodotti con media 5 stelle: 1 (Polpo Arrosto), 13 (Linguine al Polpo), 21 (Polpo con Otto Scuse)
INSERT INTO reviews (product_id, name, rating, title, content)
VALUES
-- Recensioni esistenti (aggiornate per i prodotti rinominati)
(1, 'Martina', 5, 'Capolavoro assoluto', 'Cottura perfetta e presentazione da premio.'),
(1, 'Luca', 4, 'Molto scenico', 'Davvero buono, sapore intenso e ben bilanciato.'),
(2, 'Giulia', 5, 'Restauro riuscitissimo', 'Fresco e gustoso, uno dei migliori assaggi della serata.'),
(3, 'Davide', 4, 'Panino da sequel', 'Molto saporito, lo riprenderei volentieri.'),
(4, 'Sara', 5, 'Anteprima coi fiocchi', 'Spaghetti al polpo perfetti, sapore deciso del mare.'),
(5, 'Marco', 4, 'Croccante al punto giusto', 'Polpetti leggeri e dorati, niente unto, davvero buoni.'),
(6, 'Elena', 5, 'Luciana da standing ovation', 'Polpo morbidissimo e sugo di pomodoro eccezionale.'),
(7, 'Federico', 4, 'Crudo fresco', 'Polpo freschissimo e presentazione curata.'),
(8, 'Chiara', 5, 'Risotto da incorniciare', 'Mantecatura perfetta e polpo abbondante.'),
(9, 'Andrea', 4, 'Guazzetto ottimo', 'Sugo saporito, ottimo da fare la scarpetta.'),
(10, 'Valentina', 5, 'Sequel migliore dell''originale', 'Polpo tenero dentro e croccante fuori, da rifare.'),
(11, 'Tommaso', 5, 'Polpo al sale impeccabile', 'Cottura perfetta, carne morbidissima e saporita.'),
(12, 'Giorgia', 4, 'Ottimo antipasto', 'Porzione abbondante e ben assortita, polpo in tutte le salse.'),
(13, 'Lorenzo', 5, 'Linguine favolose', 'Pasta al dente e polpo generoso, vale ogni centesimo.'),
(14, 'Beatrice', 4, 'Panino sfizioso', 'Polpo scottato delizioso, maionese alle erbe azzeccata.'),
(15, 'Simone', 5, 'Tartare fresca', 'Polpo di ottima qualità, agrumi bilanciati.'),
(16, 'Alessia', 4, 'Piatto abbondante', 'Perfetto da condividere, polpo in tutte le preparazioni.'),
(17, 'Nicola', 4, 'Agrodolce equilibrato', 'Marinatura bilanciata, polpo tenero e saporito.'),
(18, 'Francesca', 5, 'Brace perfetta', 'Grigliatura sulla brace impeccabile, sapore intenso del mare.'),
(19, 'Pietro', 5, 'Dolce fine perfetto', 'Tiramisù leggero e profumato di limone.'),
(20, 'Roberta', 4, 'Cheesecake golosa', 'Cremosa al punto giusto, lime ben dosato.'),
-- Nuove recensioni: prodotto 6 (Polpo alla Luciana) → media ~1.8 stelle
(6, 'Gianluca', 1, 'Delusione totale', 'Polpo duro come una gomma, il guazzetto sapeva di acqua.'),
(6, 'Miriam', 1, 'Peggio di così non si può', 'Freddo, scotto e servito in ritardo. Non ci torno.'),
(6, 'Stefano', 1, 'Errore di casting', 'Il polpo era gommoso e il pomodoro acidissimo. Rimpiango il pane.'),
(6, 'Carla', 2, 'Mi aspettavo di meglio', 'Presentazione okay ma sapore assente. La Luciana piange.'),
(6, 'Renato', 1, 'Scena madre... del disastro', 'Ho aspettato 40 minuti per un polpo che sembrava un lastrico.'),
-- Nuove recensioni: prodotto 9 (Polpo in Guazzetto) → media ~1.7 stelle
(9, 'Dario', 1, 'Ciak si gira... male', 'Il polpo aveva la consistenza del cartone bagnato.'),
(9, 'Federica', 1, 'Guazzetto imbevibile', 'Sembrava acqua sporca con qualcosa dentro. Non sono sicura cosa.'),
(9, 'Alberto', 2, 'Mi sono pentito', 'Odore strano, sapore piatto. Il pane era buono però.'),
(9, 'Lucia', 1, 'Che delusione', 'Il polpo era crudo a metà. Ho contato i tentacoli per consolarmi.'),
(9, 'Massimo', 1, 'Roba da film horror', 'Non so come descriverlo senza perdere l''appetito.'),
-- Nuove recensioni: prodotto 1 (Polpo Arrosto) → media 4.8 stelle
(1, 'Isabella', 5, 'Esperienza mistica', 'Ho pianto dalla bontà. Il polpo era talmente buono che ho chiesto il bis tre volte.'),
(1, 'Roberto', 5, 'Director''s Cut meritato', 'Non esiste versione migliore di questo polpo. Capolavoro assoluto.'),
(1, 'Paola', 5, 'Tornerei solo per questo', 'Cottura perfetta, sapore intenso. Questo è il motivo per cui esiste la ristorazione.'),
-- Nuove recensioni: prodotto 13 (Linguine al Polpo) → media 5 stelle
(13, 'Cristina', 5, 'Commozione totale', 'Le migliori linguine della mia vita. Ho fatto i complimenti allo chef cinque volte.'),
(13, 'Emanuele', 5, 'Gran finale guadagnato', 'Polpo abbondante, pasta al dente, sugo equilibrato. Perfezione.'),
(13, 'Sofia', 5, 'Non avevo parole', 'È esattamente come descrivono: un gran finale. Non finiva mai e speravi non finisse.'),
(13, 'Matteo', 5, 'Ordinerò sempre questo', 'Da quando l''ho provato non riesco a ordinare altro. È un problema serio.'),
-- Nuove recensioni: prodotto 21 (Polpo con Otto Scuse) → media 5 stelle
(21, 'Veronica', 5, 'Otto tentacoli, zero rimpianti', 'Fritto leggero e croccante. Ogni tentacolo era una scusa per ordinarne altri.'),
(21, 'Claudio', 5, 'Non avevo scuse per non mangiarlo', 'Irresistibile. Ho finito il piatto in silenzio, con gli occhi chiusi.'),
(21, 'Anna', 5, 'Comico nel nome, serio nel gusto', 'Il nome fa ridere, il sapore fa piangere di gioia.'),
-- Nuove recensioni: prodotto 22 (Polpo in Crisi d'Identità) → media 1 stella
(22, 'Franco', 1, 'La crisi l''ho avuta io', 'Anche io non sapevo cosa stavo mangiando. E non era un complimento.'),
(22, 'Serena', 1, 'Identità: piatto scadente', 'Il polpo era gommoso, il sugo indefinito. La crisi d''identità era la mia.'),
(22, 'Giorgio', 1, 'Avrei dovuto ordinare altro', 'Il nome mi aveva avvertito. Non ho ascoltato. Errore imperdonabile.'),
-- Nuove recensioni: prodotto 3 (Panino Cult Assoluto) → media ~4.7 stelle
(3, 'Elisa', 5, 'Culto giustificato', 'Il panino più buono della mia vita. Non è un''esagerazione.'),
(3, 'Antonio', 5, 'Ogni volta che passo di qui', 'Lo ordino sempre. Non ho mai avuto il coraggio di provare altro.'),
-- Nuove recensioni: prodotto 23 (Polpo Mimetico alla Griglia)
(23, 'Vanessa', 4, 'Si vede che è fresco', 'Ottima cottura, anche se il polpo sembrava ancora sorpreso di essere lì.'),
(23, 'Enrico', 5, 'Mimetico ma buonissimo', 'Non si nascondeva bene nel piatto, per fortuna. Sapore eccezionale.'),
-- Nuove recensioni: prodotto 24 (Polpo del Lunedì Mattina) → media ~2.5 stelle
(24, 'Sabrina', 2, 'Ha il sapore del lunedì', 'Non male ma non entusiasmante. Un po'' come tornare in ufficio.'),
(24, 'Marco R.', 3, 'Umoralmente instabile, come promesso', 'A volte buono, a volte così così. Forse dipende dall''umore del polpo.'),
-- Nuova recensione: prodotto 25 (Il Polpo che Non Voleva Essere Mangiato)
(25, 'Leonardo', 5, 'Lo capisco, ma lo mangio lo stesso', 'Spoiler confermato: viene mangiato. E giustamente. Era ottimo.');
