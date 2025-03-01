import 'package:flutter/material.dart';
import 'package:olofooto/core/common/resources/style/app_theme.dart';
import 'package:olofooto/core/services/routes/router.imports.dart';

void main() {
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
