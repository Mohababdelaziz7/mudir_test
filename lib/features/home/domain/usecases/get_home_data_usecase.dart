import '../entities/banner_item.dart';
import '../entities/location_item.dart';
import '../entities/service_item.dart';
import '../repositories/home_repository.dart';

class HomeBundle {
  final List<BannerItem> banners;
  final List<ServiceItem> services;
  final List<LocationItem> locations;

  const HomeBundle({
    required this.banners,
    required this.services,
    required this.locations,
  });
}

class GetHomeDataUseCase {
  final HomeRepository repository;

  const GetHomeDataUseCase(this.repository);

  Future<HomeBundle> call() async {
    final results = await Future.wait([
      repository.getBanners(),
      repository.getServices(),
      repository.getBestLocations(),
    ]);

    return HomeBundle(
      banners: results[0] as List<BannerItem>,
      services: results[1] as List<ServiceItem>,
      locations: results[2] as List<LocationItem>,
    );
  }
}
