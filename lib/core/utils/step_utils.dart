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

  static StepJ stepFromValue({required int step}) => StepJ.values.where((stp) => stp.value == step).single;
}
