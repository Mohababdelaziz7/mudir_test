import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/errors/failures.dart';
import '../../../navigation/presentation/cubit/navigation_cubit.dart';
import '../../../properties/presentation/cubit/property_cubit.dart';
import '../../../properties/presentation/cubit/property_state.dart';
import '../../../properties/presentation/widgets/auction_card.dart';
import '../../../properties/presentation/widgets/card_product.dart';
import '../../../properties/presentation/widgets/card_product_ver.dart';
import '../../../properties/presentation/widgets/category_chip_list.dart';
import '../../../properties/presentation/widgets/selling_toggle.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/banner_card.dart';
import '../widgets/best_location_card.dart';
import '../widgets/card_header.dart';
import '../widgets/floating_btn.dart';
import '../widgets/header_home.dart';
import '../widgets/search_filter.dart';
import '../widgets/services_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bground,
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                await Future.wait([
                  context.read<HomeCubit>().refreshHomeData(),
                  context.read<PropertyCubit>().loadProperties(),
                ]);
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: HeaderHome()),
                  const SliverToBoxAdapter(child: SearchFilter()),
                  const _HomeLoadingIndicator(),
                  const _HomeErrorBanner(),
                  const SliverToBoxAdapter(child: BannerCard()),

                  // Direct Auctions Section
                  SliverToBoxAdapter(
                    child: CardHeader(
                      title: "مزادات مباشرة",
                      actionText: "عرض الكل",
                      onActionTap: () {
                        context.read<NavigationCubit>().selectTab(3);
                      },
                    ),
                  ),
                  BlocBuilder<PropertyCubit, PropertyState>(
                    buildWhen: (prev, curr) => prev.auctions != curr.auctions,
                    builder: (context, state) {
                      return SliverToBoxAdapter(
                        child: AuctionProductList(
                          auctions: state.auctions,
                          onAuctionTap: (property) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('مزاد: ${property.title}'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  // Real Estate Services
                  const SliverToBoxAdapter(
                    child: CardHeader(title: "خدمات عقارية"),
                  ),
                  SliverToBoxAdapter(
                    child: ServicesCard(
                      onServiceSelected: (actionType) {
                        switch (actionType) {
                          case 'instant':
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('خدمة التقييم الفوري الذكي'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            break;
                          case 'accurate':
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'طلب تقرير تقييم معتمد من خبير عقاري',
                                ),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            break;
                          case 'signature':
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'إنشاء عقد إيجار موثق وجاهز للتوقيع',
                                ),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            break;
                        }
                      },
                    ),
                  ),

                  // Buy / Rent Toggle
                  const SliverToBoxAdapter(child: SellingToggle()),

                  // Category Chips Filter
                  const SliverToBoxAdapter(child: CategoryChipsList()),

                  // Featured Properties Section
                  SliverToBoxAdapter(
                    child: CardHeader(
                      title: "العقارات المميزة",
                      actionText: "عرض الكل",
                      onActionTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('عرض جميع العقارات المميزة'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<PropertyCubit, PropertyState>(
                    buildWhen: (prev, curr) =>
                        prev.featuredProperties != curr.featuredProperties,
                    builder: (context, state) {
                      return SliverToBoxAdapter(
                        child: CardProductList(
                          properties: state.featuredProperties,
                          onPropertyTap: (property) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('تفاصيل: ${property.title}'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  // Best Locations Section
                  SliverToBoxAdapter(
                    child: CardHeader(
                      title: "أفضل المواقع",
                      actionText: "عرض الكل",
                      onActionTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('عرض جميع أفضل المواقع'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BestLocationCard(
                      onLocationTap: (location) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تفاصيل: ${location.title}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),

                  // Recommended Properties Section
                  SliverToBoxAdapter(
                    child: CardHeader(
                      title: "القوائم الموصى بها",
                      actionText: "عرض الكل",
                      onActionTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('عرض جميع القوائم الموصى بها'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<PropertyCubit, PropertyState>(
                    builder: (context, state) {
                      if (state.status == PropertyStatus.loading &&
                          state.recommendedProperties.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.0),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                        );
                      }

                      final filtered = state.filteredRecommended;

                      if (filtered.isEmpty) {
                        final isFilterActive =
                            state.searchQuery.isNotEmpty ||
                            state.selectedCategoryIndex != 0;
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 32.0,
                              horizontal: 16.0,
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    isFilterActive
                                        ? Icons.search_off_rounded
                                        : Icons.real_estate_agent_outlined,
                                    size: 48,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    isFilterActive
                                        ? 'لا توجد عقارات تطابق هذا البحث أو الفئة'
                                        : 'لا توجد عقارات متاحة حالياً',
                                    style: GoogleFonts.ibmPlexSansArabic(
                                      color: AppColors.txt2,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final property = filtered[index];
                          return CardProductVer(
                            property: property,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('تفاصيل: ${property.title}'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                          );
                        }, childCount: filtered.length),
                      );
                    },
                  ),

                  // Nearby Properties Section
                  SliverToBoxAdapter(
                    child: CardHeader(
                      title: "استكشف العقارات القريبة",
                      actionText: "عرض الكل",
                      onActionTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('عرض جميع العقارات القريبة'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<PropertyCubit, PropertyState>(
                    buildWhen: (prev, curr) =>
                        prev.nearbyProperties != curr.nearbyProperties,
                    builder: (context, state) {
                      return SliverToBoxAdapter(
                        child: CardProductList(
                          properties: state.nearbyProperties,
                          onPropertyTap: (property) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('تفاصيل: ${property.title}'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  // Bottom Spacing for Floating Nav Bar
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),

            const _HomeFloatingActions(),
          ],
        ),
      ),
    );
  }
}

class _HomeLoadingIndicator extends StatelessWidget {
  const _HomeLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, homeState) {
        return BlocBuilder<PropertyCubit, PropertyState>(
          buildWhen: (prev, curr) => prev.status != curr.status,
          builder: (context, propState) {
            if (homeState.status == HomeStatus.loading &&
                homeState.banners.isEmpty &&
                propState.status == PropertyStatus.loading &&
                propState.featuredProperties.isEmpty) {
              return const SliverToBoxAdapter(
                child: LinearProgressIndicator(minHeight: 2),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        );
      },
    );
  }
}

class _HomeErrorBanner extends StatelessWidget {
  const _HomeErrorBanner();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, curr) =>
          prev.status != curr.status || prev.errorMessage != curr.errorMessage,
      builder: (context, homeState) {
        return BlocBuilder<PropertyCubit, PropertyState>(
          buildWhen: (prev, curr) =>
              prev.status != curr.status ||
              prev.errorMessage != curr.errorMessage,
          builder: (context, propState) {
            final isFailure =
                homeState.status == HomeStatus.failure ||
                propState.status == PropertyStatus.failure;
            if (!isFailure) {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }

            final failureMessage =
                homeState.errorMessage ??
                propState.errorMessage ??
                'تعذر تحميل بعض البيانات.';

            final isNetworkError =
                homeState.failure is NetworkFailure ||
                propState.failure is NetworkFailure;

            return SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.errorBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.errorBorder),
                ),
                child: Row(
                  children: [
                    Icon(
                      isNetworkError
                          ? Icons.wifi_off_rounded
                          : Icons.error_outline_rounded,
                      color: Colors.red[700],
                      size: 26,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تعذر تحديث البيانات',
                            style: GoogleFonts.ibmPlexSansArabic(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: AppColors.txt1,
                            ),
                          ),
                          Text(
                            failureMessage,
                            style: GoogleFonts.ibmPlexSansArabic(
                              fontSize: 12,
                              color: AppColors.txt2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                      ),
                      icon: const Icon(Icons.refresh_rounded, size: 16),
                      label: Text(
                        'إعادة المحاولة',
                        style: GoogleFonts.ibmPlexSansArabic(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      onPressed: () {
                        if (homeState.status == HomeStatus.failure) {
                          context.read<HomeCubit>().loadHomeData();
                        }
                        if (propState.status == PropertyStatus.failure) {
                          context.read<PropertyCubit>().loadProperties();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _HomeFloatingActions extends StatelessWidget {
  const _HomeFloatingActions();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      bottom: 90,
      child: Column(
        children: [
          FloatingBtn(
            iconImg: AppAssets.map,
            color: Colors.black,
            shadColor: Colors.black,
            colors: const [Color(0xFF131314), Color(0xFF131314)],
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('عرض الخريطة التفاعلية'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          FloatingBtn(
            iconImg: AppAssets.robot,
            color: AppColors.aiGradientEnd,
            shadColor: AppColors.aiGradientEnd,
            colors: const [
              AppColors.aiGradientStart,
              AppColors.aiGradientStart,
              AppColors.aiGradientEnd,
            ],
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('المساعد العقاري الذكي'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
