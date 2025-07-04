import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArticleShimmerWidget extends StatelessWidget {
  const ArticleShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(8.0),
        height: 170.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20.0, width: double.infinity, color: Colors.grey),
            const SizedBox(height: 8.0),
            Container(height: 14.0, width: double.infinity, color: Colors.grey),
            const SizedBox(height: 8.0),
            Container(height: 12.0, width: 100.0, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
