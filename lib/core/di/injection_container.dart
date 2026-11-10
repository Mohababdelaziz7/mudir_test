import 'package:get_it/get_it.dart';

import '../../features/home/data/datasources/home_local_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_data_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/navigation/presentation/cubit/navigation_cubit.dart';
import '../../features/notifications/presentation/cubit/header_status_cubit.dart';
import '../../features/properties/data/datasources/property_local_data_source.dart';
import '../../features/properties/data/repositories/property_repository_impl.dart';
import '../../features/properties/domain/repositories/property_repository.dart';
import '../../features/properties/domain/usecases/get_properties_usecase.dart';
import '../../features/properties/domain/usecases/toggle_like_property_usecase.dart';
import '../../features/properties/domain/usecases/toggle_starred_property_usecase.dart';
import '../../features/properties/presentation/cubit/property_cubit.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';
import '../services/storage_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core & Services
  sl.registerLazySingleton<ApiClient>(() => const DefaultApiClient());
  sl.registerLazySingleton<NetworkInfo>(
    () => const AlwaysConnectedNetworkInfo(),
  );
  sl.registerLazySingleton<StorageService>(() => InMemoryStorageService());

  // Data Sources
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => const HomeLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<PropertyLocalDataSource>(
    () => PropertyLocalDataSourceImpl(storageService: sl()),
  );

  // Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<PropertyRepository>(
    () => PropertyRepositoryImpl(localDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));
  sl.registerLazySingleton(() => GetPropertiesUseCase(sl()));
  sl.registerLazySingleton(() => ToggleLikePropertyUseCase(sl()));
  sl.registerLazySingleton(() => ToggleStarredPropertyUseCase(sl()));

  // Cubits (Factory for fresh instances per view or navigation flow)
  sl.registerFactory(() => NavigationCubit());
  sl.registerFactory(() => HeaderStatusCubit());
  sl.registerFactory(() => HomeCubit(getHomeDataUseCase: sl()));
  sl.registerFactory(
    () => PropertyCubit(
      getPropertiesUseCase: sl(),
      toggleLikePropertyUseCase: sl(),
      toggleStarredPropertyUseCase: sl(),
    ),
  );
}
