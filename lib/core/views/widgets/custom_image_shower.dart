import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:jocco/core/utils/color.dart';

class CustomImageShower extends StatelessWidget {
  final String url;
  const CustomImageShower({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1 / 0,
        width: 1 / 0,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: LayoutBuilder(
          builder: (context, constraint) {
            return CachedNetworkImage(
              memCacheHeight: constraint.maxWidth.toInt() *  MediaQuery.of(context).devicePixelRatio.toInt(),
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return const CupertinoActivityIndicator(
                  color: PrimaryColors.white,
                );
              },
            );
          }
        ));
  }
}
