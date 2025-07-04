import 'package:flutter/material.dart';

import '../../../../shared/command.dart';
import '../../../../shared/result.dart';
import '../../models/article_model.dart';
import '../../repositories/i_news_repository.dart';

class NewsViewmodel extends ChangeNotifier {
  INewsRepository iNewsRepository;
  late final Command0<List<ArticleModel>, String>
  getTopHeadlinesArticlesCommand;

  NewsViewmodel({required this.iNewsRepository}) {
    getTopHeadlinesArticlesCommand = Command0<List<ArticleModel>, String>(
      _getTopHeadlinesArticles,
    );
  }

  var topHeadlinesArticles = <ArticleModel>[];
  var error = '';

  Future<Result<List<ArticleModel>, String>> _getTopHeadlinesArticles() async {
    final result = await iNewsRepository.getTopHeadlinesArticles();

    result.fold(
      (success) {
        topHeadlinesArticles = success;
      },
      (failure) {
        error = failure;
        topHeadlinesArticles = [];
      },
    );

    notifyListeners();
    return result;
  }
}
