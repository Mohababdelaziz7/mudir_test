import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void selectTab(int index) {
    if (index < 0 || index >= AppTab.values.length) return;
    if (state.selectedIndex == index) return;

    emit(
      state.copyWith(selectedIndex: index, currentTab: AppTab.values[index]),
    );
  }
}
