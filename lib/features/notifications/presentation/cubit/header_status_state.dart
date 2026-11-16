import 'package:equatable/equatable.dart';

class HeaderStatusState extends Equatable {
  final bool hasUnreadNotification;
  final bool hasUnreadMessage;
  final String userName;
  final String userStatus;

  const HeaderStatusState({
    this.hasUnreadNotification = true,
    this.hasUnreadMessage = false,
    this.userName = 'مهاب',
    this.userStatus = 'مجاني',
  });

  HeaderStatusState copyWith({
    bool? hasUnreadNotification,
    bool? hasUnreadMessage,
    String? userName,
    String? userStatus,
  }) {
    return HeaderStatusState(
      hasUnreadNotification:
          hasUnreadNotification ?? this.hasUnreadNotification,
      hasUnreadMessage: hasUnreadMessage ?? this.hasUnreadMessage,
      userName: userName ?? this.userName,
      userStatus: userStatus ?? this.userStatus,
    );
  }

  @override
  List<Object?> get props => [
    hasUnreadNotification,
    hasUnreadMessage,
    userName,
    userStatus,
  ];
}
