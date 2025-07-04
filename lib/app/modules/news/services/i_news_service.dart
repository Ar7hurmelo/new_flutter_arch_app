import '../models/article_model.dart';

abstract class INewsService {
  Future<List<ArticleModel>> getTopHeadlinesArticles();
}
