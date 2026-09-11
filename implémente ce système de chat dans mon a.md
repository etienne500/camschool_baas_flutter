implémente ce système de chat dans mon application de louange toujours avec flutter 
et https://github.com/etienne500/camschool_baas_flutter 

on doit avoir un forum dans l'application ou tout le monde doit pouvoir intervenir les uns doivent pouvoir pouvoir rechercher qui que ce soit soit par le numéro, nom ou prenom et écrire dans un système de chats complet et aussi pour le support tout ceux qui veulent contact le support tu vas directement ouvrir une discution avec le support tout ces chats et forum doivent être exactement comme whatsapp en toute choses et fonctionnalité vraiment quelque chose de complet ou on pourra envoyer même les media, pdf et documents dans les textes les liens doivent être cliquable quand on ouvre une discution on doit tomber directement ou il y'a les message non lu. une personne ne voit que les messages envoyé a partir de ca date d'inscription dans chaque discution les utilisateurs doivent pouvoir desactiver ou activer le son des notifications, tout les messages recu doivent être garder en local enfin que on ne charge pas a chaque fois  on doit chager uniquement les nouveau messages. quand quelqu'un envoi un message dans le groupe on doit pouvoir voir sa photo et son nom et si on touche l'un des deux, la page de detail de cet utilisateur s'ouvre de la on doit pouvoir agrandir sa photo, l'écrire, voir et faire plusieurs autres chose a partir de cette page de detail, dans le message ou discution on doit pouvoir repondre a un message particulier.



Ce système de messagerie doit être instantanée et quasiment identique à WhatsApp, parfaitement intégré à mon application sans utiliser de services
payant.

Tu dois agir comme un développeur Senior Flutter + Backend + Architecture logicielle.

L'objectif est de produire un code propre, maintenable, sécurisé, performant et évolutif.

implémente ce système de chat dans mon application de louange toujours avec flutter 
et https://github.com/etienne500/camschool_baas_flutter 
---

# Fonctionnalités

Créer exactement les modules suivants.

## 1. Conversations

Liste des conversations

Afficher :

* Photo
* Nom
* Dernier message
* Heure
* Nombre de messages non lus
* Indicateur "épinglé"
* Indicateur "silencieux"

Tri :

* Dernier message reçu
* Conversation épinglée en haut

Recherche instantanée.

---

## 2. Chat individuel

Messages :

* Texte
* Emojis
* Images
* Vidéos
* Audio
* Documents
* PDF
* Word
* Excel
* ZIP
* Contacts
* Position GPS

Réponse à un message

Transfert

Copier

Supprimer

Modifier (15 minutes)

Sélection multiple

Favoris

Recherche dans la conversation

---

## 3. Groupes

Créer un groupe

Modifier :

* Photo
* Nom
* Description

Administrateurs

Permissions :

* Qui peut envoyer
* Qui peut modifier les informations
* Qui peut ajouter des membres

Mention @

Réponse

Suppression

Quitter

Inviter

Lien d'invitation

---

## 4. Statuts

Créer des statuts

Image

Vidéo

Texte

Durée 24h

Voir les vues

Supprimer

Répondre au statut

---

## 5. Appels (préparer l'architecture)

Prévoir :

Audio

Vidéo

Historique

Architecture prête pour WebRTC.

---

## 6. Messages

Types :

Texte

Image

GIF

Sticker

Vidéo

Audio

Document

Position

Contact

Lien

Chaque message possède :

* id
* sender
* receiver
* group_id
* type
* contenu
* fichier
* miniature
* durée
* taille
* localisation
* reply_to
* forwarded
* edited
* deleted
* created_at
* updated_at

---

## 7. États des messages

Supporter :

✓ envoyé

✓✓ livré

✓✓ bleu lu

En temps réel.

---

## 8. Temps réel

Utiliser WebSocket.

Le système doit gérer :

Connexion

Reconnexion automatique

Heartbeat

Retry

Offline

Synchronisation

Queue locale

Aucune perte de message.

---

## 9. Indicateurs

Afficher :

"En ligne"

"Dernière connexion"

"Est en train d'écrire..."

"Enregistre un audio..."

"Choisit une photo..."

"Upload 35%"

---

## 10. Notifications

Push

Notification silencieuse

Notification personnalisée

Groupe

Conversation

Ouvrir directement le chat concerné.

---

## 11. Médias

Compression automatique.

Images

Vidéos

Miniatures

Téléchargement progressif

Cache

Lecture vidéo

Lecture audio

Visionneuse d'image

---

## 12. Audio

Enregistrement

Pause

Reprendre

Lecture

Vitesse x1

x1.5

x2

Waveform

---

## 13. Sécurité

Messages chiffrés.

Validation des accès.

Protection contre :

Spam

Flood

Injection

Accès non autorisés.

Prévoir une architecture compatible avec un chiffrement de bout en bout (End-to-End Encryption), même si celui-ci n'est pas implémenté immédiatement.

---

## 14. Performances

Pagination infinie

Lazy loading

Cache local

Synchronisation intelligente (partout ou les soket ne marchent pas (renvoi une erreur ou ne renvoi pas les bonnes données), fait que la 
synchronisation se fasse même http.)

Optimisation mémoire

Préchargement

Compression

Images adaptées

---

## 15. Hors ligne

L'utilisateur peut :

Lire

Écrire

Créer plusieurs messages

Joindre des fichiers

Tout est synchronisé dès que la connexion revient.

---

## 16. Interface

Je veux une interface très proche de WhatsApp.

Inclure :

Animations

Bulles

Date

Séparateur

Messages regroupés

Swipe Reply

Long Press

Menu contextuel

Recherche

Scroll intelligent

Bouton retour en bas

Chargement progressif

Dark Mode

Light Mode

Responsive

---

## 17. Base de données

Créer toutes les migrations Laravel.

Créer les modèles.

Créer les relations.

Créer les index.

Créer les clés étrangères.

Créer les seeders si nécessaire.

---

## 18. API

Créer une API REST complète.

Créer également tous les événements WebSocket.
partout ou les WebSocket ne marchent pas (renvoi une erreur ou ne renvoi pas les bonnes données), utilise le http pour faire la même chose.

Utiliser les bonnes pratiques Laravel.

Réponses JSON standardisées.

Validation complète.

Gestion des erreurs.

---

## 19. Flutter

Créer :

Models

Repositories

Services

Controllers

Providers

Screens

Widgets

Theme

Navigation

Cache

Architecture propre (Clean Architecture).

---

## 20. Documentation

Pour chaque fonctionnalité :

Expliquer

Documenter

Commenter

Décrire l'architecture

Créer un schéma des flux

Documenter les API

---

## 21. Qualité

Le code doit respecter :

SOLID

Clean Code

Repository Pattern

Service Pattern

DTO

Pagination

Tests unitaires

Tests d'intégration

Architecture évolutive

---

## 22. Livrables attendus

Je ne veux pas seulement du code.

Je veux que tu développes le projet étape par étape :

1. Architecture globale
2. Modélisation de la base de données
3. Migrations Laravel
4. Backend complet
5. API REST
6. WebSockets
7. Notifications Push
8. Flutter (UI + logique)
9. Synchronisation temps réel
10. Tests
11. Optimisations
12. Documentation

À chaque étape :

* explique les choix techniques,
* génère un code complet et directement exécutable,
* n'utilise pas de pseudo-code,
* respecte les conventions Laravel 12 et Flutter les plus récentes,
* propose les fichiers à créer ou modifier avant d'écrire le code,
* attends ma validation avant de passer à l'étape suivante.

L'objectif est d'obtenir un système de chat de qualité professionnelle, aussi fluide et robuste que WhatsApp, tout en restant adapté à une application métier.

tu vas aussi ouvrir le popup d'inscription quand un user veut accéder aux chats sans être authentifié.








relis tout ceci et rassure toi que tu as tout fait
