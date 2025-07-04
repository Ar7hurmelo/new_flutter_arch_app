import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/article_model.dart';
import 'article_shime_widget.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleModel article;
  final bool isLoading;

  const ArticleWidget({
    super.key,
    required this.article,
    this.isLoading = false,
  });

  factory ArticleWidget.loading() {
    return ArticleWidget(article: ArticleModel.empty(), isLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ArticleShimmerWidget();
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl:
                  article.urlToImage ??
                  'https://edmo.eu/wp-content/uploads/2023/04/EDMO-AI-COVER-thegem-blog-default-large.jpg',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
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
                  'Fonte: ${article.source?.name ?? 'Fonte desconhecida'}',
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
}
