import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news_app/core/config/theme/app_colors.dart';

class CustomDrawerWidget extends StatelessWidget {
  final void Function() onTap;

  const CustomDrawerWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      width: MediaQuery.of(context).size.width * 0.6,

      child: Column(
        spacing: 20,
        children: [
          Container(
            height: 240,
            width: double.infinity,
            color: AppColors.ScaffoldBackgroundColor,
            child: Center(
              child: Text(
                'News App',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Bounceable(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                spacing: 8,
                children: [
                  Icon(Icons.home_rounded, size: 36, color: Colors.white),
                  Text(
                    'Go To Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.white, endIndent: 16, indent: 16),
          Bounceable(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                spacing: 8,
                children: [
                  Icon(
                    Icons.format_paint_outlined,
                    size: 36,
                    color: Colors.white,
                  ),
                  Text(
                    'Theme',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.white, endIndent: 16, indent: 16),
          Bounceable(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                spacing: 8,
                children: [
                  Icon(Icons.public, size: 36, color: Colors.white),
                  Text(
                    'Language',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
