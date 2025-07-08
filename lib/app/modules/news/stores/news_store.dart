import 'package:flutter/material.dart';

import '../../../shared/command.dart';
import '../../../shared/result.dart';
import '../../auth/stores/auth_store.dart';
import '../data/repositories/i_news_repository.dart';
import '../models/article_model.dart';

class NewsStore extends ChangeNotifier {
  final INewsRepository iNewsRepository;
  final AuthStore authStore;

  late final Command0<List<ArticleModel>, String>
  getTopHeadlinesArticlesCommand;

  NewsStore({required this.authStore, required this.iNewsRepository}) {
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

  void logout() {
    authStore.logout();
  }
}
