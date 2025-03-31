--Site pour faire des modele relationnel : https://dbdiagram.io/d

DROP DATABASE if EXISTS zoo;
CREATE DATABASE zoo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE zoo;

CREATE TABLE chat (
	id int NOT NULL auto_increment,
    nom varchar(50) NOT NULL,
    yeux varchar(20) NOT NULL,
    age INT NOT NULL,
    CONSTRAINT pk_chat PRIMARY KEY(id)
) ENGINE=InnoDB;

INSERT INTO chat (nom,yeux,age) VALUES
	("Maine coon","marron",20),
    ("Siamois","bleu",15),
    ("Bengal","marron",20),
    ("Scottish Fold","marron",10)


-- Effacer toute les données : 
Truncate chat;

DELETE * FROM chat where id = 3

UPDATE chat SET nom="Beau gosse de la uit " WHERE id=1

-- Partie 2, afficher des résultats 

-- 2. Afficher le chat avec l'id : 2
SELECT * FROM chat WHERE id = 2;

-- 3. Trier les chats par nom et par âge
SELECT * FROM chat ORDER BY nom, age;

-- 4. Afficher les chats qui vivent entre 11 et 19 ans
SELECT * FROM chat WHERE age BETWEEN 11 AND 19;

-- 5. Afficher le ou les chats dont le nom contient 'sia'
SELECT * FROM chat WHERE nom LIKE '%sia%';

-- 6. Afficher le ou les chats dont le nom contient 'a'
SELECT * FROM chat WHERE nom LIKE '%a%';

-- 7. Afficher la moyenne d'âge des chats
SELECT AVG(age) AS age_moyen FROM chat;

-- 8. Afficher le nombre de chats dans la table
SELECT COUNT(*) AS nb_chat FROM chat;

-- 9. Afficher le nombre de chats avec la couleur des yeux marron
SELECT yeux, COUNT(*) AS nb_chat FROM chat WHERE yeux = 'marron' GROUP BY yeux;

-- 10. Afficher le chat avec la plus petite durée de vie
SELECT * FROM chat ORDER BY age ASC LIMIT 1;

-- 11. Afficher le chat avec la plus longue durée de vie
SELECT * FROM chat ORDER BY age DESC LIMIT 1;

-- 12. Afficher le nombre de chats par couleur des yeux
SELECT yeux, COUNT(*) AS nb_chat FROM chat GROUP BY yeux;

