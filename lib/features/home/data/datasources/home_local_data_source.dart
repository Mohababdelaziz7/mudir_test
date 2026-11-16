import '../../../../core/constants/app_assets.dart';
import '../models/banner_model.dart';
import '../models/location_model.dart';
import '../models/service_model.dart';
import '../models/tools_model.dart';

abstract class HomeLocalDataSource {
  Future<List<BannerModel>> getBanners();

  Future<List<ServiceModel>> getServices();

  Future<List<ToolsModel>> getTools();

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
      ServiceModel(
        id: '4',
        image: AppAssets.navAds,
        title: 'تسويق عقاري',
        subtitle: 'سوق عقارك',
        isNew: false,
        actionType: 'marketing',
      ),
      ServiceModel(
        id: '5',
        image: AppAssets.report,
        title: 'تشغيل للغير',
        subtitle: 'اداره وتأجير',
        isNew: false,
        actionType: 'management',
      ),
      ServiceModel(
        id: '6',
        image: AppAssets.sign,
        title: 'ادارة شاملة',
        subtitle: 'ادارة الأملاك',
        isNew: false,
        actionType: 'management_full',
      ),
      ServiceModel(
        id: '7',
        image: AppAssets.report,
        title: 'طلب شراء',
        subtitle: 'ابحث عن عقارك',
        isNew: false,
        actionType: 'purchase',
      ),
    ];
  }

  @override
  Future<List<ToolsModel>> getTools() async {
    return const [
      ToolsModel(
        id: '1',
        image: AppAssets.calculator,
        title: 'حاسبة التمويل',
        subtitle: 'القسط الشهري',
        isNew: false,
        actionType: 'calculator',
      ),
      ToolsModel(
        id: '2',
        image: AppAssets.chart,
        title: 'العائد الايجاري',
        subtitle: 'العائد السنوي',
        isNew: false,
        actionType: 'return',
      ),
      ToolsModel(
        id: '3',
        image: AppAssets.agreement,
        title: 'ايجار VS تملك',
        subtitle: 'الايجار والشراء',
        isNew: false,
        actionType: 'rent_vs_buy',
      ),

      ToolsModel(
        id: '4',
        image: AppAssets.calculator,
        title: 'المقدم والاقساط',
        subtitle: 'المقدم والمتبقي',
        isNew: false,
        actionType: 'downpayment',
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
