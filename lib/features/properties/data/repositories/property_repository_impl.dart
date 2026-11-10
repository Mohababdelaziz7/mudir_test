import '../../../../core/errors/failures.dart';
import '../../domain/entities/property.dart';
import '../../domain/repositories/property_repository.dart';
import '../datasources/property_local_data_source.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyLocalDataSource localDataSource;

  const PropertyRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Property>> getAuctions() async {
    try {
      return await localDataSource.getAuctions();
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<Property>> getFeaturedProperties() async {
    try {
      return await localDataSource.getFeaturedProperties();
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<Property>> getRecommendedProperties() async {
    try {
      return await localDataSource.getRecommendedProperties();
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<Property>> getNearbyProperties() async {
    try {
      return await localDataSource.getNearbyProperties();
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<Set<String>> getLikedPropertyIds() async {
    try {
      return await localDataSource.getLikedIds();
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<Set<String>> getStarredPropertyIds() async {
    try {
      return await localDataSource.getStarredIds();
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<void> toggleLike(String id) async {
    try {
      final current = await localDataSource.getLikedIds();
      final updated = Set<String>.from(current);
      if (updated.contains(id)) {
        updated.remove(id);
      } else {
        updated.add(id);
      }
      await localDataSource.saveLikedIds(updated);
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<void> toggleStarred(String id) async {
    try {
      final current = await localDataSource.getStarredIds();
      final updated = Set<String>.from(current);
      if (updated.contains(id)) {
        updated.remove(id);
      } else {
        updated.add(id);
      }
      await localDataSource.saveStarredIds(updated);
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }
}
