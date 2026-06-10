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

-- Prodotti
INSERT INTO products (name, slug, description, price, image)
VALUES
('Polpo Arrosto Director''s Cut', 'polpo-arrosto-directors-cut', 'Polpo arrosto intenso e scenografico, il finale che tutti aspettavano.', 18.50, 'https://picsum.photos/seed/polpo1/600/400'),
('Insalata di Polpo Edizione Restaurata', 'insalata-di-polpo-edizione-restaurata', 'Classico intramontabile rimasterizzato con agrumi e prezzemolo.', 14.00, 'https://picsum.photos/seed/polpo2/600/400'),
('Panino Cult Assoluto', 'panino-cult-assoluto', 'Panino marino con polpo grigliato, salsa della casa e finale da applausi.', 12.50, 'https://picsum.photos/seed/polpo3/600/400'),
('Spaghetti alle Vongole Anteprima Mondiale', 'spaghetti-alle-vongole-anteprima-mondiale', 'Spaghetti con vongole veraci, un debutto che conquista al primo assaggio.', 16.00, 'https://picsum.photos/seed/spaghetti1/600/400'),
('Frittura Mista Backstage', 'frittura-mista-backstage', 'Un dietro le quinte croccante di calamari, gamberi e alici.', 15.50, 'https://picsum.photos/seed/frittura1/600/400'),
('Tagliata di Tonno Scena Madre', 'tagliata-di-tonno-scena-madre', 'Tonno scottato al punto giusto, il momento clou della serata.', 19.00, 'https://picsum.photos/seed/tonno1/600/400'),
('Crudo di Gamberi Trailer', 'crudo-di-gamberi-trailer', 'Un assaggio crudo e raffinato, l''anteprima perfetta prima del piatto principale.', 17.50, 'https://picsum.photos/seed/gamberi1/600/400'),
('Risotto alla Pescatora Colonna Sonora', 'risotto-alla-pescatora-colonna-sonora', 'Risotto cremoso con frutti di mare, la colonna sonora ideale per la cena.', 16.50, 'https://picsum.photos/seed/risotto1/600/400'),
('Cozze alla Marinara Ciak Si Gira', 'cozze-alla-marinara-ciak-si-gira', 'Cozze in guazzetto di pomodoro, pronte sul set in pochi minuti.', 11.00, 'https://picsum.photos/seed/cozze1/600/400'),
('Calamari Fritti Sequel', 'calamari-fritti-sequel', 'Il sequel croccante dei calamari fritti, ancora più gustoso del primo capitolo.', 13.00, 'https://picsum.photos/seed/calamari1/600/400'),
('Branzino al Sale Premiere', 'branzino-al-sale-premiere', 'Branzino in crosta di sale, una prima assoluta da non perdere.', 22.00, 'https://picsum.photos/seed/branzino1/600/400'),
('Antipasto Misto Casting', 'antipasto-misto-casting', 'Una selezione di assaggi di mare, il casting perfetto per iniziare.', 14.50, 'https://picsum.photos/seed/antipasto1/600/400'),
('Linguine all''Astice Gran Finale', 'linguine-allastice-gran-finale', 'Linguine con astice fresco, il gran finale che lascia il pubblico senza parole.', 24.00, 'https://picsum.photos/seed/linguine1/600/400'),
('Panino al Tonno Spin-off', 'panino-al-tonno-spin-off', 'Panino con tonno scottato e maionese alle erbe, lo spin-off del nostro grande classico.', 11.50, 'https://picsum.photos/seed/panino1/600/400'),
('Tartare di Salmone Flashback', 'tartare-di-salmone-flashback', 'Tartare di salmone fresco con agrumi, un flashback di sapori intensi.', 16.00, 'https://picsum.photos/seed/tartare1/600/400'),
('Paella Mixology Set', 'paella-mixology-set', 'Paella di mare ricca e colorata, pensata per essere condivisa come in un set cinematografico.', 18.00, 'https://picsum.photos/seed/paella1/600/400'),
('Acciughe Marinate Cult Movie', 'acciughe-marinate-cult-movie', 'Acciughe marinate al limone, un piccolo cult intramontabile.', 9.50, 'https://picsum.photos/seed/acciughe1/600/400'),
('Gamberoni alla Griglia Stunt Double', 'gamberoni-alla-griglia-stunt-double', 'Gamberoni grigliati al naturale, la controfigura perfetta del piatto principale.', 21.00, 'https://picsum.photos/seed/gamberoni1/600/400'),
('Tiramisù al Limone Titoli di Coda', 'tiramisu-al-limone-titoli-di-coda', 'Un dolce fresco al limone per chiudere lo spettacolo in bellezza.', 7.00, 'https://picsum.photos/seed/tiramisu1/600/400'),
('Cheesecake al Lime Backstage Pass', 'cheesecake-al-lime-backstage-pass', 'Cheesecake al lime cremosa, l''accesso esclusivo al lieto fine.', 7.50, 'https://picsum.photos/seed/cheesecake1/600/400');

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
(6, 2),
(6, 9),
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
(20, 5);

-- Reviews
INSERT INTO reviews (product_id, name, rating, title, content)
VALUES
(1, 'Martina', 5, 'Capolavoro assoluto', 'Cottura perfetta e presentazione da premio.'),
(1, 'Luca', 4, 'Molto scenico', 'Davvero buono, sapore intenso e ben bilanciato.'),
(2, 'Giulia', 5, 'Restauro riuscitissimo', 'Fresco e gustoso, uno dei migliori assaggi della serata.'),
(3, 'Davide', 4, 'Panino da sequel', 'Molto saporito, lo riprenderei volentieri.'),
(4, 'Sara', 5, 'Anteprima coi fiocchi', 'Vongole fresche e sapore deciso, promosso a pieni voti.'),
(5, 'Marco', 4, 'Croccante al punto giusto', 'Frittura leggera, niente unto, davvero buona.'),
(6, 'Elena', 5, 'Tonno perfetto', 'Cottura al sangue come piace a me, sapore eccezionale.'),
(7, 'Federico', 4, 'Crudo fresco', 'Gamberi freschissimi e presentazione curata.'),
(8, 'Chiara', 5, 'Risotto da incorniciare', 'Mantecatura perfetta e frutti di mare abbondanti.'),
(9, 'Andrea', 4, 'Cozze ottime', 'Sugo saporito, ottimo da fare la scarpetta.'),
(10, 'Valentina', 5, 'Sequel migliore dell''originale', 'Calamari teneri e croccanti, da rifare.'),
(11, 'Tommaso', 5, 'Branzino impeccabile', 'Cottura al sale perfetta, carne morbidissima.'),
(12, 'Giorgia', 4, 'Ottimo antipasto', 'Porzione abbondante e ben assortita.'),
(13, 'Lorenzo', 5, 'Astice favoloso', 'Pasta al dente e astice generoso, vale il prezzo.'),
(14, 'Beatrice', 4, 'Panino sfizioso', 'Tonno scottato delizioso, maionese azzeccata.'),
(15, 'Simone', 5, 'Tartare fresca', 'Salmone di ottima qualità, agrumi bilanciati.'),
(16, 'Alessia', 4, 'Paella abbondante', 'Perfetta da condividere, gusto autentico.'),
(17, 'Nicola', 4, 'Acciughe gustose', 'Marinatura equilibrata, non troppo forte.'),
(18, 'Francesca', 5, 'Gamberoni top', 'Grigliatura perfetta, sapore intenso del mare.'),
(19, 'Pietro', 5, 'Dolce fine perfetto', 'Tiramisù leggero e profumato di limone.'),
(20, 'Roberta', 4, 'Cheesecake golosa', 'Cremosa al punto giusto, lime ben dosato.');
