# StatApp-Collaborative-Filtering
ENSAE ParisTech Master Project 2015-2016 "Films Recommendation System by Collaborative Filtering" 

Authors group: CUI Biwei/ DELGADO Claudia/ MIAH Mehdi/ MPELI MPELI Ulrich/ <br />
Tutors group: COTTET Vincent/ SEBBAR Mehdi

## Objectif

Dans ce projet, nous souhaitons recommander des films � un utilisateur au moyen des notes attribu�es par l'ensemble des utilisateurs.
Pour cela, nous avons identifier trois grandes fa�ons de proc�der : 
- par une approche na�ve : recommander les films qui ont obtenus les meilleurs moyennes ; 
- par une approche des plus proches voisins (knn_user) : recommander les meilleurs films parmi les utilisateurs partageant les m�mes go�ts que l'utilisateur final ; 
- par une approche de r�duction (svd) : recommander les films apr�s une d�composition matricielle des notes

## Phases du programme

Pour faire uniquement de la recommandation, allez directement � la phase 5.

### Phase 1 - Nettoyage

Les donn�es originales sont disponibles sur le site de Grouplens : http://grouplens.org/datasets/movielens/

Les modifications apport�es sont : 
- pour le probl�me ml-100k : 
	- suppression des doublons de films (ID des films en doublons : 246 268|297 303|329 348|304 500|573 670|266 680|305 865|876 881|878 1003|1256 1257|309 1606|1395 1607|1175 1617| 1477 1625|1645 1650|1234 1654|711 1658|1429 1680|)
- pour le probl�me ml-1m : 
	- suppression des films pr�sents dans la base des films mais absents de la base des notes (177 films)
	- correction du titre de film "Et Dieu cr�a la femme"

### Phase 2 - Pr�paration des donn�es

Les donn�es n�cessaires � la pr�diction sont g�n�r�es.
```R
# Se placer dans le dossier courant
source("main_preparation.R")
```

### Phase 3 - Analyser les donn�es

Deux fichiers pdf sont g�n�r�s contenant les analyses descriptives des deux probl�mes
```R
# Se placer dans le dossier Analysis
source("pdf_analysis_ml-100k.Rmd")
source("pdf_analysis_ml-1m.Rmd")
```

### Phase 4 - Evaluer les pr�dictions

Pour chaque famille de mod�les, les notes des bases de test sont pr�dites � partir de l'�tude des bases d'apprentissage
```R
# Se placer dans le dossier courant
source("./CrossValidation/main_split.R") pour g�n�rer les datasets et la base vierge

# Remplacer '***' par le nom de la famille de m�thode
source("./***/main_predictionsTest_***.R")
```

### Phase 5 - Recommander

Pour effectuer les recommandations pour un utisateur :
```R
# Se placer dans le dossier courant
source("main.R")
```

### Phase 6 - Tests a posteriori des recommandations

Les recommandations sont test�es selon divers crit�res
```R
# Se placer dans le dossier courant
source("./Tests/main_test_popularitybias.R")
source("./Tests/main_test_robust.R")
```

## Organisation des dossiers

**Analysis**				: analyse les donn�es de chaque probl�me <br />

**CrossValidation** 				: g�n�re les sous-datasets servant � la validation crois�e et la base vierge, contient les donn�es n�cessaires � la pr�diction, g�n�r�es par "main_preparation.R" <br />

**Data**						: contient les donn�es de ml-100k et ml-1m nettoy�es <br />

**NaiveAlgorithms**				: pr�dit et recommande en suivant les algorithmes na�fs <br />

**NeighborhoodBasedAlgorithms**		: pr�dit et recommande en suivant les algorithmes des plus proches voisins <br />

**Results**					: contient les donn�es n�cessaires � la recommandation finale, contient les r�sultats de la validation crois�e � propos de l'estimation de mod�les et de param�tres <br />

**SVD**						: pr�dit et recommande en suivant les algorithmes bas�s sur la d�composition de matrices <br />

**Tests**						: test les m�thodes sur la pr�sence d'un biais de popularit� et sur l'influence des notes sur les recommandations <br />

**Util**						: contient les fonctions les plus utiles

