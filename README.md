# SwiftyProtein
42 project swifty protein

# Links

- [Sujet](https://cdn.intra.42.fr/pdf/pdf/6867/fr.subject.pdf)
- [Web service overview](https://www.rcsb.org/pages/webservices)
  - [Fetch](https://www.rcsb.org/pages/webservices/rest-fetch)
  - [Get chemical element](https://www.rcsb.org/pdb/rest/describeHet?chemicalID=13R) https://www.rcsb.org/pdb/rest/describeHet?chemicalID={id}
- [Ligand visualisation online](http://www.rcsb.org/ligand/ATP)
  
# Vocabulary

### Ligand [source Wiki](https://fr.wikipedia.org/wiki/Ligand_(chimie))

Un ligand est un atome, un ion ou une molécule portant des fonctions chimiques lui permettant de se lier à un ou plusieurs atomes ou ions centraux.
 
### PDB: Protein Data Bank [RCSB](http://www.rcsb.org/)

Collection mondiale de données sur la structure tridimensionnelle (ou structure 3D) de macromolécules biologiques : protéines, essentiellement, et acides nucléiques

#### Le code PDB

Chaque modèle est référencé dans la banque par un identifiant unique à 4 caractères, le premier étant toujours un caractère numérique, les trois suivants étant des caractères alphanumériques. Cet identifiant est appelé « code pdb »

#### Le format PDB

Un fichier au format pdb est un fichier texte où chaque colonne possède sa signification : chaque paramètre est positionné de façon immuable. Ainsi, les 6 premières colonnes, c’est-à-dire les 6 premiers caractères pour une ligne donnée, déterminent le champ du fichier. On retrouve par exemple les champs « TITLE_ » (c'est-à-dire le titre de la macromolécule étudiée), « KEYWDS » (les mots-clé de l’entrée), « EXPDTA » qui donne des informations sur la méthode expérimentale employée, « SEQRES » (la séquence de la protéine étudiée), « ATOM__ » ou « HETATM », champs comprenant toutes les informations liées à un atome particulier. Dernier exemple, dans ces derniers champs, le nom de l’atome est décrit par les colonnes 13 à 16 (soit du treizième au seizième caractère de la ligne).

Les lignes « ATOM__ » concernent les acides aminés ou les acides nucléiques, et les lignes « HETATM » sont dédiées aux autres molécules (solvant, substrat, ion, détergent…). Il y a autant de lignes « ATOM__ » et « HETATM » que d’atomes observés par l’expérimentateur, pour une macromolécule ou un complexe donné

Source [Wikipedia](https://fr.wikipedia.org/wiki/Protein_Data_Bank#Le_format_PDB)

### 

# Autres

- Lien de l'image du ligan http://cdn.rcsb.org/etl/ligand/img/{1st-ligan-character}/{ligan-name}/{ligan-name}-270.png
