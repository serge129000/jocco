class Filtre {
    final String id;
    final String createdBy;
    final DateTime createdDate;
    final String lastModifiedBy;
    final DateTime lastModifiedDate;
    final double distance;
    final bool filterDistance;
    final int minAge;
    final int maxAge;
    final String genre;
    final dynamic lauchProject;
    final List<dynamic> categories;
    final List<String> centreInterets;
    final List<dynamic> personnalites;

    Filtre({
        required this.id,
        required this.createdBy,
        required this.createdDate,
        required this.lastModifiedBy,
        required this.lastModifiedDate,
        required this.distance,
        required this.filterDistance,
        required this.minAge,
        required this.maxAge,
        required this.genre,
        required this.lauchProject,
        required this.categories,
        required this.centreInterets,
        required this.personnalites,
    });

    Filtre copyWith({
        String? id,
        String? createdBy,
        DateTime? createdDate,
        String? lastModifiedBy,
        DateTime? lastModifiedDate,
        double? distance,
        bool? filterDistance,
        int? minAge,
        int? maxAge,
        String? genre,
        dynamic lauchProject,
        List<dynamic>? categories,
        List<String>? centreInterets,
        List<dynamic>? personnalites,
    }) => 
        Filtre(
            id: id ?? this.id,
            createdBy: createdBy ?? this.createdBy,
            createdDate: createdDate ?? this.createdDate,
            lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
            lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
            distance: distance ?? this.distance,
            filterDistance: filterDistance ?? this.filterDistance,
            minAge: minAge ?? this.minAge,
            maxAge: maxAge ?? this.maxAge,
            genre: genre ?? this.genre,
            lauchProject: lauchProject ?? this.lauchProject,
            categories: categories ?? this.categories,
            centreInterets: centreInterets ?? this.centreInterets,
            personnalites: personnalites ?? this.personnalites,
        );

    factory Filtre.fromJson(Map<String, dynamic> json) => Filtre(
        id: json["id"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        distance: json["distance"],
        filterDistance: json["filterDistance"],
        minAge: json["minAge"],
        maxAge: json["maxAge"],
        genre: json["genre"],
        lauchProject: json["lauchProject"],
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        centreInterets: List<String>.from(json["centreInterets"].map((x) => x)),
        personnalites: List<dynamic>.from(json["personnalites"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdBy": createdBy,
        "createdDate": createdDate.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate.toIso8601String(),
        "distance": distance,
        "filterDistance": filterDistance,
        "minAge": minAge,
        "maxAge": maxAge,
        "genre": genre,
        "lauchProject": lauchProject,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "centreInterets": List<dynamic>.from(centreInterets.map((x) => x)),
        "personnalites": List<dynamic>.from(personnalites.map((x) => x)),
    };
}
