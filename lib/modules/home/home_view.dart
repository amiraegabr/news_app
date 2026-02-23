import 'package:flutter/material.dart';
import 'package:news_app/models/article_data.dart';
import 'package:news_app/models/category_data_model.dart';
import 'package:news_app/modules/home/categories_view_widget.dart';
import 'package:news_app/modules/home/custom_drawer_widget.dart';
import 'package:news_app/modules/home/news_data_view.dart';

import 'article_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoryDataModel? selectedCategory;
  ArticleData? selectedArticle;

  String? searchQuery;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              )
            : Text(selectedCategory?.title ?? "News App"),
        actions: [
          if (selectedArticle == null)
            IconButton(
              onPressed: () {
                setState(() {
                  if (isSearching) {
                    searchQuery = null;
                  }
                  isSearching = !isSearching;
                });
              },
              icon: isSearching ? Icon(Icons.close) : Icon(Icons.search),
            ),
        ],
      ),
      drawer: CustomDrawerWidget(onTap: _goToHome),
      body: selectedArticle != null
          ? ArticleDetailsView(article: selectedArticle!)
          : selectedCategory == null
          ? CategoriesViewWidget(
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            )
          : NewsDataView(
              categoryDataModel: selectedCategory!,
              searchQuery: searchQuery,
            ),
    );
  }

  void _goToHome() {
    setState(() {
      selectedCategory = null;
      Navigator.pop(context);
    });
  }
}
