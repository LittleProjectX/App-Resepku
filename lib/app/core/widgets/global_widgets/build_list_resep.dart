import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/texts/build_like.dart';

class BuildListResep extends StatelessWidget {
  const BuildListResep({
    super.key,
    required this.menuTap,
    required this.imageUrl,
    required this.title,
    required this.likes,
    required this.description,
    required this.onDelete,
  });

  final VoidCallback menuTap;
  final String imageUrl;
  final String title;
  final int likes;
  final String description;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: menuTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(12),
                child: imageUrl != ''
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.medium,
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
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/no_image.jpg',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.medium,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/no_image.jpg',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.medium,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.body2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    style: AppTextStyle.body7,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  buildLike(likes.toString()),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Iconsax.trash, size: 20, color: AppColors.delete),
            ),
          ],
        ),
      ),
    );
  }
}
