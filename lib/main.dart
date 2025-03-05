import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/app_theme.dart';
import 'package:olofooto/core/services/injections/injection_container.imports.dart';
import 'package:olofooto/core/services/routes/router.imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const Olofooto());
}

class Olofooto extends StatelessWidget {
  const Olofooto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      theme: AppTheme.appTheme,
    );
  }
}
