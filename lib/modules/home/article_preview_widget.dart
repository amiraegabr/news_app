import 'package:flutter/material.dart';
import 'package:news_app/core/config/theme/app_colors.dart';
import 'package:news_app/models/article_data.dart';

import 'article_details_view.dart';

class ArticlePreviewWidget extends StatelessWidget {
  final ArticleData article;

  const ArticlePreviewWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              article.urlToImage,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Text(
            article.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                backgroundColor: AppColors.scaffoldBackgroundColor,
                foregroundColor: AppColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleDetailsView(article: article),
                  ),
                );
              },
              child: const Text(
                "View Full Article",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
