import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/config/theme/app_colors.dart';
import 'package:news_app/models/article_data.dart';
import 'package:news_app/models/category_data_model.dart';
import 'package:news_app/models/source_data_model.dart';
import 'package:news_app/network_handler/network_handler.dart';

class NewsDataView extends StatefulWidget {
  final CategoryDataModel categoryDataModel;

  const NewsDataView({super.key, required this.categoryDataModel});

  @override
  State<NewsDataView> createState() => _NewsDataViewState();
}

class _NewsDataViewState extends State<NewsDataView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NetworkHandler.getAllSources(widget.categoryDataModel.id),
      builder: (context, snapshot) {
        List<SourceData> sourcesList = snapshot.data ?? [];

        return Column(
          children: [
            DefaultTabController(
              length: sourcesList.length,
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                isScrollable: true,
                dividerColor: Colors.transparent,
                labelColor: AppColors.black,
                tabAlignment: TabAlignment.start,
                indicatorColor: AppColors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: List.generate(sourcesList.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return Text(
                    sourcesList[index].name,
                    style: TextStyle(
                      fontSize: isSelected ? 16 : 14,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: AppColors.black,
                    ),
                  );
                }),
              ),
            ),
            if (sourcesList.isNotEmpty)
              FutureBuilder(
                future: NetworkHandler.getAllArticles(
                  sourcesList[_selectedIndex].id,
                ),
                builder: (context, snapshot) {
                  List<ArticleData> articlesList = snapshot.data ?? [];
                  if (articlesList.isEmpty) {
                    return Center(child: Text("There are no articles here :)"));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: articlesList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.black),
                          ),
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              // ClipRRect(
                              //   borderRadius: BorderRadiusGeometry.circular(16),
                              //   child: Image.network(
                              //     articlesList[index].urlToImage,
                              //     height: 220,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              CachedNetworkImage(
                                imageUrl: articlesList[index].urlToImage,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      height: 220,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                placeholder: (context, url) => SizedBox(
                                  height: 220,
                                  width: double.infinity,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => SizedBox(
                                  height: 220,
                                  width: double.infinity,
                                  child: Icon(Icons.error_outline),
                                ),
                              ),
                              Text(
                                articlesList[index].title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'By: ${articlesList[index].sourceName}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  Text(
                                    articlesList[index].publishedAt,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            // else
            //   Text("There's no Articles here"),
          ],
        );
      },
    );
  }
}
