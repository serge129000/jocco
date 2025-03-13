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
  final Subscription? subscription;
  final int nombreRetour;
  final int nombreLike;
  AppUser(
      {required this.id,
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
      required this.nombreLike,
      required this.nombreRetour,
      required this.subscription});

  AppUser copyWith(
          {String? id,
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
          int? nombreLike,
          int? nombreRetour,
          Subscription? subscription}) =>
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
          nombreRetour: nombreRetour ?? this.nombreRetour,
          nombreLike: nombreLike ?? this.nombreLike,
          subscription: subscription ?? this.subscription);

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
      projet: json["projet"] == null ? null : Projet.fromJson(json["projet"]),
      role: json["role"],
      profileImage: List<String?>.from(json["images"].map((x) => x)).firstOrNull /* json["profileImage"] */,
      aboutMe: json["aboutMe"],
      notificationToken: json["notificationToken"],
      resetCode: json["resetCode"],
      enable: json["enable"],
      accountNonExpired: json["accountNonExpired"],
      accountNonLocked: json["accountNonLocked"],
      credentialsNonExpired: json["credentialsNonExpired"],
      enableNotification: json["enableNotification"],
      filtre: json["filtre"] == null ? null : Filtre.fromJson(json["filtre"]),
      images: List<String?>.from(json["images"].map((x) => x)),
      centreInterets: List<String?>.from(json["centreInterets"].map((x) => x)),
      personnalites: List<String?>.from(json["personnalites"].map((x) => x)),
      paymentSave: json["paymentSave"],
      nombreRetour: json['nombreRetour'] ?? 0,
      nombreLike: json['nombreLike'] ?? 0,
      subscription: json['abonnement'] == null? null: Subscription.fromJson(json['abonnement']));

  factory AppUser.fromFirebaseUser({required User user, String? message}) =>
      AppUser(
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
          accountNonLocked:
              message == 'Votre compte est verrouillé.' ? false : true,
          credentialsNonExpired: false,
          enableNotification: true,
          filtre: null,
          images: [],
          nombreLike: 0,
          nombreRetour: 0,
          centreInterets: [],
          personnalites: [],
          subscription: null,
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
        "projet": projet?.toJson(),
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
        'abonnement': subscription?.toJson()
      };
}

class Subscription {
  final String id;
  final String createdBy;
  final DateTime createdDate;
  final String lastModifiedBy;
  final DateTime lastModifiedDate;
  final dynamic dateExpiration;
  final dynamic idTransaction;
  final int nbBoostRetour;
  final int nbBoostLike;
  final dynamic boostLikeExp;
  final bool boostProfile;
  final dynamic boostProfileExp;
  final bool active;
  final String typeAbonnement;

  Subscription({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.lastModifiedBy,
    required this.lastModifiedDate,
    required this.dateExpiration,
    required this.idTransaction,
    required this.nbBoostRetour,
    required this.nbBoostLike,
    required this.boostLikeExp,
    required this.boostProfile,
    required this.boostProfileExp,
    required this.active,
    required this.typeAbonnement,
  });

  Subscription copyWith({
    String? id,
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    dynamic dateExpiration,
    dynamic idTransaction,
    int? nbBoostRetour,
    int? nbBoostLike,
    dynamic boostLikeExp,
    bool? boostProfile,
    dynamic boostProfileExp,
    bool? active,
    String? typeAbonnement,
  }) =>
      Subscription(
        id: id ?? this.id,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        dateExpiration: dateExpiration ?? this.dateExpiration,
        idTransaction: idTransaction ?? this.idTransaction,
        nbBoostRetour: nbBoostRetour ?? this.nbBoostRetour,
        nbBoostLike: nbBoostLike ?? this.nbBoostLike,
        boostLikeExp: boostLikeExp ?? this.boostLikeExp,
        boostProfile: boostProfile ?? this.boostProfile,
        boostProfileExp: boostProfileExp ?? this.boostProfileExp,
        active: active ?? this.active,
        typeAbonnement: typeAbonnement ?? this.typeAbonnement,
      );

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        dateExpiration: json["dateExpiration"],
        idTransaction: json["idTransaction"],
        nbBoostRetour: json["nbBoostRetour"],
        nbBoostLike: json["nbBoostLike"],
        boostLikeExp: json["boostLikeExp"],
        boostProfile: json["boostProfile"],
        boostProfileExp: json["boostProfileExp"],
        active: json["active"],
        typeAbonnement: json["typeAbonnement"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdBy": createdBy,
        "createdDate": createdDate.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate.toIso8601String(),
        "dateExpiration": dateExpiration,
        "idTransaction": idTransaction,
        "nbBoostRetour": nbBoostRetour,
        "nbBoostLike": nbBoostLike,
        "boostLikeExp": boostLikeExp,
        "boostProfile": boostProfile,
        "boostProfileExp": boostProfileExp,
        "active": active,
        "typeAbonnement": typeAbonnement,
      };
}
