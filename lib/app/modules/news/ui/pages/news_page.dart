import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_flutter_arch_app/app/modules/news/models/article_model.dart';
import 'package:result_command/result_command.dart';

import '../../../auth/ui/widgets/logout_icon_button.dart';
import '../../stores/news_store.dart';
import '../widgets/article_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final newsStore = Modular.get<NewsStore>();

  @override
  void initState() {
    super.initState();

    newsStore.getTopHeadlinesArticlesCommand.execute();
  }

  Widget _buildLoadingIndicator() {
    // Exibe uma lista de placeholders com shimmer usando NewsWidget.loading
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ArticleWidget.loading(),
        childCount: 5,
      ),
    );
  }

  Widget _buildError() {
    return SliverToBoxAdapter(child: Text(newsStore.error));
  }

  Widget _buildArticles(List<ArticleModel> articles) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = articles[index];
        return ArticleWidget(article: item, isLoading: false);
      }, childCount: articles.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    var username = newsStore.authStore.loggedUser?.name ?? 'Usuário';

    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo, $username!'),
        actions: [LogoutIconButton()],
      ),
      body: Center(
        child: ListenableBuilder(
          listenable: newsStore.getTopHeadlinesArticlesCommand,
          builder: (context, child) {
            final status = newsStore.getTopHeadlinesArticlesCommand.value;

            return CustomScrollView(
              slivers: [
                if (status is RunningCommand)
                  _buildLoadingIndicator()
                else if (status is FailureCommand)
                  _buildError()
                else
                  _buildArticles(newsStore.topHeadlinesArticleList),
              ],
            );
          },
        ),
      ),
    );
  }
}
