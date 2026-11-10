import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../cubit/property_cubit.dart';
import '../cubit/property_state.dart';

class CategoryChipItem {
  final String name;
  final String? imageAsset;
  final IconData? icon;

  const CategoryChipItem({required this.name, this.imageAsset, this.icon});
}

class CategoryChipsList extends StatelessWidget {
  const CategoryChipsList({super.key});

  static const List<CategoryChipItem> _categories = [
    CategoryChipItem(name: 'الكل'),
    CategoryChipItem(name: 'شقة', imageAsset: AppAssets.catApartment),
    CategoryChipItem(name: 'فيلا', imageAsset: AppAssets.catVilla),
    CategoryChipItem(name: 'شاليه', imageAsset: AppAssets.catChalet),
    CategoryChipItem(name: 'مكتب', imageAsset: AppAssets.catOffice),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyCubit, PropertyState>(
      buildWhen: (previous, current) =>
          previous.selectedCategoryIndex != current.selectedCategoryIndex,
      builder: (context, state) {
        return SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final item = _categories[index];
              final isSelected = state.selectedCategoryIndex == index;
              return _CategoryChip(
                item: item,
                isSelected: isSelected,
                onTap: () {
                  context.read<PropertyCubit>().selectCategory(index);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final CategoryChipItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  Widget _buildAvatar(String assetPath) {
    final isSvg = assetPath.toLowerCase().endsWith('.svg');
    return ClipOval(
      child: isSvg
          ? SvgPicture.asset(
              assetPath,
              width: 34,
              height: 34,
              fit: BoxFit.cover,
            )
          : Image.asset(assetPath, width: 34, height: 34, fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = item.imageAsset != null;
    final hasIcon = item.icon != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 44,
          padding: EdgeInsetsDirectional.only(
            start: hasImage ? 5 : (hasIcon ? 8 : 22),
            end: hasImage ? 16 : (hasIcon ? 14 : 22),
            top: 4,
            bottom: 4,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryDark : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: isSelected
                ? null
                : Border.all(color: AppColors.cardBorder, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (hasImage) ...[
                _buildAvatar(item.imageAsset!),
                const SizedBox(width: 8),
              ] else if (hasIcon) ...[
                Icon(
                  item.icon,
                  size: 20,
                  color: isSelected ? Colors.white : AppColors.txt2,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                item.name,
                style: GoogleFonts.ibmPlexSansArabic(
                  color: isSelected ? Colors.white : AppColors.txt1,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
