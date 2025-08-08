# Projet MAINFRAME

## 📌 Contexte

Le projet MAINFRAME a été réalisé dans le cadre d'une mission confiée par la société **AJCFRAME**, spécialisée dans la vente de produits technologiques. L'objectif est de traiter, stocker, et exploiter des données issues de fichiers séquentiels et d’interagir avec une base de données, tout en mettant en œuvre des traitements COBOL et une interface CICS.

---

## 🧩 Objectifs du projet

Le projet se décline en 4 grandes parties :

### 🗂️ Partie 1 – Importation des nouveaux produits
- Lecture du fichier `PROJET.NEWPRODS.DATA` (fichier CSV semi-structuré).
- Insertion des nouveaux produits dans la base de données après :
  - Formatage des descriptions (capitalisation).
  - Conversion automatique des prix vers le dollar via des taux de change.
  - Prise en compte des devises supplémentaires via une structure évolutive.

### 📦 Partie 2 – Intégration des ventes étrangères
- Lecture et traitement des ventes des fichiers :
  - `PROJET.VENTESEU.DATA` (Europe)
  - `PROJET.VENTESAS.DATA` (Asie)
- Insertion des ventes dans la base.
- Mise à jour automatique du chiffre d'affaires de chaque client.

### 🧾 Partie 3 – Génération des factures
- Extraction des commandes depuis la base vers un fichier `PROJET.EXTRACT.DATA`.
- Génération des factures au format texte (`PROJET.FACTURES.DATA`) en respectant :
  - Un formatage structuré par commande.
  - La conversion des dates en toutes lettres (via un sous-programme).
  - Ajout de la TVA (taux fourni en `SYSIN`) et de la commission.

### 🖥️ Partie 4 – IHM CICS pour l’ajout de pièces
- Interface de saisie sécurisée (authentification via `AJC.EMPLOYE.KSDS`).
- Ajout de pièces dans le fichier `PROJET.NEWPARTS.KSDS`.
- Respect d’une nomenclature stricte pour les ressources CICS (Mapsets, Transactions...).

---

## 🛠️ Outils & Technologies

- **COBOL** (traitement de fichiers et accès base de données)
- **JCL** (soumissions des jobs)
- **DB2** (base de données relationnelle)
- **CICS** (interface utilisateur mainframe)
- **VSAM (KSDS)** pour fichiers indexés
- **SPUFI** pour les scripts SQL
- **PowerPoint** pour la présentation de soutenance

---

## 📋 Gestion de projet

Pour organiser le travail, répartir les tâches et suivre l'avancement du projet, nous avons utilisé **Trello**.  
Un tableau commun a été mis en place dès le début du projet afin de :

- Créer et attribuer les tâches à chaque membre
- Suivre l'état d'avancement (À faire, En cours, Terminé)
- Visualiser les deadlines et les priorités

---

| Membres de l'équipe         | Informations projet          |
|----------------------------|------------------------------|
| FAUCHER Aymeric            | **Organisation** : AJC Formation |
| KALILOU SYLLA Mahamadou   | **Date de début** : 7 août 2025 |
| VERRIER Alexis             | **Date de fin** : 4 septembre 2025 |
