import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({super.key, required this.profile, required this.onTap});

  final ImageProvider profile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(backgroundImage: profile, radius: 60),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 45,
              width: 45,
              child: Material(
                color: AppColors.surface,
                shape: CircleBorder(),
                elevation: 4,
                child: Icon(Iconsax.camera, size: 20, color: AppColors.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
