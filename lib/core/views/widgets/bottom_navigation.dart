import 'package:flutter/cupertino.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/providers/page_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      width: double.infinity,
      decoration: BoxDecoration(color: bottomBackground),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...Pages.values.map((e) =>
              Consumer<PageProvider>(builder: (context, pageProvider, wdg) {
                return GestureDetector(
                  onTap: () {
                    pageProvider.changePage(page: e);
                  },
                  child: Container(
                    height: 46.68,
                    width: 46.68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bottomContainerColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        kIconAssetPath(imageName: e.iconName),
                        color: pageProvider.currentPage == e
                            ? PrimaryColors.white
                            : selectedColor,
                      ),
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }
}
