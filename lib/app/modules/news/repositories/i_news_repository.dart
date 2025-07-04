import '../../../shared/result.dart';
import '../models/article_model.dart';

abstract class INewsRepository {
  Future<Result<List<ArticleModel>, String>> getTopHeadlinesArticles();
}
