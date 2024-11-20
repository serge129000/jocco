import 'dart:convert';

import 'package:flutter/services.dart';

class CountryJson {
  static Future<List> getcountryData() async {
    final jsonData = await rootBundle.loadString('assets/json/country.json');
    return jsonDecode(jsonData) as List;
  }
}
