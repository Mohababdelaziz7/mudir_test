import '../repositories/property_repository.dart';

class ToggleLikePropertyUseCase {
  final PropertyRepository repository;

  const ToggleLikePropertyUseCase(this.repository);

  Future<void> call(String propertyId) async {
    await repository.toggleLike(propertyId);
  }
}
