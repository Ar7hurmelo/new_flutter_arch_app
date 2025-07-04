import '../../../../config/api_service.dart';
import '../../models/article_model.dart';
import '../i_news_service.dart';

class NewsServiceImpl implements INewsService {
  ApiService apiService;

  NewsServiceImpl({required this.apiService});

  @override
  Future<List<ArticleModel>> getTopHeadlinesArticles() async {
    try {
      final response = await apiService.getRequest(
        '/top-headlines',
        queryParameters: {
          'country': 'us',
          'apiKey': apiService.apiKey,
          'pageSize': 14,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data['articles'] as List;

        print(data.length);

        final articlesData = data.map((e) {
          return e as Map<String, dynamic>;
        }).toList();

        final result = articlesData.map((e) {
          return ArticleModel.fromMap(e);
        }).toList();
        return result;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
