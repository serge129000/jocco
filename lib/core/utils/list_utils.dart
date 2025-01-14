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

List<Map<String, String?>> categories = [
  {"title": "Rencontre avec projet enfant", "icon": "Chronometer.png"},
  {"title": "Rencontre sans projet enfant", "icon": "Chronometer-2.png"},
  {"title": "Hébergement", "icon": "Chronometer-3.png"},
  {"title": "Restauration / commerces de bouche", "icon": "Chronometer-4.png"},
  {"title": "Commerces", "icon": "Chronometer-5.png"},
  {"title": "Voyage / Départ à l'étranger", "icon": "Chronometer-6.png"},
  {"title": "Bien-être / médecine douce", "icon": "Chronometer-7.png"},
  {"title": "Immobilier / architecture", "icon": "Chronometer-8.png"},
  {"title": "Sport / diététique", "icon": "Chronometer-9.png"},
  {"title": "Esthétique", "icon": "Chronometer-10.png"},
  {"title": "Technologie", "icon": "Chronometer-11.png"},
  {"title": "Art", "icon": "Chronometer-12.png"},
  {"title": "Nature / Animalier", "icon": "Chronometer-7.png"},
  {"title": "Autre", "icon": null},
];

Map<String, dynamic> firstPremiumData = {
  'index': 1,
  'title': 'Boostez vos likes!',
  'icon': 'boost_like.png',
  'sub':  'Accedez a votre historique de likes sur 48h avec l\'abonnement premium',
  'simple': '25 likes supplementaires pour 24h',
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

Map<String, dynamic> secondPremiumData = {
  'index': 2,
  'title': 'Boostez vos likes!',
  'icon': 'to_back.png',
  'sub':  'Accedez a votre historique de likes sur 48h avec l\'abonnement premium',
  'simple': '5 retours en arriere',
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
