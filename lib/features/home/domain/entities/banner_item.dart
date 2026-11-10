import 'package:equatable/equatable.dart';

class BannerItem extends Equatable {
  final String id;
  final String image;
  final String title;
  final String subtitle;
  final String? targetUrl;

  const BannerItem({
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
    this.targetUrl,
  });

  @override
  List<Object?> get props => [id, image, title, subtitle, targetUrl];
}
