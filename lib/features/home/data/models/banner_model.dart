import '../../domain/entities/banner_item.dart';

class BannerModel extends BannerItem {
  const BannerModel({
    required super.id,
    required super.image,
    required super.title,
    required super.subtitle,
    super.targetUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String? ?? '',
      image: json['image'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      targetUrl: json['targetUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'subtitle': subtitle,
      'targetUrl': targetUrl,
    };
  }
}
