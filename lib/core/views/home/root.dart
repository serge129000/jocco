import 'package:flutter/material.dart';
import 'package:jocco/core/views/providers/page_provider.dart';
import 'package:jocco/core/views/widgets/bottom_navigation.dart';
import 'package:jocco/core/views/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, widgets) {
        return CustomScaffold(
          body: pageProvider.currentPage.correspondingPage,
          bottomNavigation: const BottomNavigation(),
        );
      }
    );
  }
}
