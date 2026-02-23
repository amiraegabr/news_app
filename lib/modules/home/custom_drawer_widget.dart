import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news_app/core/config/theme/app_colors.dart';

class CustomDrawerWidget extends StatefulWidget {
  final void Function() onTap;

  const CustomDrawerWidget({super.key, required this.onTap});

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  String _selectedTheme = 'Light';
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      width: MediaQuery.of(context).size.width * 0.7,

      child: Column(
        spacing: 20,
        children: [
          Container(
            height: 240,
            width: double.infinity,
            color: AppColors.scaffoldBackgroundColor,
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
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                spacing: 12,
                children: [
                  Icon(Icons.home_rounded, size: 24, color: Colors.white),
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
          Divider(color: AppColors.grey, endIndent: 16, indent: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              spacing: 12,
              children: const [
                Icon(
                  Icons.format_paint_outlined,
                  size: 24,
                  color: Colors.white,
                ),
                Text(
                  'Theme',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _DropdownButton(
              value: _selectedTheme,
              items: const ['Dark', 'Light'],
              onChanged: (val) => setState(() => _selectedTheme = val!),
            ),
          ),

          Divider(color: AppColors.grey, endIndent: 16, indent: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              spacing: 12,
              children: const [
                Icon(Icons.language, size: 24, color: Colors.white),
                Text(
                  'Language',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _DropdownButton(
              value: _selectedLanguage,
              items: const ['English', 'Arabic', 'French'],
              onChanged: (val) => setState(() => _selectedLanguage = val!),
            ),
          ),
        ],
      ),
    );
  }
}

class _DropdownButton extends StatelessWidget {
  final String value;
  final List<String> items;
  final void Function(String?) onChanged;

  const _DropdownButton({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1E1E1E),
          iconEnabledColor: Colors.white,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
