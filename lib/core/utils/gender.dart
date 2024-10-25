import 'package:jocco/core/utils/all_text.dart';

enum Gender {
  male(name: AllText.male, correspondingImage: 'male.png'),
  female(name: AllText.female, correspondingImage: 'female.png'),
  tous(name: AllText.toutGender, correspondingImage: null);
  
  const Gender({required this.name, required this.correspondingImage});
  final String name;
  final String? correspondingImage;
}