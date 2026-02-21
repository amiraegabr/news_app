import 'package:flutter/material.dart';
import 'package:news_app/core/config/routes/page_route_names.dart';

import '../../core/gen/assets.gen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, PageRouteNames.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Assets.images.splashLightmode.image(
      fit: BoxFit.cover
    );
  }
}
