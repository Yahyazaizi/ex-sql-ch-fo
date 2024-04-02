-- Insertion de données dans la table Personne
INSERT INTO Personne (numPers, nomPers, telephonePers, adressePers, fonctionPers, numPersSup)
VALUES
(1, 'Jean Dupont', '1234567890', '1 rue des Fleurs', 'Directeur', NULL),
(2, 'Marie Martin', '0987654321', '2 avenue des Champs', 'Entraîneur', 1),
(3, 'Pierre Durand', '5678901234', '3 rue des Écuries', 'Vétérinaire', 1),
(4, 'Sophie Dubois', '6789012345', '4 chemin de la Prairie', 'Palefrenier', 2),
(5, 'Éric Lefebvre', '7890123456', '5 rue des Écuries', 'Soigneur', 3);



INSERT INTO Proprietaire (numPers, numCheval, DateAchat, prixAchat)
VALUES
(1, 1, '2023-01-01', 5000),
(2, 2, '2022-12-15', 7000),
(3, 3, '2023-02-28', 6000);


-- Insertion de données dans la table Race
INSERT INTO Race (nomRace, poidsType, tailleType)
VALUES
('Pur-sang', 500, 160),
('Arabe', 450, 155),
('Frison', 600, 165);
-- Ajoutez d'autres données ici...


INSERT INTO Cheval (numCheval, nomCheval, numTatouage, couleurCheval, numChevalPere, numChevalMere, numPersEleveur, nomRace)
VALUES
(1, 'Black Beauty', 'ABC123', 'Noir', NULL, NULL, 4, 'Frison'),
(2, 'Speedy', 'DEF456', 'Marron', NULL, NULL, 5, 'Arabe'),
(3, 'Thunder', 'GHI789', 'Blanc', NULL, NULL, 5, 'Pur-sang');
-- Ajoutez d'autres données ici...

-- Insertion de données dans la table Concours
INSERT INTO Concours (libelleConcours, AnneeConcours, NbrParticipants)
VALUES
('Jumping International', 2023, 50),
('Concours Complet', 2022, 30),
('Dressage élégance', 2023, 40);
-- Ajoutez d'autres données ici...

-- Insertion de données dans la table Croissance
INSERT INTO Croissance (Mois, tailleMois, poidsMois, numCheval)
VALUES
(1, '160cm', '500kg', 1),
(2, '162cm', '510kg', 1),
(3, '165cm', '520kg', 1);
-- Ajoutez d'autres données ici...

-- Insertion de données dans la table ParticipationConcours
INSERT INTO ParticipationConcours (Cheval_numCheval, Concours_libelleConcours, Concours_AnneeConcours, Place)
VALUES
(1, 'Jumping International', 2023, '2ème'),
(2, 'Dressage élégance', 2023, '5ème'),
(3, 'Jumping International', 2023, '3ème');
-- Ajoutez d'autres données ici...
SELECT COUNT(*) AS Nombre_de_chevaux_noir
FROM Cheval
WHERE couleurCheval = 'Noir';
SELECT COUNT(*) AS Nombre_de_chevaux_anglo_arabe
FROM Cheval
WHERE nomRace = 'Anglo-arabe';
SELECT numCheval, nomCheval
FROM Cheval
WHERE numTatouage = 'ABC123';
SELECT COUNT(*) AS Nombre_d_editions_du_concours
FROM Concours
WHERE libelleConcours = 'Concours Dubai';
SELECT SUM(NbrParticipants) AS Nombre_total_de_participants
FROM Concours
WHERE libelleConcours = 'Concours Dubai';
SELECT c.libelleConcours, c.AnneeConcours
FROM Concours c
INNER JOIN ParticipationConcours pc ON c.libelleConcours = pc.Concours_libelleConcours AND c.AnneeConcours = pc.Concours_AnneeConcours
WHERE pc.Place = '1er';
SELECT ch.nomCheval
FROM Cheval ch
INNER JOIN ParticipationConcours pc ON ch.numCheval = pc.Cheval_numCheval

WHERE pc.Concours_libelleConcours = 'Concours de Londres' AND pc.Concours_AnneeConcours = 2018;
SELECT nomPers
FROM Personne
WHERE fonctionPers = 'Directeur';
SELECT COUNT(*) AS Nombre_de_proprietaires
FROM Proprietaire;
SELECT COUNT(*) AS Nombre_de_chevaux_achetes
FROM Proprietaire
WHERE numPers = n6 AND YEAR(DateAchat) = "2020";
SELECT prixAchat 
FROM Proprietaire
WHERE numPers = n1 AND YEAR(DateAchat) = "2020";

SELECT f.Titre, s.NomSession, s.DateDebut, s.DateFin
FROM Formation f
INNER JOIN Session s ON f.IdFormation = s.IdFormation
WHERE s.Ouvert = true;


SELECT f.Titre AS Titre_formation, e.Nom AS Nom_etudiant, e.Prenom AS Prenom_etudiant
FROM Formation f
INNER JOIN Inscription i ON f.IdFormation = i.IdFormation
INNER JOIN Etudiant e ON i.IdEtudiant = e.IdEtudiant
ORDER BY f.Titre;

SELECT 
    SUM(CASE WHEN ModeInscription = 'Distancielle' THEN 1 ELSE 0 END) AS Inscriptions_distancielles,
    SUM(CASE WHEN ModeInscription = 'Présentielle' THEN 1 ELSE 0 END) AS Inscriptions_présentielles
FROM Inscription
WHERE IdFormation = (SELECT IdFormation FROM Formation WHERE Titre = 'Web développement');

SELECT f.Titre, COUNT(*) AS Nombre_inscriptions_distancielles
FROM Formation f
INNER JOIN Inscription i ON f.IdFormation = i.IdFormation
WHERE i.ModeInscription = 'Distancielle'
GROUP BY f.Titre
HAVING COUNT(*) >= 3
ORDER BY COUNT(*) DESC;

SELECT 
    sp.Nom AS Nom_spécialité,
    f.Titre AS Titre_formation,
    f.Durée AS Durée_formation,
    f.Prix AS Prix_formation
FROM Spécialité sp
INNER JOIN Formation f ON sp.IdSpécialité = f.IdSpécialité
WHERE sp.Active = true
ORDER BY sp.Nom DESC;


SELECT f.Titre, COUNT(*) AS Nombre_inscriptions_distancielles
FROM Formation f
INNER JOIN Inscription i ON f.IdFormation = i.IdFormation
WHERE i.ModeInscription = 'Distancielle'
GROUP BY f.Titre
HAVING COUNT(*) >= 3

UNION

SELECT f.Titre, COUNT(*) AS Nombre_inscriptions_présentielles
FROM Formation f
INNER JOIN Inscription i ON f.IdFormation = i.IdFormation
WHERE i.ModeInscription = 'Présentielle'
GROUP BY f.Titre
HAVING COUNT(*) >= 4;

SELECT 
    YEAR(s.DateDebut) AS Année, 
    MONTH(s.DateDebut) AS Mois, 
    SUM(f.Prix) AS Total_prix_payé
FROM Formation f
INNER JOIN Session s ON f.IdFormation = s.IdFormation
GROUP BY YEAR(s.DateDebut), MONTH(s.DateDebut);