import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jocco/core/models/chat.dart';
import 'package:jocco/core/utils/gender.dart';
import 'package:jocco/core/utils/step_utils.dart';

List<Map<String, dynamic>> data = [
  {
    'userImages': [
      'https://plus.unsplash.com/premium_photo-1689551670902-19b441a6afde?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
    'gender': Gender.female,
    'choosen': Gender.male,
    'traits': [
      'Ambitieux(se)',
      'Créatif(ve)',
      'Empathique',
    ],
    'interet': [
      'Sport & Fitness',
      'Nature & Plein air',
      'Art & Culture',
    ],
    'hasProjet': IfProject.no,
    'leaveAll': LeaveAll.yes,
    'children': true,
    'cat': "Voyage / Départ à l'étranger",
    'nom': 'Natacha',
    'age': 25,
    'ville': 'Paris',
    'about': 'Rien a dire sur moi',
    'projet': 'Faire le tour du monde'
  },
  {
    'userImages': [
      'https://images.unsplash.com/photo-1533435137002-455932c8538f?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1522512115668-c09775d6f424?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
    'gender': Gender.female,
    'choosen': Gender.male,
    'traits': [
      'Ambitieux(se)',
      'Créatif(ve)',
      'Empathique',
    ],
    'interet': [
      'Sport & Fitness',
      'Nature & Plein air',
      'Art & Culture',
    ],
    'hasProject': IfProject.no,
    'leaveAll': LeaveAll.yes,
    'children': true,
    'cat': "Voyage / Départ à l'étranger",
    'nom': 'Ines',
    'age': 22,
    'ville': 'Paris',
    'about': 'Rien a dire sur moi',
    'projet': 'Faire le tour du monde'
  }
];

List<Map<String, String>> matchedData = [
  {
    'image':
        'https://plus.unsplash.com/premium_photo-1731950913794-d1d16af06a9d?q=80&w=2485&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'nom': 'Sylvestre',
    'age': 25.toString()
  },
  {
    'image':
        'https://plus.unsplash.com/premium_photo-1665010806447-5f80ee6eb30f?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'nom': 'Valerie',
    'age': 32.toString()
  },
  {
    'image':
        'https://images.unsplash.com/photo-1564494874264-40e25538fef5?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'nom': 'Leana',
    'age': 23.toString()
  },
  {
    'image':
        'https://images.unsplash.com/photo-1582822785550-d465062c62e9?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'nom': 'Adolpha',
    'age': 21.toString()
  },
];

Map<String, dynamic> userData = {
  'nom': 'Richard',
  'prenom': 'Petis',
  'age': 25,
  'image':
      'https://plus.unsplash.com/premium_photo-1731950913794-d1d16af06a9d?q=80&w=2485&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
};
List<Chat> testChats = [
  Chat(message: 'Hello', time: Timestamp.now(), chatStatus: ChatStatus.unread, sender: '0s0ypY2KDwYfqG3N3visC2rFEn73'),
  Chat(message: 'Hello', time: Timestamp.now(), chatStatus: ChatStatus.unread, sender: '0s0ypY2KDwYfqG3N3visC2rFEn73'),
  Chat(message: 'Hello', time: Timestamp.now(), chatStatus: ChatStatus.unread, sender: '0s0ypY2KDwYfqG3N3visC2rFEn73'),
  Chat(message: 'Hello', time: Timestamp.now(), chatStatus: ChatStatus.unread, sender: '0s0ypY2KDwYfqG3N3visC2rFEn73'),
  Chat(message: 'Hello', time: Timestamp.now(), chatStatus: ChatStatus.unread, sender: '0s0ypY2KDwYfqG3N3visC2rFEn73'),
];
