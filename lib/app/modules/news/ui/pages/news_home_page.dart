import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_flutter_arch_app/app/modules/news/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../viewmodels/news_viewmodel.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  final newsViewmodel = Modular.get<NewsViewmodel>();

  @override
  void initState() {
    super.initState();

    newsViewmodel.getTopHeadlinesArticlesCommand.execute();

    newsViewmodel.addListener(() {
      setState(() {});
    });
  }

  _buildArticleTile(ArticleModel article) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            article.urlToImage ??
                'https://edmo.eu/wp-content/uploads/2023/04/EDMO-AI-COVER-thegem-blog-default-large.jpg',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          ListTile(
            title: Text(
              '${article.author ?? 'Autor Desconhecido'} | ${article.title}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            subtitle: Text(
              article.description ?? 'Sem descrição.',
              style: TextStyle(fontSize: 14.0, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Publicado em: ${article.publishedAt ?? 'Data desconhecida'}',
                  style: const TextStyle(fontSize: 13.0, color: Colors.grey),
                ),
                const SizedBox(height: 8.0),
                Text(
                  article.content ?? 'Conteúdo não disponível.',
                  style: const TextStyle(fontSize: 14.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Fonte: ${article.source.name ?? 'Fonte desconhecida'}',
                  style: const TextStyle(fontSize: 13.0, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {
              if (article.url != null) {
                final Uri launchUri = Uri.parse(article.url!);
                launchUrl(launchUri);
              }
            },
            child: Center(
              child: Text(
                article.url != null ? 'Acessar notícia' : '',
                style: TextStyle(
                  fontSize: 16.0,
                  color: article.url != null ? Colors.blue : Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Page')),
      body: Center(
        child: ListenableBuilder(
          listenable: newsViewmodel.getTopHeadlinesArticlesCommand,
          builder: (context, child) {
            if (newsViewmodel.getTopHeadlinesArticlesCommand.isExecuting) {
              return const CircularProgressIndicator();
            }

            if (newsViewmodel.getTopHeadlinesArticlesCommand.isFailure) {
              return Text(
                'Error: ${newsViewmodel.error}',
                style: TextStyle(color: Colors.red),
              );
            }

            final articles = newsViewmodel.topHeadlinesArticles;

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: _buildArticleTile(article),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
