import 'package:result_dart/result_dart.dart';

import '../../models/article_model.dart';

abstract class INewsRepository {
  AsyncResult<List<ArticleModel>> getTopHeadlinesArticles();
}
