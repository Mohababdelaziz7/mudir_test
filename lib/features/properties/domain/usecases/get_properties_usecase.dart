import '../entities/property.dart';
import '../repositories/property_repository.dart';

class PropertyBundle {
  final List<Property> auctions;
  final List<Property> featured;
  final List<Property> recommended;
  final List<Property> nearby;
  final Set<String> likedIds;
  final Set<String> starredIds;

  const PropertyBundle({
    required this.auctions,
    required this.featured,
    required this.recommended,
    required this.nearby,
    required this.likedIds,
    required this.starredIds,
  });
}

class GetPropertiesUseCase {
  final PropertyRepository repository;

  const GetPropertiesUseCase(this.repository);

  Future<PropertyBundle> call() async {
    final results = await Future.wait([
      repository.getAuctions(),
      repository.getFeaturedProperties(),
      repository.getRecommendedProperties(),
      repository.getNearbyProperties(),
      repository.getLikedPropertyIds(),
      repository.getStarredPropertyIds(),
    ]);

    return PropertyBundle(
      auctions: results[0] as List<Property>,
      featured: results[1] as List<Property>,
      recommended: results[2] as List<Property>,
      nearby: results[3] as List<Property>,
      likedIds: results[4] as Set<String>,
      starredIds: results[5] as Set<String>,
    );
  }
}
