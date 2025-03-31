-- Suppression de la base si elle existe
DROP DATABASE IF EXISTS prime_vdo;
CREATE DATABASE prime_vdo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE prime_vdo;

-- Création des tables
CREATE TABLE film (
  id INT  NOT NULL AUTO_INCREMENT,
  nom VARCHAR(100) NOT NULL,
  CONSTRAINT pk_film PRIMARY KEY(id)
) ENGINE=INNODB;

CREATE TABLE acteur (
  id INT NOT NULL AUTO_INCREMENT,
  prenom VARCHAR(100) NOT NULL,
  nom VARCHAR(100) NOT NULL,
  CONSTRAINT pk_acteur PRIMARY KEY(id)
) ENGINE=INNODB;

CREATE TABLE film_has_acteur (
  film_id INT NOT NULL,
  acteur_id INT NOT NULL,
  CONSTRAINT pk_film_has_acteur PRIMARY KEY (film_id, acteur_id)
) ENGINE=INNODB;

-- Ajout des contraintes de clé étrangère
ALTER TABLE film_has_acteur ADD CONSTRAINT fk_acteur FOREIGN KEY (acteur_id) REFERENCES acteur (id);
ALTER TABLE film_has_acteur ADD CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES film (id);

-- Insertion des données
INSERT INTO acteur (id, prenom, nom) VALUES
(1, 'Brad', 'PITT'),
(2, 'Léonardo', 'Dicaprio');

INSERT INTO film (id, nom) VALUES
(1, 'Fight Club'),
(2, 'Once Upon a time in Hollywood');

INSERT INTO film_has_acteur (film_id, acteur_id) VALUES 
(1, 1), 
(2, 1), 
(2, 2);

--  Afficher tous les films de Brad PITT
SELECT f.nom AS film, a.prenom AS acteur_prenom, a.nom AS acteur_nom
FROM film f
JOIN film_has_acteur fha ON f.id = fha.film_id
JOIN acteur a ON fha.acteur_id = a.id
WHERE a.prenom = 'Brad' AND a.nom = 'PITT';

--  Afficher le nombre de films par acteur
SELECT a.prenom AS acteur_prenom, a.nom AS acteur_nom, COUNT(fha.film_id) AS nb_films
FROM acteur a
LEFT JOIN film_has_acteur fha ON a.id = fha.acteur_id
GROUP BY a.id;

--  Ajouter un film : TITANIC
INSERT INTO film (nom) VALUES ('TITANIC');

--  Trouver le film qui n'a pas d'acteur
SELECT f.nom AS film
FROM film f
LEFT JOIN film_has_acteur fha ON f.id = fha.film_id
WHERE fha.acteur_id IS NULL;

--  Associer Leonardo DICAPRIO dans le film TITANIC
INSERT INTO film_has_acteur (film_id, acteur_id) 
SELECT f.id, a.id FROM film f, acteur a
WHERE f.nom = 'TITANIC' AND a.prenom = 'Léonardo' AND a.nom = 'Dicaprio';

--  Afficher tous les films avec leurs acteurs
SELECT f.nom AS film, a.prenom AS acteur_prenom, a.nom AS acteur_nom
FROM film f
JOIN film_has_acteur fha ON f.id = fha.film_id
JOIN acteur a ON fha.acteur_id = a.id
ORDER BY f.nom;

--  Ajouter un acteur TOM CRUISE
INSERT INTO acteur (prenom, nom) VALUES ('TOM', 'CRUISE');

--  Afficher le nombre de films par acteur en incluant TOM CRUISE
SELECT a.prenom AS acteur_prenom, a.nom AS acteur_nom, COUNT(fha.film_id) AS nb_films
FROM acteur a
LEFT JOIN film_has_acteur fha ON a.id = fha.acteur_id
GROUP BY a.id;

-- Afficher les acteurs ayant joué dans 2 films avec HAVING
SELECT a.prenom AS acteur_prenom, a.nom AS acteur_nom, COUNT(fha.film_id) AS nb_films
FROM acteur a
JOIN film_has_acteur fha ON a.id = fha.acteur_id
GROUP BY a.id
HAVING COUNT(fha.film_id) = 2;

--  En moyenne, combien d'acteurs jouent dans un film ?
SELECT ROUND(COUNT(fha.acteur_id) / COUNT(DISTINCT fha.film_id), 4) AS acteur_par_film
FROM film_has_acteur fha;

-- Effacer les 3 tables avec DROP TABLE
DROP TABLE IF EXISTS film_has_acteur;
DROP TABLE IF EXISTS acteur;
DROP TABLE IF EXISTS film;