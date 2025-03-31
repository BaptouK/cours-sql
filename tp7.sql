DROP DATABASE if EXISTS CRM;
CREATE DATABASE CRM CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE CRM;

CREATE TABLE client (
	c_id int NOT NULL auto_increment,
    nom_client varchar(100) NOT NULL,
    p_id int NOT NULL,
    CONSTRAINT pk_client PRIMARY KEY(c_id)
) ENGINE=InnoDB;

CREATE TABLE facture (
	f_id int NOT NULL auto_increment,
    num_facture varchar(100) NOT NULL,
    f_date_fac DATE NOT NULL,
    f_date_paiement DATE,
    d_id int NOT NULL,
    CONSTRAINT pk_facture PRIMARY KEY(f_id)
) ENGINE=InnoDB;

CREATE TABLE devis (
	d_id int NOT NULL auto_increment,
    num_devis varchar(100) NOT NULL,
    version int NOT NULL,
    info varchar(100) NOT NULL,
    montant float NOT NULL,
    p_id int NOT NULL,
    CONSTRAINT pk_devis PRIMARY KEY(d_id)
) ENGINE=InnoDB;

CREATE TABLE projet (
	p_id int NOT NULL auto_increment,
    nom_projet varchar(100) NOT NULL,
    c_id int NOT NULL,
    CONSTRAINT pk_projet PRIMARY KEY(p_id)
) ENGINE=InnoDB;

-- Insérer les projets
INSERT INTO projet (p_id, nom_projet, c_id) VALUES
(1, 'Creation de site internet', 1),
(2, 'Logiciel CRM', 2),
(3, 'Logiciel de devis', 3),
(4, 'Site internet ecommerce', 4),
(5, 'logiciel ERP', 2),
(6, 'logiciel Gestion de Stock', 5);

-- Insérer les clients
INSERT INTO client (c_id, nom_client, p_id) VALUES
(1, 'Mairie de Rennes', 1),
(2, 'Neo Soft', 2),
(3, 'Sopra', 3),
(4, 'Accenture', 4),
(5, 'Amazon', 6);

-- Insérer les devis
INSERT INTO devis (d_id, num_devis, version, info, montant, p_id) VALUES
(1, 'DEV2100A', 1, 'Site internet', 3000, 1),
(2, 'DEV2100B', 2, 'Site internet', 5000, 1),
(3, 'DEV2100C', 1, 'Logiciel CRM', 5000, 2),
(4, 'DEV2100D', 1, 'Logiciel devis', 3000, 3),
(5, 'DEV2100E', 1, 'Site internet ecommerce', 5000, 4),
(6, 'DEV2100F', 1, 'logiciel ERP', 2000, 5),
(7, 'DEV2100G', 1, 'logiciel Gestion de Stock', 1000, 6);

-- Insérer les factures
INSERT INTO facture (f_id, num_facture, f_date_fac, f_date_paiement, d_id) VALUES
(1, 'FA001', '2023-09-01', '2023-10-01', 1),
(2, 'FA002', '2023-09-20', NULL, 1),
(3, 'FA003', '2024-02-01', NULL, 3),
(4, 'FA004', '2024-03-03', '2024-04-03', 4),
(5, 'FA005', '2023-03-01', NULL, 5),
(6, 'FA006', '2023-03-01', NULL, 6);


-- Afficher le nombre de factures par client
SELECT c.nom_client, COUNT(f.f_id) AS nombre_factures
FROM facture f
JOIN devis d ON f.d_id = d.d_id
JOIN projet p ON d.p_id = p.p_id
JOIN client c ON p.c_id = c.c_id
GROUP BY c.nom_client;

-- Afficher le chiffre d'affaires par client
SELECT c.nom_client, SUM(d.montant) AS chiffre_affaires
FROM facture f
JOIN devis d ON f.d_id = d.d_id
JOIN projet p ON d.p_id = p.p_id
JOIN client c ON p.c_id = c.c_id
GROUP BY c.nom_client;

-- Afficher le CA total
SELECT SUM(d.montant) AS chiffre_affaires_total
FROM facture f
JOIN devis d ON f.d_id = d.d_id;

-- Afficher la somme des factures en attente de paiement
SELECT SUM(d.montant) AS total_impaye
FROM facture f
JOIN devis d ON f.d_id = d.d_id
WHERE f.f_date_paiement IS NULL;

-- Afficher les factures en retard de paiement avec jours de retard
SELECT f.num_facture, c.nom_client, f.f_date_fac, f.f_date_paiement, 
       DATEDIFF(NOW(), f.f_date_fac) AS jours_retard
FROM facture f
JOIN devis d ON f.d_id = d.d_id
JOIN projet p ON d.p_id = p.p_id
JOIN client c ON p.c_id = c.c_id
WHERE f.f_date_paiement IS NULL AND f.f_date_fac < NOW();

-- Ajouter une pénalité de 2 euros par jour de retard
SELECT f.num_facture, c.nom_client, 
       DATEDIFF(NOW(), f.f_date_fac) AS jours_retard,
       (DATEDIFF(NOW(), f.f_date_fac) * 2) AS penalite
FROM facture f
JOIN devis d ON f.d_id = d.d_id
JOIN projet p ON d.p_id = p.p_id
JOIN client c ON p.c_id = c.c_id
WHERE f.f_date_paiement IS NULL AND f.f_date_fac < NOW();


