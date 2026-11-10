import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../notifications/presentation/cubit/header_status_cubit.dart';
import '../../../notifications/presentation/cubit/header_status_state.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeaderStatusCubit, HeaderStatusState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryLight,
                backgroundImage: const AssetImage(AppAssets.avatar),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'أهلاً ${state.userName}',
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.txt1,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        state.userLocation,
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: AppColors.txt2,
                          fontSize: 12,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              _buildIconButton(
                AppAssets.notification,
                hasBadge: state.hasUnreadNotification,
                onTap: () {
                  context.read<HeaderStatusCubit>().toggleNotifications();
                },
              ),
              const SizedBox(width: 8),
              _buildIconButton(
                AppAssets.message,
                hasBadge: state.hasUnreadMessage,
                onTap: () {
                  context.read<HeaderStatusCubit>().toggleMessages();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconButton(
    String iconImg, {
    required bool hasBadge,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                iconImg,
                colorFilter: const ColorFilter.mode(
                  Colors.black87,
                  BlendMode.srcIn,
                ),
              ),
            ),
            if (hasBadge)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
