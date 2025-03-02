import 'package:jocco/core/utils/all_text.dart';

enum Gender {
  male(name: AllText.male, correspondingImage: 'male.png', symbol: 'H'),
  female(name: AllText.female, correspondingImage: 'female.png', symbol: 'F'),
  tous(name: AllText.toutGender, correspondingImage: null, symbol: '*');

  factory Gender.fromSymbol(_) =>
      Gender.values.where((e) => e.symbol == _ || e.name == _).single;
  const Gender({required this.name, required this.correspondingImage, required this.symbol});
  final String name;
  final String symbol;
  final String? correspondingImage;
}
