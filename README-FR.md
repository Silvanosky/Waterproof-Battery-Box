# **🔋 Boîte Étanche Universelle pour Batteries (100% TPU)**

Ce projet propose un modèle OpenSCAD entièrement paramétrique pour générer et imprimer en 3D des boîtes de protection étanches pour vos batteries (18650, 21700, AA, AAA, etc.).  
**La particularité de ce design est qu'il est conçu spécifiquement pour être imprimé en TPU (filament flexible).** Le matériau servant lui-même de joint, la boîte intègre un système de "double joint radial" (dents et rainures) directement dans sa géométrie, éliminant le besoin d'acheter et d'ajouter des joints toriques externes.

## **🌟 Fonctionnalités**

* 💧 **100% Imprimable en TPU** : Pas de joint torique externe requis. L'étanchéité est assurée par la compression du TPU lui-même.  
* 🛡️ **Double Joint Radial Intégré** : Deux anneaux de compression sur la collerette garantissent une barrière infranchissable pour l'eau.  
* 📏 **Universel et Paramétrique** : Sélectionnez facilement la taille de votre batterie dans OpenSCAD (18650, 20700, 21700, 26650, AA, AAA) ou entrez vos propres dimensions.  
* 🪶 **Poids et Temps Optimisés** : Les parois font exactement 1.6mm d'épaisseur. Avec une buse standard de 0.4mm, cela correspond à 4 périmètres parfaits, le ratio idéal pour garantir l'étanchéité sans gâcher de matière.  
* 🤲 **Grip Texturé** : Le corps et le bouchon possèdent une texture en "diamant" (moletage) pour une ouverture/fermeture facile, même avec les mains mouillées ou des gants.

## **🛠️ Prérequis**

Pour ouvrir, modifier et compiler ce modèle, vous avez besoin de :

1. **OpenSCAD** (version 2021.01 ou plus récente recommandée).  
2. **La librairie BOSL2** installée dans votre environnement OpenSCAD.  
   * *Installation de BOSL2* : Téléchargez la librairie depuis le [GitHub officiel de BOSL2](https://github.com/BelfrySCAD/BOSL2) et placez le dossier BOSL2 dans votre dossier de librairies OpenSCAD (Documents/OpenSCAD/libraries/ sur Windows/Mac, ou \~/.local/share/OpenSCAD/libraries/ sur Linux).

## **🚀 Utilisation (OpenSCAD Customizer)**

1. Ouvrez le fichier Waterproof\_Battery\_Box.scad dans OpenSCAD.  
2. Affichez la fenêtre **Customizer** (Menu Window \> Décochez Hide Customizer).  
3. **Sélectionnez votre batterie** : Utilisez le menu déroulant pour choisir un format standard.  
4. **Mode d'Affichage (part)** :  
   * cut : Affiche une vue en coupe simulée pour vérifier l'emboîtement des joints. *(Recommandé pour visualiser la conception).*  
   * both : Affiche la boîte et le bouchon orientés correctement pour l'impression 3D.  
   * box : Affiche uniquement le corps de la boîte pour générer le STL.  
   * cap : Affiche uniquement le bouchon pour générer le STL.  
5. Appuyez sur **F6** pour faire le rendu, puis cliquez sur **"Export as STL"**.

## **🖨️ Recommandations d'Impression (CRITIQUE)**

Le design ne fait pas tout. Si les couches d'impression ne sont pas parfaitement fusionnées, l'eau s'infiltrera inévitablement. Suivez ces paramètres dans votre Slicer (Cura, PrusaSlicer, OrcaSlicer, etc.) :

| Paramètre | Valeur Recommandée | Explication |
| :---- | :---- | :---- |
| **Matériau** | TPU (Dureté 95A ou moins) | Indispensable pour la flexibilité du joint. |
| **Périmètres (Murs)** | 4 minimum | L'étanchéité se fait par l'épaisseur des parois (1.6mm). |
| **Couture (Z-Seam)** | Alignée (Aligned) | *Ne mettez jamais "Aléatoire"*, cela crée des micro-trous. |
| **Température** | Plage haute (ex: 230-235°C) | Garantit une fusion inter-couches absolue. |
| **Débit (Flow)** | 102% à 105% | Bouche les micro-trous et force l'adhérence. |
| **Supports** | Aucun | Le modèle est conçu pour s'imprimer sans support (angles à 45°). |

## **💡 Conseils d'Utilisation**

* **Premier Vissage** : Le premier assemblage peut être un peu dur. Vissez et dévissez le bouchon 3 ou 4 fois rapidement. La friction va chauffer et assouplir le TPU, qui va "faire sa place" dans les rainures.  
* **Lubrification** : Si le vissage reste trop difficile (le TPU contre le TPU accroche énormément), appliquez une micro-goutte de **graisse silicone** sur le filetage. Cela facilitera le mouvement sans abîmer le plastique.
