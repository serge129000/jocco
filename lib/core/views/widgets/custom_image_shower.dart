import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:jocco/core/utils/color.dart';

class CustomImageShower extends StatelessWidget {
  final String? url;
  final bool? isRounded;
  final double? radius;
  const CustomImageShower(
      {super.key, required this.url, this.isRounded = false, this.radius});
  static final imageCache = CacheManager(
    Config('imageCache',
        stalePeriod: Duration(
          days: 15,
        ),
        maxNrOfCacheObjects: 200),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1 / 0,
        width: 1 / 0,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: isRounded! ? null : BorderRadius.circular(radius ?? 20),
            shape: isRounded! ? BoxShape.circle : BoxShape.rectangle),
        child: LayoutBuilder(builder: (context, constraint) {
          return CachedNetworkImage(
            cacheManager: imageCache,
            fadeInDuration: Duration.zero,
            errorWidget: (context, url, error) {
              return SizedBox();
            },
            /* memCacheHeight: constraint.maxWidth.toInt() *
                MediaQuery.of(context).devicePixelRatio.toInt(), */
            imageUrl: url ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return const CupertinoActivityIndicator(
                color: PrimaryColors.white,
              );
            },
          );
        }));
  }
}
