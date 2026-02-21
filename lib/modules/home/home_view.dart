import 'package:flutter/material.dart';
import 'package:news_app/models/category_data_model.dart';
import 'package:news_app/modules/home/custom_drawer_widget.dart';
import 'package:news_app/modules/home/news_data_view.dart';

import '../../core/gen/assets.gen.dart';
import 'category_card_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<CategoryDataModel> categoriesList = [
    CategoryDataModel(
      id: 'general',
      title: 'General',
      image: Assets.images.generalDark.path,
      lightImage: Assets.images.general.path,
    ),
    CategoryDataModel(
      id: 'business',
      title: 'Business',
      image: Assets.images.busniessDark.path,
      lightImage: Assets.images.busniess.path,
    ),
    CategoryDataModel(
      id: 'sports',
      title: 'Sports',
      image: Assets.images.sportDark.path,
      lightImage: Assets.images.sport.path,
    ),
    CategoryDataModel(
      id: 'technology',
      title: 'Technology',
      image: Assets.images.technologyDark.path,
      lightImage: Assets.images.technology.path,
    ),
    CategoryDataModel(
      id: 'entertainment',
      title: 'Entertainment',
      image: Assets.images.entertainmentDark.path,
      lightImage: Assets.images.entertainment.path,
    ),
    CategoryDataModel(
      id: 'health',
      title: 'Health',
      image: Assets.images.helthDark.path,
      lightImage: Assets.images.helth.path,
    ),
    CategoryDataModel(
      id: 'science',
      title: 'Science',
      image: Assets.images.scienceDark.path,
      lightImage: Assets.images.science.path,
    ),
  ];

  CategoryDataModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.menu),
        title: Text(selectedCategory?.title ?? "News App"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              onPressed: () {},
              icon: Assets.icons.searchIconLightmode.svg(),
            ),
          ),
        ],
      ),
      drawer: CustomDrawerWidget(onTap: _goToHome),
      body: selectedCategory == null
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning\nHere's Some News For You",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ...List.generate(categoriesList.length, (index) {
                      return CategoryCardWidget(
                        onTap: _onCategoryTap,
                        isLeft: index % 2 == 0,
                        categoryDataModel: categoriesList[index],
                      );
                    }),
                  ],
                ),
              ),
            )
          : NewsDataView(categoryDataModel: selectedCategory!),
    );
  }

  void _onCategoryTap(CategoryDataModel categoryDataMadel) {
    setState(() {
      selectedCategory = categoryDataMadel;
    });
  }

  void _goToHome() {
    setState(() {
      selectedCategory = null;
      Navigator.pop(context);
    });
  }
}
