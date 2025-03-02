import 'package:flutter/material.dart';
import 'package:jocco/core/views/providers/page_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/bottom_navigation.dart';
import 'package:jocco/core/views/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late UserProvider userProvider;
  @override
  void initState() {
    userProvider = context.read<UserProvider>();
    Future.delayed(Duration.zero, () {
      userProvider.initMatching();
      userProvider.startMatching(null);
      userProvider.refreshUserLikers(null);
      userProvider.refreshUserMatchs(null);
      userProvider.listenToUserMatching(onError: (err) {
        //: implementation de l'erreur
      });
      userProvider.listenMyLikers();
      userProvider.listenMyMatchs();
      userProvider.listenToUserChat();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(builder: (context, pageProvider, widgets) {
      return CustomScaffold(
        body: pageProvider.currentPage.correspondingPage,
        bottomNavigation: const BottomNavigation(),
      );
    });
  }
}
