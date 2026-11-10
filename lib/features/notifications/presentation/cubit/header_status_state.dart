import 'package:equatable/equatable.dart';

class HeaderStatusState extends Equatable {
  final bool hasUnreadNotification;
  final bool hasUnreadMessage;
  final String userName;
  final String userLocation;

  const HeaderStatusState({
    this.hasUnreadNotification = true,
    this.hasUnreadMessage = false,
    this.userName = 'مهاب',
    this.userLocation = 'المنصورة',
  });

  HeaderStatusState copyWith({
    bool? hasUnreadNotification,
    bool? hasUnreadMessage,
    String? userName,
    String? userLocation,
  }) {
    return HeaderStatusState(
      hasUnreadNotification:
          hasUnreadNotification ?? this.hasUnreadNotification,
      hasUnreadMessage: hasUnreadMessage ?? this.hasUnreadMessage,
      userName: userName ?? this.userName,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  @override
  List<Object?> get props => [
    hasUnreadNotification,
    hasUnreadMessage,
    userName,
    userLocation,
  ];
}
