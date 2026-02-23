import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article_data.dart';
import 'package:news_app/models/source_data_model.dart';
import 'package:news_app/network_handler/api_constants.dart';
import 'package:news_app/network_handler/end_points.dart';

class NetworkHandler {
  static Future<List<SourceData>> getAllSources(String categoryId) async {
    try {
      final response = await http.get(
        Uri.https(ApiConstants.baseUrl, EndPoints.allSources, {
          "apiKey": ApiConstants.apiKey,
          "category": categoryId,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return SourceDataModel.fromJson(data).sources;
      } else {
        throw Exception("Status ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ArticleData>> getAllArticles(
    String sourceId, {
    int page = 1,
  }) async {
    try {
      final response = await http.get(
        Uri.https(ApiConstants.baseUrl, EndPoints.allArticles, {
          "apiKey": ApiConstants.apiKey,
          "sources": sourceId,
          "page": page.toString(),
          "pageSize": "10",
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<ArticleData> articlesList = [];
        for (var e in data["articles"]) {
          articlesList.add(ArticleData.fromJson(e));
        }
        return articlesList;
      } else {
        throw Exception("Status ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ArticleData>> searchArticles(
    String query, {
    int page = 1,
  }) async {
    try {
      final response = await http.get(
        Uri.https(ApiConstants.baseUrl, EndPoints.allArticles, {
          "apiKey": ApiConstants.apiKey,
          "q": query,
          "page": page.toString(),
          "pageSize": "10",
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<ArticleData> articlesList = [];
        for (var e in data["articles"]) {
          articlesList.add(ArticleData.fromJson(e));
        }
        return articlesList;
      } else {
        throw Exception("Status ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
