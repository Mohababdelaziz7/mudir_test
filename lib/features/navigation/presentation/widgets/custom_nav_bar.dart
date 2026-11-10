import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class NavItemData {
  final String assetPath;
  final int index;

  const NavItemData({required this.assetPath, required this.index});
}

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  static const List<NavItemData> _navItems = [
    NavItemData(assetPath: AppAssets.navHome, index: 0),
    NavItemData(assetPath: AppAssets.navProjects, index: 1),
    NavItemData(assetPath: AppAssets.navAds, index: 2),
    NavItemData(assetPath: AppAssets.navAuctions, index: 3),
    NavItemData(assetPath: AppAssets.navProfile, index: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _navItems.map(_buildNavItem).toList(),
      ),
    );
  }

  Widget _buildNavItem(NavItemData item) {
    final isSelected = selectedIndex == item.index;
    final color = isSelected ? Colors.white : AppColors.txt1;

    return GestureDetector(
      onTap: () => onItemTapped(item.index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.bground,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          backgroundColor: isSelected ? AppColors.primary : AppColors.bground,
          child: SvgPicture.asset(
            item.assetPath,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            width: 32,
            height: 32,
          ),
        ),
      ),
    );
  }
}
