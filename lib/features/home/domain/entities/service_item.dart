import 'package:equatable/equatable.dart';

class ServiceItem extends Equatable {
  final String id;
  final String image;
  final String title;
  final String subtitle;
  final bool isNew;
  final String actionType;

  const ServiceItem({
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
    this.isNew = false,
    required this.actionType,
  });

  @override
  List<Object?> get props => [id, image, title, subtitle, isNew, actionType];
}
