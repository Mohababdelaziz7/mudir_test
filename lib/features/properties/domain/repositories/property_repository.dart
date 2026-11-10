import '../entities/property.dart';

abstract class PropertyRepository {
  Future<List<Property>> getAuctions();
  Future<List<Property>> getFeaturedProperties();
  Future<List<Property>> getRecommendedProperties();
  Future<List<Property>> getNearbyProperties();
  Future<Set<String>> getLikedPropertyIds();
  Future<Set<String>> getStarredPropertyIds();
  Future<void> toggleLike(String id);
  Future<void> toggleStarred(String id);
}
