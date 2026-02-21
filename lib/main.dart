import 'package:flutter/material.dart';
import 'package:news_app/core/config/routes/app_router.dart';
import 'package:news_app/core/config/theme/theme_manager.dart';

import 'core/config/routes/page_route_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: PageRouteNames.initial,
      onGenerateRoute: AppRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,

      theme: ThemeManager.getLightTheme()
    );
  }
}
