// ignore_for_file: unused_element

enum StepJ {
  first(name: 'first', value: 1),
  second(name: 'second', value: 2),
  third(name: 'third', value: 3),
  fourth(name: 'fourth', value: 4),
  fifth(name: 'fifth', value: 5),
  sixth(name: 'sixth', value: 6),
  seventh(name: 'seventh', value: 7),
  eighth(name: 'eighth', value: 8),
  ninth(name: 'ninth', value: 9),
  tenth(name: 'tenth', value: 10),
  eleventh(name: 'eleventh', value: 11),
  twelfth(name: 'twelfth', value: 12),
  thirteenth(name: 'thirteenth', value: 13);

  const StepJ({required this.value, required this.name});
  final int value;
  final String name;

  static StepJ stepFromValue({required int step}) =>
      StepJ.values.where((stp) => stp.value == step).single;
}

enum IfProject {
  yes(value: true, name: 'Oui'),
  no(value: false, name: 'Non');

  final bool value;
  final String name;
  const IfProject({required this.value, required this.name});
}

enum ProjectTimes {
  immediately(name: 'Immediatement'),
  sixMonth(name: 'Dans 6 mois'),
  yearAndMore(name: 'Dans 1 ans et plus');

  final String name;

  const ProjectTimes({required this.name});
}

enum LeaveAll {
  yes(value: true, name: 'Oui'),
  no(value: false, name: 'Non');

  final bool value;
  final String name;
  const LeaveAll({required this.value, required this.name});
}

extension BoolExtension on bool {
  String toFrenchString() {
    return this ? "Oui" : "Non";
  }
}
