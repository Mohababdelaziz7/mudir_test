import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/property.dart';
import '../cubit/property_cubit.dart';
import '../cubit/property_state.dart';
import 'property_card.dart';

class CardProduct extends StatelessWidget {
  final List<Property>? properties;
  final ValueChanged<Property>? onPropertyTap;

  const CardProduct({super.key, this.properties, this.onPropertyTap});

  @override
  Widget build(BuildContext context) {
    if (properties != null) {
      return CardProductList(
        properties: properties!,
        onPropertyTap: onPropertyTap,
      );
    }

    return BlocBuilder<PropertyCubit, PropertyState>(
      buildWhen: (prev, curr) => prev.auctions != curr.auctions,
      builder: (context, state) {
        return CardProductList(
          properties: state.auctions,
          onPropertyTap: onPropertyTap,
        );
      },
    );
  }
}

class CardProductList extends StatelessWidget {
  final List<Property> properties;
  final ValueChanged<Property>? onPropertyTap;

  const CardProductList({
    super.key,
    required this.properties,
    this.onPropertyTap,
  });

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const SizedBox(height: 5),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final item = properties[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == 0 ? 14.0 : 10.0,
                  left: index == properties.length - 1 ? 14.0 : 0.0,
                ),
                child: CardProductItem(
                  property: item,
                  onTap: () => onPropertyTap?.call(item),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CardProductItem extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;

  const CardProductItem({super.key, required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    return PropertyCard(property: property, width: 309, onTap: onTap);
  }
}
