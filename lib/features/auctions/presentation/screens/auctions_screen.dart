import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

class AuctionsScreen extends StatelessWidget {
  const AuctionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'المزادات المباشرة',
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
            Icon(Icons.gavel_outlined, size: 64, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              'لا توجد مزادات نشطة في الوقت الحالي',
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
