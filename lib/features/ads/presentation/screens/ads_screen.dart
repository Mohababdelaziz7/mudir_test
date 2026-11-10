import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bground,
      appBar: AppBar(
        title: Text(
          'إعلاناتي',
          style: GoogleFonts.ibmPlexSansArabic(
            fontWeight: FontWeight.bold,
            color: AppColors.txt1,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.campaign_outlined, size: 64, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              'لا توجد إعلانات نشطة حالياً',
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 16,
                color: AppColors.txt2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
