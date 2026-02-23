import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../core/config/theme/app_colors.dart';
import '../../models/article_data.dart';
import 'article_preview_widget.dart';

class ArticleCardWidget extends StatelessWidget {
  final ArticleData article;
  const ArticleCardWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => ArticlePreviewWidget(article: article),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.black),
        ),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
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
              imageUrl: article.urlToImage,
              imageBuilder: (context, imageProvider) => Container(
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
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => SizedBox(
                height: 220,
                width: double.infinity,
                child: Icon(Icons.error_outline),
              ),
            ),
            Text(
              article.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'By: ${article.sourceName}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
                Text(
                  article.publishedAt,
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
      ),
    );
  }
}
