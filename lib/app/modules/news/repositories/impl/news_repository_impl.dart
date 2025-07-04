import '../../../../shared/result.dart';
import '../../models/article_model.dart';
import '../../services/i_news_service.dart';
import '../i_news_repository.dart';

class NewsRepositoryImpl implements INewsRepository {
  INewsService iNewsService;

  NewsRepositoryImpl({required this.iNewsService});

  @override
  Future<Result<List<ArticleModel>, String>> getTopHeadlinesArticles() async {
    try {
      final articles = await iNewsService.getTopHeadlinesArticles();
      return Success(articles);
    } catch (e) {
      return Failure('Failed to load top headlines: $e');
    }
  }
}
