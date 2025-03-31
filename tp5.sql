
-- 1. Création de la base de données spa
DROP DATABASE IF EXISTS spa;
CREATE DATABASE spa;
USE spa;

-- 2. Création de la table chat
CREATE TABLE chat (
    id INT AUTO_INCREMENT NOT NULL,
    nom VARCHAR(100) NOT NULL,
    yeux_id INT,
    age INT,
	CONSTRAINT pk_chat PRIMARY KEY(id)

);

-- 3. Création de la table couleur
DROP DATABASE IF EXISTS couleur;
CREATE TABLE couleur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

-- 4. Insérer les données
-- Insérer les couleurs
INSERT INTO couleur (nom) VALUES ('marron'), ('bleu'), ('vert');

-- Insérer les chats
INSERT INTO chat (nom, yeux_id, age) VALUES
('Maine coon', 1, 20),
('Siamois', 2, 15),
('Bengal', 1, 18),
('Scottish Fold', 1, 10),
('Domestique', NULL, 21);

-- 5. Afficher les chats avec les couleurs des yeux avec INNER JOIN
SELECT c.id, c.nom, co.nom AS yeux, c.age
FROM chat c
INNER JOIN couleur co ON c.yeux_id = co.id;

-- 6. Afficher les chats avec les couleurs des yeux avec le chat domestique avec LEFT JOIN
SELECT c.id, c.nom, COALESCE(co.nom, 'PAS DE COULEURS') AS yeux, c.age
FROM chat c
LEFT JOIN couleur co ON c.yeux_id = co.id;

-- 7. Afficher le chat qui n'a pas de couleur des yeux
SELECT c.id, c.nom, c.age
FROM chat c
WHERE c.yeux_id IS NULL;

-- 8. Afficher le nombre de chats par couleur des yeux
SELECT co.nom AS couleur, COUNT(c.id) AS nb_chat
FROM chat c
JOIN couleur co ON c.yeux_id = co.id
GROUP BY co.nom;

-- 9. Afficher le nombre de chats par couleur des yeux avec la couleur "vert"
SELECT co.nom AS couleur, COUNT(c.id) AS nb_chat
FROM couleur co
LEFT JOIN chat c ON c.yeux_id = co.id
GROUP BY co.nom;

-- 10. Afficher la moyenne de couleur des yeux attribuée par chat
SELECT AVG(yeux_id IS NOT NULL) AS moyenne_couleur_yeux
FROM chat;