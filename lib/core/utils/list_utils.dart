import 'package:flutter/material.dart';

List<String> traitsDePersonnalite = [
  'Ambitieux(se)',
  'Créatif(ve)',
  'Empathique',
  'Aventurier(ère)',
  'Organisé(e)',
  'Introverti(e)',
  'Réfléchi(e)',
  'Dynamique',
  'Charismatique',
  'Extraverti(e)'
];

List<String> centresDInteret = [
  'Sport & Fitness',
  'Nature & Plein air',
  'Art & Culture',
  'Technologie',
  'Voyages',
  'Lecture & Écriture',
  'Musique & Concerts',
  'Mode & Design',
  'Cuisine',
  'Cinéma & Séries'
];

const List<String> projectTypes = [
  'Oui, j\'ai un projet défini',
  'Non, je cherche encore'
];

List<Map<String, dynamic>> categories = [
  {
    "title": "Rencontre avec projet enfant",
    "icon": "Chronometer.png",
    "examples": [
      "Discussion autour du désir d'avoir des enfants",
      "Ateliers de préparation à la parentalité",
      "Rencontres pour futurs parents"
    ],
  },
  {
    "title": "Rencontre sans projet enfant",
    "icon": "Chronometer-2.png",
    "examples": [
      "Rencontres pour personnes ne souhaitant pas avoir d'enfants",
      "Groupes de discussions sur les styles de vie sans enfants",
      "Événements sociaux pour célibataires sans projet parental"
    ],
  },
  {
    "title": "Hébergement",
    "icon": "Chronometer-3.png",
    "examples": [
      "Création d'une plateforme de réservation d'auberges",
      "Guide des meilleurs hébergements locaux",
      "Service de gestion d'Airbnb automatisé"
    ],
  },
  {
    "title": "Restauration / commerces de bouche",
    "icon": "Chronometer-4.png",
    "examples": [
      "Lancement d'un food truck spécialisé en cuisine végétarienne",
      "Guide des meilleurs restaurants locaux",
      "Plateforme de réservation de tables"
    ],
  },
  {
    "title": "Commerces",
    "icon": "Chronometer-5.png",
    "examples": [
      "Lancement d'une boutique en ligne pour produits artisanaux",
      "Développement d'une app pour les promotions locales",
      "Création d'un espace de coworking commercial"
    ],
  },
  {
    "title": "Voyage / Départ à l'étranger",
    "icon": "Chronometer-6.png",
    "examples": [
      "Organisation de voyages guidés personnalisés",
      "Service d'accompagnement pour expatriés",
      "Application de gestion des documents de voyage"
    ],
  },
  {
    "title": "Bien-être / médecine douce",
    "icon": "Chronometer-7.png",
    "examples": [
      "Ateliers de méditation en ligne",
      "Création d'un espace de yoga collectif",
      "Service de consultation en naturopathie"
    ],
  },
  {
    "title": "Immobilier / architecture",
    "icon": "Chronometer-8.png",
    "examples": [
      "Plateforme de recherche de logements écologiques",
      "Outil de design d'intérieur interactif",
      "Service de mise en relation avec des architectes"
    ],
  },
  {
    "title": "Sport / diététique",
    "icon": "Chronometer-9.png",
    "examples": [
      "Application de coaching sportif personnalisé",
      "Planificateur de repas équilibrés",
      "Organisation d'événements sportifs locaux"
    ],
  },
  {
    "title": "Esthétique",
    "icon": "Chronometer-10.png",
    "examples": [
      "Création d'une ligne de maquillage naturel",
      "Application de réservation pour soins esthétiques",
      "Tutoriels de maquillage en réalité augmentée"
    ],
  },
  {
    "title": "Technologie",
    "icon": "Chronometer-11.png",
    "examples": [
      "Développement d'une application de gestion de projets",
      "Création d'un système de maison connectée",
      "Lancement d'un outil de productivité pour développeurs"
    ],
  },
  {
    "title": "Art",
    "icon": "Chronometer-12.png",
    "examples": [
      "Plateforme de vente d'œuvres d'art en ligne",
      "Création d'une application d'apprentissage du dessin",
      "Organisation d'expositions virtuelles"
    ],
  },
  {
    "title": "Nature / Animalier",
    "icon": "Chronometer-7.png",
    "examples": [
      "Application de randonnées guidées",
      "Service de garde d'animaux",
      "Plateforme de sensibilisation à la protection de la faune"
    ],
  },
  {
    "title": "Autre",
    "icon": null,
    "examples": [
      "Projets divers ou hors catégorie",
      "Services personnalisés",
      "Projets innovants"
    ],
  },
];


Map<String, dynamic> firstPremiumData = {
  'index': 1,
  'title': 'Boostez vos likes!',
  'icon': 'match.png',
  'sub':  'Accedez a votre historique de likes sur 48h avec l\'abonnement premium',
  'simple': '25 likes supplementaires pour 24h',
  'data': {
    'title': 'Boost de 2 jours',
    'sub': 'Profitez de 48h de visibilite maximale',
    'details': [
      '25 likes supplementaires',
      'Visibilite accrue pour votre profil' ,
      'Historique des likes sur 48h',
      'Disponible pour les membres premium'
    ]
  }
};

Map<String, dynamic> secondPremiumData = {
  'index': 2,
  'title': '5 retours en arrière',
  'icon': 'to_back.png',
  'sub':  'Revenez en arrière jusqu\'à 5 fois pour revoir les profils manqués.',
  'simple': '5 retours en arriere',
  'color': Color(0xffa4c814),
  'data': {
    'title': '5 retours en arrière',
    'sub': 'Ne laissez plus passer une opportunité !',
    'details': [
      '5 retours en arrière',
      'Boost de profil pour plus de visibilité' ,
      'Accès à qui vous a liké',
    ]
  }
};

Map<String, dynamic> thirdPremiumData = {
  'index': 3,
  'title': 'Boostez vos likes!',
  'icon': 'premium.png',
  'sub':  'Accedez a votre historique de likes sur 48h avec l\'abonnement premium',
  'simple': 'Booster son profil pour 24h',
  'data': {
    'title': 'Boost de 2 jours',
    'sub': 'Profitezde 48h de visibilite maximale',
    'details': [
      '25 likes supplementaires',
      'Visibilite accrue pour votre profil' ,
      'Historique des likes sur 48h',
      'Disponible pour les membres premium'
    ]
  }
};
