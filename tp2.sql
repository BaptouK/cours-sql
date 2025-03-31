DROP DATABASE IF EXISTS inv_invitation;
CREATE DATABASE inv_invitation CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE inv_invitation;

CREATE TABLE personne (
	pers_id int NOT NULL auto_increment,

    pers_prenom varchar(100) NOT NULL,
    pers_nom varchar(100)  NOT NULL,
    pers_age INT NOT NULL,
    pers_inscription DATE NOT NULL,
    pers_statut TINYINT NOT NULL,
    pers_type ENUM("homme","femme") NOT NULL,
    pers_description text,
    pers_salaire integer NOT NULL,

    CONSTRAINT pk_personne PRIMARY KEY(pers_id)
) ENGINE=InnoDB;

INSERT INTO personne (pers_prenom, pers_nom, pers_age, pers_inscription, pers_statut, pers_type, pers_description, pers_salaire) VALUES
('Brad', 'PITT', 60, '1970-01-01', 1, 'homme', 'lorem ipsum', 2000000),
('George', 'CLONEY', 62, '1999-01-01', 1, 'homme', 'juste beau', 4000000),
('Jean', 'DUJARDIN', 51, '1994-01-01', 1, 'homme', 'brice de nice', 1000000);


-- 2. Afficher le plus gros salaire
SELECT MAX(salaire) AS plus_gros_salaire FROM personne;

-- 3. Afficher le plus petit salaire
SELECT MIN(salaire) AS plus_petit_salaire FROM personne;

-- 4. Afficher le nom de l'acteur avec le plus petit salaire
SELECT prenom, nom, salaire FROM personne ORDER BY salaire ASC LIMIT 1;

-- 5. Afficher le nom de l'acteur avec le plus gros salaire
SELECT prenom, nom, salaire FROM personne ORDER BY salaire DESC LIMIT 1;

-- 6. Afficher le salaire moyen
SELECT AVG(salaire) AS salaire_moyen FROM personne;

-- 7. Afficher le nombre de personnes
SELECT COUNT(*) AS nb_personnes FROM personne;

-- 8. Afficher les acteurs avec un salaire entre 1 000 000 et 4 000 000
SELECT id, prenom, nom, salaire FROM personne WHERE salaire BETWEEN 1000000 AND 4000000;

-- 9. Requête avec UPPER() et LOWER()
-- Convertir le nom en minuscules
SELECT id, prenom, LOWER(nom) AS nom FROM personne;

-- Convertir le nom en majuscules
SELECT id, prenom, UPPER(nom) AS nom FROM personne;

-- 10. Afficher les personnes dont le prénom contient 'bra'
SELECT id, prenom, nom, salaire FROM personne WHERE prenom LIKE '%bra%';

-- 11. Trier par âge les membres
SELECT prenom, nom, age FROM personne WHERE statut = 'membre' ORDER BY age;

-- 12. Afficher le nombre d'acteurs "membre"
SELECT COUNT(*) AS nb_membres FROM personne WHERE statut = 'membre';

-- 13. Afficher le nombre de membres et de non-membres
SELECT statut AS membre, COUNT(*) AS nb_acteur FROM personne GROUP BY statut;
