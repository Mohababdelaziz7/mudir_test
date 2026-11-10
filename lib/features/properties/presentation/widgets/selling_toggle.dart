import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../cubit/property_cubit.dart';
import '../cubit/property_state.dart';

class SellingToggle extends StatelessWidget {
  const SellingToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyCubit, PropertyState>(
      buildWhen: (previous, current) => previous.isForSale != current.isForSale,
      builder: (context, state) {
        final isSelling = state.isForSale;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<PropertyCubit>().setListingType(isForSale: true);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'للبيع',
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontWeight: isSelling
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 16,
                        color: isSelling ? AppColors.primary : AppColors.txt2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (isSelling)
                      Container(
                        width: 40,
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      )
                    else
                      const SizedBox(height: 2),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  context.read<PropertyCubit>().setListingType(
                    isForSale: false,
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'للإيجار',
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontWeight: isSelling
                            ? FontWeight.normal
                            : FontWeight.bold,
                        color: isSelling ? AppColors.txt2 : AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (!isSelling)
                      Container(
                        width: 44,
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      )
                    else
                      const SizedBox(height: 2),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                state.propertiesCountText,
                style: GoogleFonts.ibmPlexSansArabic(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
