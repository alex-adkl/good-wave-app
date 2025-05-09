# Good Wave 🌊

Une application iOS moderne pour les surfeurs, permettant de découvrir, partager et suivre les meilleurs spots de surf à travers le monde.

## Fonctionnalités

- 📍 Découverte de spots de surf
- 📸 Partage de nouveaux spots avec photos
- 🌟 Système de notation de difficulté
- 📅 Suivi des saisons optimales
- 🔍 Recherche de spots par localisation
- 📱 Interface utilisateur intuitive et moderne

## Prérequis

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Installation

1. Clonez le repository :
```bash
git clone https://github.com/votre-username/good-wave-app.git
```

2. Installez les dépendances :
```bash
cd good-wave-app
pod install
```

3. Ouvrez le fichier `good-wave.xcworkspace` dans Xcode

4. Configurez votre fichier `Config.xcconfig` avec vos clés API si nécessaire

5. Compilez et exécutez l'application

## Architecture

L'application suit une architecture MVVM (Model-View-ViewModel) :

- **Models/** : Structures de données et modèles
- **Views/** : Interface utilisateur SwiftUI
- **ViewModels/** : Logique métier et gestion d'état
- **App/** : Configuration de l'application

## Structure du Projet

```
good-wave-app/
├── Models/          # Modèles de données
├── Views/           # Vues SwiftUI
├── ViewModels/      # ViewModels
├── App/            # Configuration de l'app
├── Assets/         # Ressources graphiques
└── Tests/          # Tests unitaires et UI
```

## Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## Développeurs

Alexandra Adeikalam
Théo Butz

Lien du projet : [https://github.com/votre-username/good-wave-app](https://github.com/votre-username/good-wave-app)
