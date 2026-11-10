import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/banner_item.dart';
import '../../domain/entities/location_item.dart';
import '../../domain/entities/service_item.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<BannerItem> banners;
  final List<ServiceItem> services;
  final List<LocationItem> locations;
  final Failure? failure;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.banners = const [],
    this.services = const [],
    this.locations = const [],
    this.failure,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<BannerItem>? banners,
    List<ServiceItem>? services,
    List<LocationItem>? locations,
    Failure? failure,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      banners: banners ?? this.banners,
      services: services ?? this.services,
      locations: locations ?? this.locations,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    banners,
    services,
    locations,
    failure,
    errorMessage,
  ];
}
