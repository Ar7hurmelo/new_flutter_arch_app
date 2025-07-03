// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_flutter_arch_app/app/shared/command.dart';

import '../../models/pessoa_model.dart';
import '../../repositories/imc_repository.dart';
import '../../../../shared/result.dart';

class ImcViewmodel extends ChangeNotifier {
  final ImcRepository imcRepository;
  late final Command0<double, String> calculateImcCommand;

  ImcViewmodel({required this.imcRepository}) {
    calculateImcCommand = Command0<double, String>(_calculateImc);
  }

  final pessoaModel = PessoalModel(weight: 0.0, height: 0.0);
  var imcValue = 0.0;
  var imcError = '';

  Future<Result<double, String>> _calculateImc() async {
    imcError = '';

    await Future.delayed(const Duration(milliseconds: 2000));

    final result = imcRepository.calculateImc(
      pessoaModel.weight,
      pessoaModel.height,
    );

    result.fold(
      (success) {
        imcValue = success;
      },
      (failure) {
        imcValue = 0.0;
        imcError = failure;
      },
    );

    notifyListeners();

    return result;
  }
}
