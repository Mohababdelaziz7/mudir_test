import '../repositories/property_repository.dart';

class ToggleStarredPropertyUseCase {
  final PropertyRepository repository;

  const ToggleStarredPropertyUseCase(this.repository);

  Future<void> call(String propertyId) async {
    await repository.toggleStarred(propertyId);
  }
}
