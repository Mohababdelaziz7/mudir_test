import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/di/injection_container.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/navigation/presentation/cubit/navigation_cubit.dart';
import '../features/notifications/presentation/cubit/header_status_cubit.dart';
import '../features/properties/presentation/cubit/property_cubit.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class MudirApp extends StatelessWidget {
  const MudirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(create: (_) => sl<NavigationCubit>()),
        BlocProvider<HeaderStatusCubit>(create: (_) => sl<HeaderStatusCubit>()),
        BlocProvider<HomeCubit>(create: (_) => sl<HomeCubit>()..loadHomeData()),
        BlocProvider<PropertyCubit>(
          create: (_) => sl<PropertyCubit>()..loadProperties(),
        ),
      ],
      child: MaterialApp(
        title: 'Mudir Test',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [Locale('ar', 'EG')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child ?? const SizedBox.shrink(),
          );
        },
        initialRoute: AppRouter.initialRoute,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
