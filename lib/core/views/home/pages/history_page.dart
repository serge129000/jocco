import 'package:flutter/material.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/views/home/pages/history_components/history_component_matched.dart';
import 'package:jocco/core/views/home/pages/history_components/recent_likes.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/path.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  void initState() {
    tabController.addListener(() {
      if (tabController.previousIndex != tabController.index) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1 / 0,
      width: 1 / 0,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Image.asset(
                kIconAssetPath(imageName: 'jocco.png'),
                height: 26.35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Consumer<AuthProvider>(
                  builder: (context, authProvider, widgets) {
                return TabBar(
                    onTap: (value) {
                      authProvider.changeHistoryPage(index: value);
                    },
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: PrimaryColors.white,
                    controller: tabController,
                    indicatorWeight: 3.5,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          AllText.matched,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: tabController.index == 0
                                      ? FontWeight.bold
                                      : null,
                                  color: tabController.index == 0
                                      ? Color(0xfff5f5f5)
                                      : PrimaryColors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          AllText.liked,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: tabController.index == 1
                                      ? FontWeight.bold
                                      : null,
                                  color: tabController.index == 1
                                      ? Color(0xfff5f5f5)
                                      : PrimaryColors.white),
                        ),
                      ),
                    ]);
              }),
            ),
            Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: [HistoryComponentMatched(), RecentLikes()]))
          ],
        ),
      ),
    );
  }
}
