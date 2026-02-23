import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news_app/models/article_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/config/theme/app_colors.dart';
import 'custom_drawer_widget.dart';

class ArticleDetailsView extends StatelessWidget {
  final ArticleData article;

  const ArticleDetailsView({super.key, required this.article});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.sourceName), centerTitle: false),
      drawer: CustomDrawerWidget(
        onTap: () {
          // handle go home from details screen
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                article.description,
                style: const TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              SizedBox(height: 16),

              Bounceable(
                onTap: () => _launchURL(article.url),
                child: Row(
                  children: [
                    Text(
                      "By ",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      (article.author != null && article.author!.isNotEmpty)
                          ? article.author!
                          : article.sourceName,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),

              //todo: date formating
              Text(
                article.publishedAt,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(height: 16),

              Row(
                spacing: 16,
                children: const [
                  Icon(Icons.facebook),
                  Icon(Icons.close),
                  Icon(Icons.email_outlined),
                  Icon(Icons.link),
                ],
              ),
              SizedBox(height: 16),

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

              SizedBox(height: 8),
              Divider(color: AppColors.grey, thickness: 1),
              SizedBox(height: 8),

              Text(article.content, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
