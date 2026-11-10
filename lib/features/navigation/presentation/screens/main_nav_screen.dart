import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ads/presentation/screens/ads_screen.dart';
import '../../../auctions/presentation/screens/auctions_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../projects/presentation/screens/projects_screen.dart';
import '../cubit/navigation_cubit.dart';
import '../cubit/navigation_state.dart';
import '../widgets/custom_nav_bar.dart';

class MainNavScreen extends StatelessWidget {
  const MainNavScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    ProjectsScreen(),
    AdsScreen(),
    AuctionsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return PopScope(
          canPop: state.selectedIndex == 0,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && state.selectedIndex != 0) {
              context.read<NavigationCubit>().selectTab(0);
            }
          },
          child: Scaffold(
            body: Stack(
              children: [
                IndexedStack(index: state.selectedIndex, children: _screens),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CustomNavBar(
                    selectedIndex: state.selectedIndex,
                    onItemTapped: (index) {
                      context.read<NavigationCubit>().selectTab(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
