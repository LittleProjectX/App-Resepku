import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget buildPopularCard(
  VoidCallback ontap,
  String title,
  String author,
  String imageUrl,
) {
  return Container(
    height: 180,
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(24),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/no_image.jpg',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )
                : Image.asset('assets/images/no_image.jpg', fit: BoxFit.cover),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 34,
                width: 34,
                child: Material(
                  shape: CircleBorder(),
                  color: Colors.white.withValues(alpha: 0.8),
                  child: Icon(
                    Iconsax.medal_star,
                    size: 24,
                    color: AppColors.warning,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 80,
                child: Material(
                  color: Colors.white.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1st Populer', style: AppTextStyle.body9),
                              Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.heading7,
                              ),
                              Text(
                                author,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.body9,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: ontap,
                          child: SizedBox(
                            height: 30,
                            width: 80,
                            child: Material(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(24),
                              child: Center(
                                child: Text('Lihat', style: AppTextStyle.body3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
