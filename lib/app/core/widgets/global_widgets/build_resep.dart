import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

class BuildResep extends StatelessWidget {
  const BuildResep({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.portion,
    required this.likes,
    required this.onTap,
  });

  final String imageUrl;
  final String title;
  final String portion;
  final int likes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 180,
        width: 130,
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: imageUrl == ''
                    ? Image.asset(
                        'assets/images/no_image.jpg',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
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
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 1,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.body8,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.ramen_dining,
                  size: 12,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  portion,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.body7,
                ),
                const SizedBox(width: 4),
                Text('|', style: AppTextStyle.body7),
                const SizedBox(width: 4),
                Icon(Iconsax.heart, color: AppColors.textSecondary, size: 12),
                const SizedBox(width: 4),
                Text(
                  likes.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.body7,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
