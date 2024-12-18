import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:jocco/core/utils/screen.dart';

class PageProvider with ChangeNotifier {
  Pages _currentPage = Pages.home;
  Pages get currentPage => _currentPage;

  void changePage({required Pages page}) {
    HapticFeedback.mediumImpact();
    _currentPage = page;
    notifyListeners();
  }
}
