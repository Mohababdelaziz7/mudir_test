import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

class CardHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const CardHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.ibmPlexSansArabic(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.txt1,
            ),
          ),
          if (actionText != null && actionText!.isNotEmpty)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText!,
                style: GoogleFonts.ibmPlexSansArabic(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
