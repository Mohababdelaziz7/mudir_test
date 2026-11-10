import '../../domain/entities/property.dart';

class PropertyModel extends Property {
  const PropertyModel({
    required super.id,
    required super.title,
    required super.location,
    required super.price,
    required super.floor,
    required super.area,
    required super.rooms,
    required super.extraDetails,
    required super.imageUrl,
    super.isForSale = true,
    super.category = 'الكل',
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'شقة مفروشة بالمشاية',
      location: json['location'] as String? ?? 'المنصورة',
      price: json['price'] as String? ?? '8 مليون',
      floor: json['floor'] as String? ?? 'الدور الرابع',
      area: json['area'] as String? ?? '120 م²',
      rooms: json['rooms'] as String? ?? '3 غرف',
      extraDetails: json['extraDetails'] as String? ?? '4+',
      imageUrl: json['imageUrl'] as String? ?? 'assets/a4.jpg',
      isForSale: json['isForSale'] as bool? ?? true,
      category: json['category'] as String? ?? 'شقة',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'price': price,
      'floor': floor,
      'area': area,
      'rooms': rooms,
      'extraDetails': extraDetails,
      'imageUrl': imageUrl,
      'isForSale': isForSale,
      'category': category,
    };
  }
}
