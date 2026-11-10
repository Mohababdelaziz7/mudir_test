import '../../domain/entities/location_item.dart';

class LocationModel extends LocationItem {
  const LocationModel({
    required super.id,
    required super.image,
    required super.title,
    required super.propertiesCount,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as String? ?? '',
      image: json['image'] as String? ?? '',
      title: json['title'] as String? ?? '',
      propertiesCount: json['propertiesCount'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'propertiesCount': propertiesCount,
    };
  }
}
