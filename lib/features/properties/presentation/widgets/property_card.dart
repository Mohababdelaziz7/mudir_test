import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/property.dart';
import '../cubit/property_cubit.dart';
import '../cubit/property_state.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const PropertyCard({
    super.key,
    required this.property,
    this.width,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyCubit, PropertyState>(
      buildWhen: (prev, curr) =>
          prev.isLiked(property.id) != curr.isLiked(property.id) ||
          prev.isStarred(property.id) != curr.isStarred(property.id),
      builder: (context, state) {
        final isLiked = state.isLiked(property.id);
        final isStarred = state.isStarred(property.id);

        final cardWidget = GestureDetector(
          onLongPress: () {
            context.read<PropertyCubit>().toggleStarred(property.id);
          },
          onDoubleTap: () {
            context.read<PropertyCubit>().toggleLike(property.id);
          },
          onTap: onTap,
          child: Container(
            width: width,
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              color: isStarred ? AppColors.goldLight : Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: isStarred ? 2 : 0,
                  color: isStarred ? AppColors.gold : Colors.white,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image section
                SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(property.imageUrl, fit: BoxFit.cover),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.50, 1.00),
                              end: Alignment(0.50, 0.00),
                              colors: [
                                AppColors.imageOverlayTop,
                                AppColors.imageOverlayBottom,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          top: 16,
                          child: GestureDetector(
                            onTap: () {
                              context.read<PropertyCubit>().toggleLike(
                                property.id,
                              );
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: SvgPicture.asset(
                                isLiked ? AppAssets.liked : AppAssets.like,
                              ),
                            ),
                          ),
                        ),
                        if (isStarred)
                          Positioned(
                            left: 16,
                            top: 16,
                            child: GestureDetector(
                              onTap: () {
                                context.read<PropertyCubit>().toggleStarred(
                                  property.id,
                                );
                              },
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: SvgPicture.asset(AppAssets.stared),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Details 1: Title & Location vs Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.ibmPlexSansArabic(
                              color: AppColors.txt1,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              SizedBox(
                                width: 14,
                                height: 14,
                                child: SvgPicture.asset(
                                  AppAssets.location,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.txt2,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  property.location,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.txt2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        property.price,
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Details 2: Amenities Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildChip(AppAssets.door, property.floor),
                      const SizedBox(width: 4),
                      _buildChip(AppAssets.dist, property.area),
                      const SizedBox(width: 4),
                      _buildChip(AppAssets.bed, property.rooms),
                      const SizedBox(width: 4),
                      _buildChip(null, property.extraDetails),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

        if (margin != null) {
          return Padding(padding: margin!, child: cardWidget);
        }
        return cardWidget;
      },
    );
  }

  Widget _buildChip(String? icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            SizedBox(
              width: 16,
              height: 16,
              child: SvgPicture.asset(
                icon,
                colorFilter: const ColorFilter.mode(
                  AppColors.txt2,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: GoogleFonts.ibmPlexSansArabic(
              color: AppColors.txt2,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
