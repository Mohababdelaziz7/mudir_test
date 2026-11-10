import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/location_item.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class BestLocationCard extends StatelessWidget {
  final ValueChanged<LocationItem>? onLocationTap;

  const BestLocationCard({super.key, this.onLocationTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous.locations != current.locations,
      builder: (context, state) {
        final locations = state.locations;
        if (locations.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            const SizedBox(height: 5),
            SizedBox(
              height: 156,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final item = locations[index];
                  return Padding(
                    padding: EdgeInsets.only(right: index == 0 ? 14.0 : 0),
                    child: GestureDetector(
                      onTap: () {
                        if (onLocationTap != null) {
                          onLocationTap!(item);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تفاصيل: ${item.title}'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 128,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  item.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned.fill(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: const [
                                        Colors.transparent,
                                        Colors.black,
                                      ],
                                      stops: const [0.1, 1.0],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                left: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: GoogleFonts.ibmPlexSansArabic(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      item.propertiesCount,
                                      style: GoogleFonts.ibmPlexSansArabic(
                                        color: Colors.white70,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
