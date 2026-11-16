import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/property.dart';
import '../cubit/property_cubit.dart';
import '../cubit/property_state.dart';

class AuctionCard extends StatelessWidget {
  final Property property;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final String? openingPrice;
  final String? latestPrice;
  final String remainingDaysText;

  const AuctionCard({
    super.key,
    required this.property,
    this.width = 309,
    this.margin,
    this.onTap,
    this.openingPrice,
    this.latestPrice,
    this.remainingDaysText = 'باقي 4 أيام',
  });

  String _resolveLatestPrice(Property p) {
    if (latestPrice != null && latestPrice!.isNotEmpty) {
      return latestPrice!;
    }
    if (p.id == 'auc_1') return '8.4 مليون';
    if (p.id == 'auc_2') return '15.8 مليون';
    return '${p.price} +';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyCubit, PropertyState>(
      buildWhen: (prev, curr) =>
          prev.isLiked(property.id) != curr.isLiked(property.id),
      builder: (context, state) {
        final isLiked = state.isLiked(property.id);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            margin: margin,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFF0F2F7)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. قسم الصورة وعليها (زر القلب + بادج باقي 4 أيام)
                SizedBox(
                  width: double.infinity,
                  height: 145,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(property.imageUrl, fit: BoxFit.cover),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                AppColors.imageOverlayBottom,
                                AppColors.imageOverlayTop,
                              ],
                            ),
                          ),
                        ),

                        // زر القلب (أعلى اليمين)
                        Positioned(
                          right: 14,
                          top: 14,
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

                        Positioned(
                          left: 14,
                          top: 14,
                          child: Container(
                            height: 24,
                            padding: const EdgeInsets.only(left: 12, right: 8),
                            decoration: ShapeDecoration(
                              color: Colors.white /* Card-bg */,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 4,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFD9382B) /* Danger */,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),

                                Text(
                                  'مباشر',
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: const Color(0xFF9B1C12),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // بادج "باقي 4 أيام" (أعلى اليسار - مكان النجمة الملغية)
                        Positioned(
                          left: 14,
                          bottom: 14,
                          child: Container(
                            height: 24,
                            padding: const EdgeInsets.only(left: 10, right: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCEAC8),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  size: 14,
                                  color: Color(0xFF3D2A00),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  remainingDaysText,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: const Color(0xFF3D2A00),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // 2. العنوان والموقع
                Text(
                  property.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: AppColors.txt1,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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

                const SizedBox(height: 10),

                // 3. الجزء السفلي: سعر الافتتاح وآخر سعر جنباً إلى جنب
                Row(
                  children: [
                    Expanded(
                      child: _buildPriceBox(
                        title: 'سعر الافتتاح',
                        price: openingPrice ?? property.price,
                        color: const Color(0xFFF0F2F7),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildPriceBox(
                        title: 'آخر سعر',
                        price: _resolveLatestPrice(property),
                        color: const Color(0xFFE6EFFB),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPriceBox({
    required String title,
    required String price,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.ibmPlexSansArabic(
              color: const Color(0xFF4B5A70),
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            price,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.ibmPlexSansArabic(
              color: const Color(0xFF131314),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class AuctionProductList extends StatelessWidget {
  final List<Property> auctions;
  final ValueChanged<Property>? onAuctionTap;
  final VoidCallback? onAddAuctionTap;

  const AuctionProductList({
    super.key,
    required this.auctions,
    this.onAuctionTap,
    this.onAddAuctionTap,
  });

  @override
  Widget build(BuildContext context) {
    if (auctions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const SizedBox(height: 5),
        SizedBox(
          height: 285,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: auctions.length + 1,
            itemBuilder: (context, index) {
              if (index == auctions.length) {
                return Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 10.0),
                  child: _buildBlueBannerCard(context),
                );
              }
              final item = auctions[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == 0 ? 14.0 : 10.0,
                  left: 0.0,
                ),
                child: AuctionCard(
                  property: item,
                  onTap: () => onAuctionTap?.call(item),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Add Auction Card
  Widget _buildBlueBannerCard(BuildContext context) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF143566),
            Color(0xFF1E4C8C).withValues(alpha: 0.9),
            Color(0xFF1E4C8C).withValues(alpha: 0.9),
            Color(0xFF1E4C8C).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onAddAuctionTap,
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppAssets.navAuctions,
                width: 36,
                height: 36,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'عنده عقار؟\nاعرضه في مزاد',
              textAlign: TextAlign.center,
              style: GoogleFonts.ibmPlexSansArabic(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),

            const Spacer(),

            // السهم والكلمة في الأسفل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ابدأ الطلب',
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
