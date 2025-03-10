import 'package:jocco/core/utils/step_utils.dart';

class Projet {
    final String id;
    final String? createdBy;
    final DateTime?createdDate;
    final String? lastModifiedBy;
    final DateTime?lastModifiedDate;
    final String titre;
    final String description;
    final bool lifeProject;
    final String detailsLifeProject;
    final ProjectTimes? projectTimes;
    final bool canLeave;
    final List<String> categories;

    Projet({
        required this.id,
        required this.createdBy,
        required this.createdDate,
        required this.lastModifiedBy,
        required this.lastModifiedDate,
        required this.titre,
        required this.description,
        required this.lifeProject,
        required this.detailsLifeProject,
        required this.projectTimes,
        required this.canLeave,
        required this.categories,
    });

    Projet copyWith({
        String? id,
        String? createdBy,
        DateTime? createdDate,
        String? lastModifiedBy,
        DateTime? lastModifiedDate,
        String? titre,
        String? description,
        bool? lifeProject,
        String? detailsLifeProject,
        String? delay,
        bool? canLeave,
        List<String>? categories,
    }) => 
        Projet(
            id: id ?? this.id,
            createdBy: createdBy ?? this.createdBy,
            createdDate: createdDate ?? this.createdDate,
            lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
            lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
            titre: titre ?? this.titre,
            description: description ?? this.description,
            lifeProject: lifeProject ?? this.lifeProject,
            detailsLifeProject: detailsLifeProject ?? this.detailsLifeProject,
            projectTimes: projectTimes ?? this.projectTimes,
            canLeave: canLeave ?? this.canLeave,
            categories: categories ?? this.categories,
        );

    factory Projet.fromJson(Map<String, dynamic> json) => Projet(
        id: json["id"],
        createdBy: json["createdBy"],
        createdDate: DateTime.tryParse(json["createdDate"]??''),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.tryParse(json["lastModifiedDate"]??''),
        titre: json["titre"],
        description: json["description"],
        lifeProject: json["lifeProject"],
        detailsLifeProject: json["detailsLifeProject"],
        projectTimes: json['delay'] == null? null: ProjectTimes.fromString(json["delay"] as String),
        canLeave: json["canLeave"],
        categories: List<String>.from(json["categories"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "titre": titre,
        "description": description,
        "lifeProject": lifeProject,
        "detailsLifeProject": detailsLifeProject,
        "delay": projectTimes?.value,
        "canLeave": canLeave,
        "categories": List<dynamic>.from(categories.map((x) => x)),
    };
}
