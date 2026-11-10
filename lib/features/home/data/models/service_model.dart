import '../../domain/entities/service_item.dart';

class ServiceModel extends ServiceItem {
  const ServiceModel({
    required super.id,
    required super.image,
    required super.title,
    required super.subtitle,
    super.isNew = false,
    required super.actionType,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String? ?? '',
      image: json['image'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      isNew: json['isNew'] as bool? ?? false,
      actionType: json['actionType'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'subtitle': subtitle,
      'isNew': isNew,
      'actionType': actionType,
    };
  }
}
