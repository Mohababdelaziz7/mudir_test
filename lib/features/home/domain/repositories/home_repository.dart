import '../entities/banner_item.dart';
import '../entities/location_item.dart';
import '../entities/service_item.dart';
import '../entities/tools_item.dart';

abstract class HomeRepository {
  Future<List<BannerItem>> getBanners();

  Future<List<ServiceItem>> getServices();

  Future<List<ToolsItem>> getTools();

  Future<List<LocationItem>> getBestLocations();
}
