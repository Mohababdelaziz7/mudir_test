import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MudirApp());
}

// Backward-compatible alias for existing tests and references
typedef MyApp = MudirApp;
