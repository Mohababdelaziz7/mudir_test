import 'package:equatable/equatable.dart';

class LocationItem extends Equatable {
  final String id;
  final String image;
  final String title;
  final String propertiesCount;

  const LocationItem({
    required this.id,
    required this.image,
    required this.title,
    required this.propertiesCount,
  });

  @override
  List<Object?> get props => [id, image, title, propertiesCount];
}
