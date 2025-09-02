# Projet MAINFRAME

## 📌 Contexte

Le projet MAINFRAME a été réalisé dans le cadre d'une mission confiée par la société **AJCFRAME**, spécialisée dans la vente de produits technologiques. L'objectif est de traiter, stocker et exploiter des données issues de fichiers séquentiels et d’interagir avec une base de données, tout en mettant en œuvre des traitements COBOL et une interface CICS.

---

## 🧩 Objectifs du projet

Le projet se décline en 4 grandes parties :

### 🗂️ Partie 1 – Importation des nouveaux produits
- Lecture du fichier `PROJET.NEWPRODS.DATA` (fichier CSV semi-structuré).
- Insertion des nouveaux produits dans la base de données après :
  - Formatage des descriptions (capitalisation).
  - Conversion automatique des prix en dollar via des taux de change.
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

## 🔧 Installation

### 🗂️ Partie 1 – Importation des nouveaux produits

- `PRO15` → Compilation et exécution du programme principal.

### 📦 Partie 2 – Intégration des ventes étrangères

- `JCCONDAT` → Compilation du sous programme de la conversion de la date.

- `JCVENTES` → Compilation du programme principal.

- `JEVENTES` → Exécution du programme principal.

### 🧾 Partie 3 – Génération des factures

- `JCDTEXT` → Compilation du sous-programme affichage date
- `JCEXTRACT` → Compilation et exécution du programme extraction de base de données. Résultat dans `APIX.PROJET.EXTRACT.DATA`

- `JCFACT` → Compilation du programme de création de facture

- `JEFACT` → Exécution du programme de création de facture.
  - En entrée → Le sous-programme `DATETEXT` et le fichier `APIX.PROJET.EXTRACT.DATA`
  - En sortie → Le fichier `APIX1.PROJET.FACTURE.DATA`

### 🖥️ Partie 4 – IHM CICS pour l’ajout de pièces

## Etape 1 - Création des fichiers

 - `JCEMPKSD` → Suppression / Création du fichier EMPLOYEES.KSDS
 - `JCNPTKSD` → Suppression / Création du fichier NEWPARTS.KSDS

 Sur CICS
 
 - `CEDA DEF FILE(USERS1) GROUP(API1)` puis ajouter le fichier EMPLOYEES.KSDS
 - `CEDA INS FILE(USERS1) GROUP(API1)`
 - `CEDA DEF FILE(PARTS1) GROUP(API1)` puis ajouter le fichier NEWPARTS.KSDS
 - `CEDA INS FILE(PARTS1) GROUP(API1)`
 - `CEMT SET FILE(PARTS1) ADD` - on rajoute le droit d'ajouter des lignes au fichier

## Etape 2 - Compilation des Mapsets

 - `JCA1LGMS` → Compilation du MAPSET de login en utilisant en entrée 'BMS(MS1LOG)'
 - `JCA1NPMS` → Compilation du MAPSET d'ajout en utilisant en entrée 'BMG(MS1NPT)'

 Sur CICS

 - `CEDA DEF MAPSET(MS1LOG) GROUP(API1)`
 - `CEDA INS MAPSET(MS1LOG) GROUP(API1)`
 - `CEDA DEF MAPSET(MS1NPT) GROUP(API1)`
 - `CEDA INS MAPSET(MS1NPT) GROUP(API1)`

 Pour tester les MAPS

 - `CECI SEND MAP(MAP1LOG) MAPSET(MS1LOG)`
 - `CECI SEND MAP(MAP1NPT) MAPSET(MS1NPT)`

## Etape 3 - Compilation des programmes

 - `JCA1LOG` → Compilation du programme PGM1LOG
 - `JCA1NPT` → Compilation du programme PG1NPT

Sur CICS

 - `CEDA DEF PROG(PGM1LOG) GROUP(API1)`
 - `CEDA INS PROG(PGM1LOG) GROUP(API1)`
 - `CEDA DEF PROG(PGM1NPT) GROUP(API1)`
 - `CEDA INS PROG(PGM1NPT) GROUP(API1)`

## Etape 4 - Création des transactions

 - `CEDA DEF TRANS(T1E1) GROUP(API1) PROG(PGM1LOG)`
 - `CEDA INS TRANS(T1E1) GROUP(API1)`
 - `CEDA DEF TRANS(T1E2) GROUP(API1) PROG(PGM1NPT)`
 - `CEDA INS TRANS(T1E2) GROUP(API1)`

## Etape 5 - Lancer la transaction

 - `T1E1`

 (T1E2 causera une erreur si lancé sans s'être log auparavant)

## Etape 6 - Insérer les données dans la base

  - `JCTRIM` → Compilation du sous-programme TRIM (utilisé dans INSNPT)
  - `JCINSNPT` → Compilation du programme INSNPT (nécessite le sous-programme TRIM)

  - `JCEINSNPT` → Execution du programme INSNPT, lit en entrée le fichier NEWPARTS.KSDS et l'insère dans la base de données.

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
