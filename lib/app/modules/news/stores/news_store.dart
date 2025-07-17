import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import '../../auth/stores/auth_store.dart';
import '../data/repositories/i_news_repository.dart';
import '../models/article_model.dart';

class NewsStore extends ChangeNotifier {
  final INewsRepository iNewsRepository;
  final AuthStore authStore;

  late final getTopHeadlinesArticlesCommand = Command0(
    _getTopHeadlinesArticles,
  );

  NewsStore({required this.authStore, required this.iNewsRepository});

  var topHeadlinesArticleList = <ArticleModel>[];
  var error = '';

  AsyncResult<List<ArticleModel>> _getTopHeadlinesArticles() async {
    final result = await iNewsRepository.getTopHeadlinesArticles();

    result.fold(
      (success) {
        topHeadlinesArticleList = success;
      },
      (failure) {
        error = 'Erro ao buscar artigos: ${failure.toString()} ';
        topHeadlinesArticleList = [];
      },
    );

    notifyListeners();
    return result;
  }

  void logout() {
    authStore.logout();
  }
}
