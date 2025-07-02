import 'package:flutter/material.dart';
import 'package:new_flutter_arch_app/app/repositories/local_imc_repository.dart';

import '../viewmodels/imc_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final imcViewmodel = ImcViewmodel(imcRepository: LocalImcRepositoryImpl());

  @override
  void initState() {
    super.initState();

    imcViewmodel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IMC Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                imcViewmodel.pessoaModel.weight = double.tryParse(value) ?? 0.0;
                imcViewmodel.calculateImc();
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Altura (m)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                imcViewmodel.pessoaModel.height = double.tryParse(value) ?? 0.0;
                imcViewmodel.calculateImc();
              },
            ),
            const SizedBox(height: 20),
            Text(
              'IMC: ${imcViewmodel.resultado.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
