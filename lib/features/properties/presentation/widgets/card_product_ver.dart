import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../domain/entities/property.dart';
import 'property_card.dart';

class CardProductVer extends StatelessWidget {
  final Property? property;
  final String? img;
  final VoidCallback? onTap;

  const CardProductVer({super.key, this.property, this.img, this.onTap})
    : assert(
        property != null || img != null,
        'Either property or img must be provided',
      );

  Property get _resolvedProperty {
    if (property != null) return property!;
    return Property(
      id: img ?? 'default_id',
      title: 'شقة مفروشة بالمشاية',
      location: 'المنصورة',
      price: '8 مليون',
      floor: 'الدور الرابع',
      area: '120 م²',
      rooms: '3 غرف',
      extraDetails: '4+',
      imageUrl: img ?? AppAssets.prop1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PropertyCard(
      property: _resolvedProperty,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      onTap: onTap,
    );
  }
}
