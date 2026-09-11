Tu es un architecte logiciel Senior spécialisé en Flutter, https://github.com/etienne500/camschool_baas_flutter (pour le backend)

Je veux code une application mobile (dans projet flutter suivant C:\laragon\www\Louanges\louanges) avec une interface API qui sera dans le projet commercial. L'application mobile et le panel d'administration du super admin, il devra avoir un onglet de temps pour me permettre de gérer l'application. Donc, on doit simplement pouvoir ajouter des livres de chants qui sont sous la forme PDF, voilà. Sachant que chaque chant à l'intérieur est identifié par un numéro et par un titre, voilà. Donc, au niveau de l'application mobile, lorsqu'on ajoute le PDF, on doit ajouter le PDF côté admin, l'administrateur ajoute le PDF, et côté mobile, le PDF doit être visible. Le PDF doit être visible. Il doit avoir un endroit où on a la possibilité de faire la recherche, et la recherche doit s'effectuer dans tous les PDF. On doit pouvoir rechercher un chant, soit par le numéro, soit par le titre, et la recherche se fait dans tous les PDF. Et l'utilisateur doit avoir la possibilité de dire qu'il veut rechercher uniquement dans un PDF particulier, soit par numéro, soit par titre. Et la recherche doit se faire en ignorant la casse et en ignorant aussi les caractères accentués. Et le PDF, et lorsqu'on fait la recherche (a chaque que on entre un carractère dans le champs de recherche tu actualise la recherche et affiche les resultat, n'attend pas que le user finnise d'écrire et valide pour afficher les resultat), lorsque le chant qui sera trouvé, qu'on clique dessus, ça doit ouvrir le PDF en ouvrant exactement au niveau de la portion où le chant se trouve en question. Donc, ça doit ouvrir directement l'endroit. Donc, on doit pouvoir effectuer toutes ces actions-là. Et l'application mobile doit être une application avec une version dark, une version white mode, en anglais et en français. Et on doit pouvoir ajouter ces livres de chants. Il est possible qu'il y ait des chants qui ont la version anglaise et la version française en même temps, on doit pouvoir les ajouter. Et tu vas t'inspirer des images que je vais te donner pour construire, pour t'inspirer de ça, pour voir la qualité des composants que tu vas créer. Dans tous les cas, la charte graphique que tu vas créer, je veux que ce soit assez joli, des interfaces assez soft, avec des animations lors de la navigation et un peu de partout qui est de la navigation. Et je veux qu'il y ait une page des paramètres où on aura la possibilité de changer la langue, de changer le thème de l'application, et une page à propos où on aura la possibilité de voir toutes les informations concernant l'application et peut-être le numéro du support, et peut-être un bouton. Et toutes ces informations-là, c'est l'administrateur, le super administrateur qui va les remplir à partir du panel d'administration. On doit pouvoir mettre un système de mise à jour, un système de mise à jour, que ce soit pour les téléphones Android, que ce soit pour les téléphones iOS, qui contiendra le numéro de la version, qui contiendra le lien de la mise à jour, et qui contiendra aussi un champ qui sera booléen, juste pour dire si la mise à jour est requise ou si elle est optionnelle. Donc tu vas mettre un système de mise à jour comme ça entre l'API et le serveur, entre le mobile et le serveur. Donc à chaque fois qu'il y aura une mise à jour, c'est l'administrateur qui va venir ajouter la mise à jour, et le mobile va avoir cela en fonction de si elle est requise, le pop-up va s'afficher avec un bouton pour télécharger la nouvelle version. Et lorsque l'utilisateur clique dessus, ça va rediriger vers le lien que l'administrateur aura mis, voilà. Donc pour ce système aussi, tu vas prévoir des champs en anglais et en français, sachant que ce sera dans les deux langues. L'application doit être assez flexible, avoir un splash screen qui dure trois secondes. Qui dure environ trois secondes. Et avant cela, il doit avoir trois pages de onboarding qui ne s'ouvrent que lorsque on ouvre l'application pour la première fois. Et il doit avoir, côté, il doit avoir... L'application doit être rapide, fluide, avoir des animations assez jolies à voir. Et la majorité des éléments doivent être customisables depuis le panel d'administration. Et il doit avoir des tab menus, des tab menus pour tous les items du menu. Et aussi il y aura dans la page à propos, un bouton pour permettre à tous ceux qui aimeraient faire un don pour nous soutenir, de pouvoir payer, de pouvoir faire le don en question. L'application doit être assez flexible, donc à chaque fois que je veux ajouter ou retirer un livre de chants, à partir du panel d'administration, je dois pouvoir le faire.


On va utiliser les moyens de paiement qui sont dans C:\laragon\www\kmrshop_web\resources\views\seller\subscription\payment.blade.php (mais les paiement seront initier sur le mobile), que ce soit pour les paiements par orange, mtn money, carte ou par PayPal. Et à l'entrée, chaque utilisateur doit pouvoir renseigner le nom, le prénom, a partie de son adresse IP. Donc, il doit pouvoir s'inscrire sans avoir besoin de renseigner le mot de passe, sans avoir besoin de renseigner un mot de passe, il doit pouvoir s'inscrire. Et si lors de l'inscription sur le compte que ces informations existent déjà en base de données, on l'authentifie directement, puisqu'on sait que le compte est créé. Donc, on doit pouvoir l'authentifier, il doit, l'utilisateur doit être connu. Et lorsqu'il fait un don, on doit pouvoir savoir que c'est tel utilisateur qui a effectué le don. Et aussi, on va mettre un endroit où, depuis le panel d'administration, on va mettre un lien au groupe WhatsApp, pour tous ceux qui voudraient intégrer la communauté, pour rejoindre directement la communauté via le lien. Et au niveau du dashboard du super administrateur, parce que c'est le super administrateur qui doit pouvoir manager cette application, il doit avoir une case supplémentaire pour la gestion de cette application.

on doit pouvoir mettre et enlever les musique en favorie et quand on clique dessus cela ouvre le pdf a l'androit même


n'importe qui doit avoir la possibilité d'ajouter un livre de chant et dans ce cas l'administrateur valide d'abord avant que cela soit visible au grand public. tu vas mettre le boutton "ajouter un livre de chant et recevez une récompense si elle est valide" doit être au dessus de la liste des livres des chants qui est dans la home page et presice dans le formulaire que tu ne prend que les pdf.
(Donc ajout super admin = publié direct, ajout public = en attente de validation)


on ne doit pas demander a l'utilisateur de s'incrire des le deport ce n'est que lorsqu'il fait une recherche qu'il trouve et qu'il ouvre le pdf que tu lui ouvre un popup avec le formulaire pourqu'il entre ces information nom prenom telephone et photo de profil avec le champs indicateur pays et ville remplit automatiquement car tu connais déjà son IP. NB : le popup ne s'ouvre que ce user n'est pas encore authentifié mais si celui si est déjà authentifier n'ouvre jamais ce popup

Et sache que tout doit être gardé dans le cache de manière à ce que même sans connexion on puisse tout faire dans cette applications qui va s'appeler "Louanges"

On ne va pas utiliser les OTP.

si possible tu me donne la possibilité de générer une PWA pour d'autres utilisateurs.





plus en detail :

# Cahier des charges — Application "Louanges"

**Stack :** App mobile Flutter (`C:\laragon\www\Louanges\louanges`) + API https://github.com/etienne500/camschool_baas_flutter

---

## 1. Vue d'ensemble

Application mobile de recueils de chants (livres de chants au format PDF), avec une partie
d'administration pour les users donc le role est admin, recherche instantanée dans les PDF, mode hors-ligne complet, dons, et système de contribution communautaire.

---

## 2. Modèle de données (résumé fonctionnel)

### 2.1 Livre de chants (Songbook)
- Titre, langue(s) disponibles (FR / EN / les deux)
- Fichier(s) PDF (un PDF par langue si le livre existe en FR et EN)
- Statut : `publié` / `en attente de validation` / `rejeté`
- Auteur de l'ajout : `super_admin` ou `utilisateur public` (avec référence à l'utilisateur)
- Date d'ajout, date de validation

### 2.2 Chant (Song)
- Numéro (identifiant dans le livre)
- Titre
- Livre parent
- Langue
- **Position dans le PDF** (page ou coordonnée) permettant l'ouverture directe — voir §5.3

### 2.3 Utilisateur mobile
- Nom, prénom, téléphone, photo de profil
- Pays, ville (auto-remplis via IP comme dans C:\laragon\www\kmrshop_web\resources\views\auth\register.blade.php tu vas t'inspirer de cela pour detecter le pays et la ville et mettre le drapeau du pays en question.)
- Statut : authentifié / anonyme
- Favoris (liste de chants)
- Historique des dons

### 2.4 Mise à jour app (App Update)
- Plateforme (Android / iOS)
- Numéro de version
- Lien de mise à jour (store ou lien direct)
- `requise` (booléen)
- Champs de description en FR et EN

### 2.5 Paramètres app (pilotés depuis l'admin)
- Textes de la page "À propos" (FR/EN)
- Numéro de support
- Lien du groupe WhatsApp
- code html/css/js qui seront afficher dans la page a propos.
- Éléments visuels/thème personnalisables

tu vas faire un pull chaque 5 minutes en background car cela sera souvent mis à jour dans le serveur.
---

## 3. Application mobile (Flutter)

### 3.1 Démarrage
- **Splash screen** : ~3 secondes
- **Onboarding** : 3 écrans, affichés uniquement au tout premier lancement (flag stocké en local)
- Chargement initial : mise en cache des données essentielles pour usage hors-ligne

### 3.2 Accueil (Home)
- Liste des livres de chants publiés
- Bouton **"Ajouter un livre de chant et recevez une récompense si elle est valide"** positionné au-dessus de la liste
  - Ouvre un formulaire d'ajout (titre, langue, sélection de fichier — **PDF uniquement**, message explicite dans le formulaire)
  - L'ajout est envoyé en statut "en attente de validation"
- Barre de recherche (voir §3.3)

### 3.3 Recherche
- Recherche **en temps réel** : chaque caractère saisi déclenche une nouvelle recherche (pas d'attente de validation) (la recherche doit s'éffectuer comme si vous faisiez un Ctrl+F)
- Recherche par **numéro** ou par **titre** du chant  (la recherche doit s'éffectuer comme si vous faisiez un Ctrl+F)
- Recherche insensible à la **casse** et aux **accents** (normalisation côté recherche, ex. "é" = "e")
- Portée de recherche :
  - Par défaut : recherche dans **tous les PDF/livres**
  - Option pour restreindre la recherche à **un livre précis**
- Résultat cliquable → ouvre le PDF **directement à la page/position du chant** (voir §5.3)
- Si l'utilisateur n'est pas authentifié : ouverture du **popup d'inscription légère** avant l'ouverture effective du PDF (voir §3.6)

### 3.4 Favoris
- Ajouter/retirer un chant des favoris
- Clic sur un favori → ouverture du PDF directement à la position du chant (même comportement que la recherche)

### 3.5 Thème et langue
- Page **Paramètres** :
  - Changement de thème : Dark / Light (prendre automatiquement les paramètres du téléphone)
  - Changement de langue : FR / EN (prendre automatiquement les paramètres du téléphone)
- Persisté en local (et éventuellement au profil utilisateur si authentifié)

### 3.6 Authentification légère (sans mot de passe, sans OTP)
- **Aucune inscription demandé au lancement.**
- Le popup d'inscription s'affiche uniquement si l'utilisateur **n'est pas encore authentifié**, au moment où il clique sur un résultat de recherche pour ouvrir un PDF
- Une fois authentifié, ce popup ne s'affiche plus jamais
- Formulaire du popup : nom, prénom, téléphone, photo de profil, pays et ville.
- Pas de mot de passe, pas d'OTP
- **Logique de reconnaissance** : à la soumission du formulaire, on vérifie si un compte existe déjà avec le mêmes numéro de téléphone. Si oui → connexion directe au compte existant. Si non → création d'un nouveau compte.
  - ⚠️ Point de vigilance : identifier un utilisateur uniquement par nom/prénom/téléphone (sans OTP) reste plus fiable que via l'IP seule.

### 3.7 Page "À propos"
- Contenu entièrement piloté depuis l'admin (FR/EN)
- Numéro de support
- Bouton de don (voir §4)
- Lien vers le groupe WhatsApp 

### 3.8 Mode hors-ligne
- Mise en cache locale des livres/PDF déjà consultés pour permettre aux utilisateurs de manipuler et de lire les livres de chants exactement comme
s'il y'avait toujours la connexion.
- Favoris, paramètres, langue, thème disponibles hors-ligne
- Synchronisation automatique dès que la connexion revient

### 3.9 Système de mise à jour
- À chaque lancement, l'app interroge l'API pour connaître la dernière version disponible (par plateforme)
- Si `requise = true` et version locale < version distante → popup **bloquant** avec bouton de téléchargement (redirection vers le lien fourni par l'admin)
- Si `requise = false` → popup informatif, "ignorable"
- Textes du popup en FR/EN

### 3.10 Charte graphique
- Interfaces "soft", animations de transition entre écrans et sur les interactions (tab menus, navigation, etc.)
- Basée sur les images de référence que vous fournirez
- Dark mode et Light mode complets

---

## 4. Dons et paiements

- Paiements **initiés depuis le mobile**, en réutilisant les moyens de paiement déjà configurés dans `kmrshop_web` (tu vas étudier `C:\laragon\www\kmrshop_web/resources/views/seller/subscription/payment.blade.php` et t'inspirer de ce que y est fait pour le faire aussi sur le mobile tu vas prendre les images qui y sont pour les reutiliser sur le mobile) : **Orange Money, MTN Money, Carte bancaire, PayPal** 
- Chaque don est associé à l'utilisateur authentifié (nom, prénom, téléphone) → historique des dons traçable
- Montants/devises des dons : Fcfa

---

## 5. l'administration va pouvoir :

### 5.1 Nouvel onglet "Louanges"
Une section dédiée dans le dashboard existant du super admin **Louanges**, comprenant :

- **Gestion des livres de chants** : ajout, édition, suppression, upload PDF, gestion des chants (numéro + titre) et de leur position dans le PDF
- **Validation des soumissions publiques** : liste des livres soumis par des utilisateurs, avec actions Valider / Rejeter
  - Gestion de la récompense accordée en cas de validation (nature de la récompense à définir — voir §7)
- **Gestion des mises à jour app** (Android / iOS, version, lien, requise oui/non, FR/EN)
- **Gestion des paramètres app** : textes "À propos", numéro de support, lien WhatsApp, éléments de thème/branding
- **Suivi des dons** : liste des dons avec l'utilisateur associé 
- **Gestion des utilisateurs mobiles** (consultation, éventuellement blocage)

### 5.2 Ajout d'un livre par l'admin
- Publication **directe** (pas de statut "en attente")

### 5.3 Indexation des positions dans le PDF — point technique clé
Pour que l'ouverture d'un chant depuis la recherche/les favoris saute directement à la bonne page, il faut associer chaque chant (numéro et/ou titre) à une **position** dans le PDF (numéro de page a minima, coordonnée idéalement pour plus de précision).

Deux approches possibles, à trancher avec vous (voir §7) :
1. **Saisie manuelle** : l'admin renseigne la liste des chants (numéro, titre, page) au moment de l'upload — fiable, mais plus long pour l'admin.
2. **Extraction automatique** : le système tente de détecter automatiquement les numéros/titres et leur page via extraction de texte du PDF — rapide pour l'admin, mais ne fonctionne que si les PDF contiennent du texte réel (pas des scans/images), et nécessite un algorithme de détection robuste.

---

dans le mobile on doit pouvoir rechercher (numéro/titre, insensible casse/accents, avec ou sans filtre par livre)
même sans connexion on doit pouvoir faire la recherche directement sur les pdf qui sont
en local Donc la recherche ne doit pas se faire via API mais seulement dans le mobile.
Dans un pdf ouvert on doit pouvoir aussi faire une recherche d'un mot ou expression cette recherche
doit être : insensible casse/accents

## 6. API (https://github.com/etienne500/camschool_baas_flutter)

Principaux endpoints à prévoir :
- CRUD Livres de chants + upload PDF
- Authentification légère (création/reconnaissance de compte sans mot de passe)
- Favoris (ajout/suppression, par utilisateur)
- Soumission publique de livre + validation admin
- Dons (initiation, confirmation, historique)
- Mises à jour app (lecture de la dernière version par plateforme)
- Paramètres app (lecture publique côté mobile, écriture côté admin)

---

## 7. Points restant à trancher avec vous

| # | Sujet | Question |
|---|---|---|
| 1 | Récompense | Quelle est la nature de la récompense pour un ajout de livre validé (réduction sur don futur, crédit, badge, autre) ? |
c'est une surprise
| 2 | Devise des dons | Quelle(s) devise(s) pour les dons (XAF, EUR, USD...) et montants libres ou prédéfinis ? |
XAF (Fcfa)
| 3 | Indexation PDF | Saisie manuelle des pages par l'admin, ou extraction automatique du texte (voir §5.3) ? |
extraction automatique du texte
| 4 | Stratégie offline | Cache automatique de tout ce qui est consulté, ou téléchargement à la demande par livre ("télécharger pour hors-ligne") ? |
Cache automatique de tout ce qui est consulté.
| 5 | Emplacement admin | sur le même téléphone l'admin doit pouvoir se connecter et faire tout les actions sur la même application |
dans le dashbord du super_admin
| 6 | PWA | Même socle de fonctionnalités que l'app Flutter (recherche, favoris, dons) ou version simplifiée (lecture seule des PDF, sans compte) ? |



même quand un pdf est ouvert on doit pouvoir éffectuer une recherche directement dessus.

les utilisateurs doivent rester permanament connecter sauf s'il se deconnecte lui même.



relis tout ceci et rassure toi que tu as tout fait