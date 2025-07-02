// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/pessoa_model.dart';
import '../repositories/imc_repository.dart';

class ImcViewmodel extends ChangeNotifier {
  final ImcRepository imcRepository;
  final pessoaModel = PessoalModel(weight: 0.0, height: 0.0);
  var resultado = 0.0;

  ImcViewmodel({required this.imcRepository});

  void calculateImc() {
    final result = imcRepository.calculateImc(
      pessoaModel.weight,
      pessoaModel.height,
    );

    result.fold(
      (success) {
        resultado = success;
      },
      (failure) {
        resultado = 0.0; // Reset to 0.0 or handle error as needed
        // You can also show a dialog or snackbar with the error message if needed
      },
    );

    notifyListeners();
  }
}
