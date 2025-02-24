import 'package:firebase_auth/firebase_auth.dart';
import 'package:jocco/core/models/filtre.dart';

import 'projet.dart';

class AppUser {
  final String id;
  final String createdBy;
  final DateTime createdDate;
  final String lastModifiedBy;
  final DateTime lastModifiedDate;
  final String? nom;
  final String? prenom;
  final String? departement;
  final DateTime? dateNais;
  final String? genre;
  final bool parent;
  final String? searchGenre;
  final String? email;
  final String? password;
  final String? phone;
  final Projet? projet;
  final String role;
  final String? profileImage;
  final String? aboutMe;
  final String? notificationToken;
  final String? resetCode;
  final bool enable;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;
  final bool enableNotification;
  final Filtre? filtre;
  final List<String?> images;
  final List<String?> centreInterets;
  final List<String?> personnalites;
  final String? paymentSave;

  AppUser({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.lastModifiedBy,
    required this.lastModifiedDate,
    required this.nom,
    required this.prenom,
    required this.departement,
    required this.dateNais,
    required this.genre,
    required this.parent,
    required this.searchGenre,
    required this.email,
    required this.password,
    required this.phone,
    required this.projet,
    required this.role,
    required this.profileImage,
    required this.aboutMe,
    required this.notificationToken,
    required this.resetCode,
    required this.enable,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
    required this.enableNotification,
    required this.filtre,
    required this.images,
    required this.centreInterets,
    required this.personnalites,
    required this.paymentSave,
  });

  AppUser copyWith({
    String? id,
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    String? nom,
    String? prenom,
    String? departement,
    DateTime? dateNais,
    String? genre,
    bool? parent,
    String? searchGenre,
    String? email,
    String? password,
    String? phone,
    Projet? projet,
    String? role,
    String? profileImage,
    String? aboutMe,
    String? notificationToken,
    String? resetCode,
    bool? enable,
    bool? accountNonExpired,
    bool? accountNonLocked,
    bool? credentialsNonExpired,
    bool? enableNotification,
    Filtre? filtre,
    List<String>? images,
    List<String>? centreInterets,
    List<String>? personnalites,
    String? paymentSave,
  }) =>
      AppUser(
        id: id ?? this.id,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        nom: nom ?? this.nom,
        prenom: prenom ?? this.prenom,
        departement: departement ?? this.departement,
        dateNais: dateNais ?? this.dateNais,
        genre: genre ?? this.genre,
        parent: parent ?? this.parent,
        searchGenre: searchGenre ?? this.searchGenre,
        email: email ?? this.email,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        projet: projet ?? this.projet,
        role: role ?? this.role,
        profileImage: profileImage ?? this.profileImage,
        aboutMe: aboutMe ?? this.aboutMe,
        notificationToken: notificationToken ?? this.notificationToken,
        resetCode: resetCode ?? this.resetCode,
        enable: enable ?? this.enable,
        accountNonExpired: accountNonExpired ?? this.accountNonExpired,
        accountNonLocked: accountNonLocked ?? this.accountNonLocked,
        credentialsNonExpired:
            credentialsNonExpired ?? this.credentialsNonExpired,
        enableNotification: enableNotification ?? this.enableNotification,
        filtre: filtre ?? this.filtre,
        images: images ?? this.images,
        centreInterets: centreInterets ?? this.centreInterets,
        personnalites: personnalites ?? this.personnalites,
        paymentSave: paymentSave ?? this.paymentSave,
      );

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json["id"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"].toString()),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"].toString()),
        nom: json["nom"],
        prenom: json["prenom"],
        departement: json["departement"],
        dateNais: DateTime.tryParse(json["dateNais"].toString()),
        genre: json["genre"],
        parent: json["parent"],
        searchGenre: json["searchGenre"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        projet: json["projet"] == null? null: Projet.fromJson(json["projet"]),
        role: json["role"],
        profileImage: json["profileImage"],
        aboutMe: json["aboutMe"],
        notificationToken: json["notificationToken"],
        resetCode: json["resetCode"],
        enable: json["enable"],
        accountNonExpired: json["accountNonExpired"],
        accountNonLocked: json["accountNonLocked"],
        credentialsNonExpired: json["credentialsNonExpired"],
        enableNotification: json["enableNotification"],
        filtre: json["filtre"] == null? null: Filtre.fromJson(json["filtre"]),
        images: List<String?>.from(json["images"].map((x) => x)),
        centreInterets:
            List<String?>.from(json["centreInterets"].map((x) => x)),
        personnalites: List<String?>.from(json["personnalites"].map((x) => x)),
        paymentSave: json["paymentSave"],
      );

  factory AppUser.fromFirebaseUser({required User user, String? message}) => AppUser(
      id: user.uid,
      createdBy: user.displayName ?? '',
      createdDate: DateTime.now(),
      lastModifiedBy: user.displayName ?? '',
      lastModifiedDate: DateTime.now(),
      nom: user.displayName ?? '',
      prenom: user.displayName,
      departement: null,
      dateNais: null,
      genre: null,
      parent: false,
      searchGenre: null,
      email: null,
      password: null,
      phone: null,
      projet: null,
      role: 'USER',
      profileImage: user.photoURL ?? '',
      aboutMe: null,
      notificationToken: null,
      resetCode: null,
      enable: true,
      accountNonExpired: true,
      accountNonLocked: message == 'Votre compte est verrouillé.'? false: true,
      credentialsNonExpired: false,
      enableNotification: true,
      filtre: null,
      images: [],
      centreInterets: [],
      personnalites: [],
      paymentSave: null);
  Map<String, dynamic> toJson() => {
        "id": id,
        "createdBy": createdBy,
        "createdDate": createdDate.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate.toIso8601String(),
        "nom": nom,
        "prenom": prenom,
        "departement": departement,
        "dateNais": dateNais?.toString(),
        "genre": genre,
        "parent": parent,
        "searchGenre": searchGenre,
        "email": email,
        "password": password,
        "phone": phone,
        "projet": projet,
        "role": role,
        "profileImage": profileImage,
        "aboutMe": aboutMe,
        "notificationToken": notificationToken,
        "resetCode": resetCode,
        "enable": enable,
        "accountNonExpired": accountNonExpired,
        "accountNonLocked": accountNonLocked,
        "credentialsNonExpired": credentialsNonExpired,
        "enableNotification": enableNotification,
        "filtre": filtre?.toJson(),
        "images": List<String?>.from(images.map((x) => x)),
        "centreInterets": List<String?>.from(centreInterets.map((x) => x)),
        "personnalites": List<String?>.from(personnalites.map((x) => x)),
        "paymentSave": paymentSave,
      };
}
