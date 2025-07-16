import 'package:new_flutter_arch_app/app/modules/news/models/article_model.dart';
import 'package:result_dart/result_dart.dart';

import '../../services/i_news_service.dart';
import '../i_news_repository.dart';

class NewsRepositoryImpl implements INewsRepository {
  INewsService iNewsService;

  NewsRepositoryImpl({required this.iNewsService});

  @override
  AsyncResult<List<ArticleModel>> getTopHeadlinesArticles() async {
    try {
      final articles = await iNewsService.getTopHeadlinesArticles();
      return Success(articles);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
