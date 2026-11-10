import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bground,
      appBar: AppBar(
        title: Text(
          'الملف الشخصي',
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
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primaryLight,
              child: Icon(Icons.person, size: 48, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(
              'مهاب',
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.txt1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'المنصورة، مصر',
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 14,
                color: AppColors.txt2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
