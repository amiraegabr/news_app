import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article_data.dart';
import 'package:news_app/models/source_data_model.dart';
import 'package:news_app/network_handler/api_constants.dart';
import 'package:news_app/network_handler/end_points.dart';

class NetworkHandler {
  static Future<List<SourceData>> getAllSources(String categoryId) async {
    try {
      Map<String, dynamic> queryParameters = {
        "apiKey": ApiConstants.apiKey,
        "category": categoryId,
      };

      final response = await http.get(
        Uri.https(ApiConstants.baseUrl, EndPoints.allSources, queryParameters),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        SourceDataModel sourceDataModel = SourceDataModel.fromJson(data);

        return sourceDataModel.sources;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      throw Exception("Something went Wrong");
    }
  }

  static Future<List<ArticleData>> getAllArticles(String sourceId) async {
    try {
      Map<String, dynamic> queryParameters = {
        "apiKey": ApiConstants.apiKey,
        "sources": sourceId,
      };

      final response = await http.get(
        Uri.https(ApiConstants.baseUrl, EndPoints.allArticles, queryParameters),
      );
      List<ArticleData> articlesList = [];
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (var e in data["articles"]) {
          ArticleData articleData = ArticleData.fromJson(e);
          articlesList.add(articleData);
        }
        return articlesList;
      } else {
        throw Exception("Something went wrong!");
      }
    } catch (e) {
      throw Exception("Something went wrong!");
    }
  }
}
