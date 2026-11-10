import '../../../../core/constants/app_assets.dart';
import '../../../../core/services/storage_service.dart';
import '../models/property_model.dart';

abstract class PropertyLocalDataSource {
  Future<List<PropertyModel>> getAuctions();
  Future<List<PropertyModel>> getFeaturedProperties();
  Future<List<PropertyModel>> getRecommendedProperties();
  Future<List<PropertyModel>> getNearbyProperties();
  Future<Set<String>> getLikedIds();
  Future<Set<String>> getStarredIds();
  Future<void> saveLikedIds(Set<String> ids);
  Future<void> saveStarredIds(Set<String> ids);
}

class PropertyLocalDataSourceImpl implements PropertyLocalDataSource {
  final StorageService storageService;
  static const String _likedKey = 'liked_property_ids';
  static const String _starredKey = 'starred_property_ids';

  PropertyLocalDataSourceImpl({StorageService? storageService})
    : storageService = storageService ?? InMemoryStorageService();

  @override
  Future<List<PropertyModel>> getAuctions() async {
    return const [
      PropertyModel(
        id: 'auc_1',
        title: 'شقة مفروشة بالمشاية',
        location: 'المنصورة',
        price: '8 مليون',
        floor: 'الدور الرابع',
        area: '120 م²',
        rooms: '3 غرف',
        extraDetails: '4+',
        imageUrl: AppAssets.prop1,
        isForSale: true,
        category: 'شقة',
      ),
      PropertyModel(
        id: 'auc_2',
        title: 'فيلا فاخرة بموقع متميز',
        location: 'التجمع الخامس',
        price: '15 مليون',
        floor: 'طابقين + حديقة',
        area: '350 م²',
        rooms: '5 غرف',
        extraDetails: '3+',
        imageUrl: AppAssets.prop2,
        isForSale: true,
        category: 'فيلا',
      ),
      PropertyModel(
        id: 'auc_3',
        title: 'شقة دوبلكس بإطلالة بحرية',
        location: 'الإسكندرية',
        price: '6.5 مليون',
        floor: 'الدور السابع',
        area: '200 م²',
        rooms: '4 غرف',
        extraDetails: '2+',
        imageUrl: AppAssets.prop3,
        isForSale: true,
        category: 'شقة',
      ),
      PropertyModel(
        id: 'auc_4',
        title: 'شاليه بقرية سياحية راقية',
        location: 'الساحل الشمالي',
        price: '4.2 مليون',
        floor: 'أرضي بحديقة',
        area: '110 م²',
        rooms: '2 غرف',
        extraDetails: '2+',
        imageUrl: AppAssets.prop4,
        isForSale: true,
        category: 'شاليه',
      ),
      PropertyModel(
        id: 'auc_5',
        title: 'مكتب تجاري إداري مميز',
        location: 'الشيخ زايد',
        price: '5.8 مليون',
        floor: 'الدور الثاني',
        area: '90 م²',
        rooms: 'مفتوح',
        extraDetails: '1+',
        imageUrl: AppAssets.prop2,
        isForSale: true,
        category: 'مكتب',
      ),
    ];
  }

  @override
  Future<List<PropertyModel>> getFeaturedProperties() async {
    return const [
      PropertyModel(
        id: 'feat_1',
        title: 'شقة فاخرة بالحي الراقي',
        location: 'مدينة نصر',
        price: '7.5 مليون',
        floor: 'الدور الثالث',
        area: '160 م²',
        rooms: '3 غرف',
        extraDetails: '3+',
        imageUrl: AppAssets.prop1,
        isForSale: true,
        category: 'شقة',
      ),
      PropertyModel(
        id: 'feat_2',
        title: 'فيلا مستقلة مع مسبح خاص',
        location: 'الشيخ زايد',
        price: '22 مليون',
        floor: '3 طوابق',
        area: '450 م²',
        rooms: '6 غرف',
        extraDetails: '4+',
        imageUrl: AppAssets.prop2,
        isForSale: true,
        category: 'فيلا',
      ),
      PropertyModel(
        id: 'feat_3',
        title: 'محل تجاري بواجهة رئيسية',
        location: 'المنصورة',
        price: '9 مليون',
        floor: 'أرضي تجاري',
        area: '85 م²',
        rooms: 'مفتوح',
        extraDetails: '1+',
        imageUrl: AppAssets.prop3,
        isForSale: true,
        category: 'محل تجاري',
      ),
      PropertyModel(
        id: 'feat_4',
        title: 'شقة للإيجار السنوي المفروش',
        location: 'المعادي',
        price: '45 ألف/شهر',
        floor: 'الدور الخامس',
        area: '140 م²',
        rooms: '2 غرف',
        extraDetails: '2+',
        imageUrl: AppAssets.prop4,
        isForSale: false,
        category: 'شقة',
      ),
    ];
  }

  @override
  Future<List<PropertyModel>> getRecommendedProperties() async {
    return const [
      PropertyModel(
        id: 'rec_1',
        title: 'شقة مفروشة بالمشاية',
        location: 'المنصورة',
        price: '8 مليون',
        floor: 'الدور الرابع',
        area: '120 م²',
        rooms: '3 غرف',
        extraDetails: '4+',
        imageUrl: AppAssets.prop1,
        isForSale: true,
        category: 'شقة',
      ),
      PropertyModel(
        id: 'rec_2',
        title: 'فيلا حديثة بتصميم مودرن',
        location: 'القاهرة الجديدة',
        price: '18 مليون',
        floor: 'طابقين',
        area: '320 م²',
        rooms: '4 غرف',
        extraDetails: '3+',
        imageUrl: AppAssets.prop2,
        isForSale: true,
        category: 'فيلا',
      ),
      PropertyModel(
        id: 'rec_3',
        title: 'شقة استثمارية للإيجار',
        location: 'الدقي',
        price: '30 ألف/شهر',
        floor: 'الدور السادس',
        area: '135 م²',
        rooms: '3 غرف',
        extraDetails: '2+',
        imageUrl: AppAssets.prop3,
        isForSale: false,
        category: 'شقة',
      ),
      PropertyModel(
        id: 'rec_4',
        title: 'شاليه يطل على البحر مباشرة',
        location: 'العين السخنة',
        price: '5.5 مليون',
        floor: 'الدور الأول',
        area: '125 م²',
        rooms: '2 غرف',
        extraDetails: '2+',
        imageUrl: AppAssets.prop4,
        isForSale: true,
        category: 'شاليه',
      ),
    ];
  }

  @override
  Future<List<PropertyModel>> getNearbyProperties() async {
    return const [
      PropertyModel(
        id: 'near_1',
        title: 'شقة قريبة من جامعة المنصورة',
        location: 'حي الجامعة',
        price: '4.8 مليون',
        floor: 'الدور الثاني',
        area: '115 م²',
        rooms: '3 غرف',
        extraDetails: '2+',
        imageUrl: AppAssets.prop1,
        isForSale: true,
        category: 'شقة',
      ),
      PropertyModel(
        id: 'near_2',
        title: 'مكتب للإيجار في شارع المشاية',
        location: 'المشاية السفلية',
        price: '18 ألف/شهر',
        floor: 'الدور الأول',
        area: '75 م²',
        rooms: 'غرفتين',
        extraDetails: '1+',
        imageUrl: AppAssets.prop2,
        isForSale: false,
        category: 'مكتب',
      ),
      PropertyModel(
        id: 'near_3',
        title: 'شقة مطلة على النيل',
        location: 'المنصورة - النيل',
        price: '9.5 مليون',
        floor: 'الدور العاشر',
        area: '180 م²',
        rooms: '4 غرف',
        extraDetails: '3+',
        imageUrl: AppAssets.prop3,
        isForSale: true,
        category: 'شقة',
      ),
    ];
  }

  @override
  Future<Set<String>> getLikedIds() async {
    return await storageService.getStringSet(_likedKey);
  }

  @override
  Future<Set<String>> getStarredIds() async {
    return await storageService.getStringSet(_starredKey);
  }

  @override
  Future<void> saveLikedIds(Set<String> ids) async {
    await storageService.setStringSet(_likedKey, ids);
  }

  @override
  Future<void> saveStarredIds(Set<String> ids) async {
    await storageService.setStringSet(_starredKey, ids);
  }
}
