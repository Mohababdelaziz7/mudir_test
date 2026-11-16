import '../../../../core/errors/failures.dart';
import '../../domain/entities/banner_item.dart';
import '../../domain/entities/location_item.dart';
import '../../domain/entities/service_item.dart';
import '../../domain/entities/tools_item.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  const HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<List<BannerItem>> getBanners() async {
    try {
      return await localDataSource.getBanners();
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<ServiceItem>> getServices() async {
    try {
      return await localDataSource.getServices();
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<ToolsItem>> getTools() async {
    try {
      return await localDataSource.getTools();
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<LocationItem>> getBestLocations() async {
    try {
      return await localDataSource.getBestLocations();
    } on Exception catch (e) {
      throw Failure.fromException(e);
    }
  }
}
