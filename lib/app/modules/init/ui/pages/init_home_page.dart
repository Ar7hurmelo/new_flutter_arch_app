import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InitHomePage extends StatelessWidget {
  const InitHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Modular.to.pushNamed('/imc');
              },
              child: const Text('IMC Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Modular.to.pushNamed('/news');
              },
              child: const Text('News Page'),
            ),
          ],
        ),
      ),
    );
  }
}
