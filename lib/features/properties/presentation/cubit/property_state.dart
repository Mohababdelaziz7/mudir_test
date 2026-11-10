import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/property.dart';

enum PropertyStatus { initial, loading, success, empty, failure }

class PropertyState extends Equatable {
  final PropertyStatus status;
  final bool isForSale;
  final int selectedCategoryIndex;
  final String searchQuery;
  final List<Property> auctions;
  final List<Property> featuredProperties;
  final List<Property> recommendedProperties;
  final List<Property> nearbyProperties;
  final Set<String> likedIds;
  final Set<String> starredIds;
  final Failure? failure;
  final String? errorMessage;

  const PropertyState({
    this.status = PropertyStatus.initial,
    this.isForSale = true,
    this.selectedCategoryIndex = 0,
    this.searchQuery = '',
    this.auctions = const [],
    this.featuredProperties = const [],
    this.recommendedProperties = const [],
    this.nearbyProperties = const [],
    this.likedIds = const {},
    this.starredIds = const {},
    this.failure,
    this.errorMessage,
  });

  static const List<String> categories = [
    'الكل',
    'شقة',
    'فيلا',
    'شاليه',
    'مكتب',
    'محل تجاري',
  ];

  String get selectedCategoryName {
    if (selectedCategoryIndex >= 0 &&
        selectedCategoryIndex < categories.length) {
      return categories[selectedCategoryIndex];
    }
    return 'الكل';
  }

  List<Property> get filteredRecommended {
    return recommendedProperties.where((prop) {
      // Filter by sale / rent
      if (prop.isForSale != isForSale) return false;

      // Filter by category
      if (selectedCategoryIndex != 0) {
        final cat = selectedCategoryName;
        if (prop.category != cat) return false;
      }

      // Filter by search query
      if (searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        final matchTitle = prop.title.toLowerCase().contains(q);
        final matchLocation = prop.location.toLowerCase().contains(q);
        if (!matchTitle && !matchLocation) return false;
      }

      return true;
    }).toList();
  }

  String get propertiesCountText {
    final count = isForSale ? '1,240' : '580';
    return '$count عقار';
  }

  bool isLiked(String propertyId) => likedIds.contains(propertyId);
  bool isStarred(String propertyId) => starredIds.contains(propertyId);

  PropertyState copyWith({
    PropertyStatus? status,
    bool? isForSale,
    int? selectedCategoryIndex,
    String? searchQuery,
    List<Property>? auctions,
    List<Property>? featuredProperties,
    List<Property>? recommendedProperties,
    List<Property>? nearbyProperties,
    Set<String>? likedIds,
    Set<String>? starredIds,
    Failure? failure,
    String? errorMessage,
  }) {
    return PropertyState(
      status: status ?? this.status,
      isForSale: isForSale ?? this.isForSale,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      auctions: auctions ?? this.auctions,
      featuredProperties: featuredProperties ?? this.featuredProperties,
      recommendedProperties:
          recommendedProperties ?? this.recommendedProperties,
      nearbyProperties: nearbyProperties ?? this.nearbyProperties,
      likedIds: likedIds ?? this.likedIds,
      starredIds: starredIds ?? this.starredIds,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    isForSale,
    selectedCategoryIndex,
    searchQuery,
    auctions,
    featuredProperties,
    recommendedProperties,
    nearbyProperties,
    likedIds,
    starredIds,
    failure,
    errorMessage,
  ];
}
