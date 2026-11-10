import '../../../../core/constants/app_assets.dart';
import '../models/banner_model.dart';
import '../models/location_model.dart';
import '../models/service_model.dart';

abstract class HomeLocalDataSource {
  Future<List<BannerModel>> getBanners();
  Future<List<ServiceModel>> getServices();
  Future<List<LocationModel>> getBestLocations();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl();

  @override
  Future<List<BannerModel>> getBanners() async {
    return const [
      BannerModel(
        id: '1',
        image: AppAssets.banner1,
        title: 'فيلا الأحلام في قلب التجمع الخامس..',
        subtitle: 'امتلك فيلا فاخرة بحديقة خاصة في أرقى أحياء التجمع الخامس واستمتع بالهدوء والتصميم المعماري الفريد.',
      ),
      BannerModel(
        id: '2',
        image: AppAssets.banner2,
        title: 'فيلا الأحلام في قلب التجمع التالت..',
        subtitle: 'امتلك فيلا فاخرة بحديقة خاصة في أرقى أحياء التجمع الخامس واستمتع بالهدوء والتصميم المعماري الفريد.',
      ),
      BannerModel(
        id: '3',
        image: AppAssets.banner3,
        title: 'فيلا الأحلام في قلب التجمع العاشر..',
        subtitle: 'امتلك فيلا فاخرة بحديقة خاصة في أرقى أحياء التجمع الخامس واستمتع بالهدوء والتصميم المعماري الفريد.',
      ),
    ];
  }

  @override
  Future<List<ServiceModel>> getServices() async {
    return const [
      ServiceModel(
        id: '1',
        image: AppAssets.robot,
        title: 'تقييم فوري',
        subtitle: 'تقييم ذكي',
        isNew: true,
        actionType: 'instant',
      ),
      ServiceModel(
        id: '2',
        image: AppAssets.report,
        title: 'تقييم معتمد',
        subtitle: 'بتقرير من خبير',
        isNew: false,
        actionType: 'accurate',
      ),
      ServiceModel(
        id: '3',
        image: AppAssets.sign,
        title: 'عقد إيجار',
        subtitle: 'جاهز للتوقيع',
        isNew: false,
        actionType: 'signature',
      ),
    ];
  }

  @override
  Future<List<LocationModel>> getBestLocations() async {
    return const [
      LocationModel(
        id: '1',
        image: AppAssets.loc1,
        title: 'مدينه نصر',
        propertiesCount: '95 عقار',
      ),
      LocationModel(
        id: '2',
        image: AppAssets.loc2,
        title: 'مدينتي',
        propertiesCount: '120 عقار',
      ),
      LocationModel(
        id: '3',
        image: AppAssets.loc1,
        title: 'التجمع الخامس',
        propertiesCount: '310 عقار',
      ),
      LocationModel(
        id: '4',
        image: AppAssets.loc2,
        title: 'الشيخ زايد',
        propertiesCount: '280 عقار',
      ),
    ];
  }
}
