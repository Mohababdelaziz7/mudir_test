import 'package:equatable/equatable.dart';

enum AppTab { home, projects, ads, auctions, profile }

class NavigationState extends Equatable {
  final int selectedIndex;
  final AppTab currentTab;

  const NavigationState({
    this.selectedIndex = 0,
    this.currentTab = AppTab.home,
  });

  NavigationState copyWith({int? selectedIndex, AppTab? currentTab}) {
    return NavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, currentTab];
}
