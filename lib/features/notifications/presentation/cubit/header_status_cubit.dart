import 'package:flutter_bloc/flutter_bloc.dart';

import 'header_status_state.dart';

class HeaderStatusCubit extends Cubit<HeaderStatusState> {
  HeaderStatusCubit() : super(const HeaderStatusState());

  void toggleNotifications() {
    emit(state.copyWith(hasUnreadNotification: !state.hasUnreadNotification));
  }

  void toggleMessages() {
    emit(state.copyWith(hasUnreadMessage: !state.hasUnreadMessage));
  }

  void updateLocation(String newStatus) {
    emit(state.copyWith(userStatus: newStatus));
  }
}
