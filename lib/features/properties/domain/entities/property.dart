import 'package:equatable/equatable.dart';

class Property extends Equatable {
  final String id;
  final String title;
  final String location;
  final String price;
  final String floor;
  final String area;
  final String rooms;
  final String extraDetails;
  final String imageUrl;
  final bool isForSale;
  final String category;

  const Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.floor,
    required this.area,
    required this.rooms,
    required this.extraDetails,
    required this.imageUrl,
    this.isForSale = true,
    this.category = 'الكل',
  });

  @override
  List<Object?> get props => [
    id,
    title,
    location,
    price,
    floor,
    area,
    rooms,
    extraDetails,
    imageUrl,
    isForSale,
    category,
  ];
}
