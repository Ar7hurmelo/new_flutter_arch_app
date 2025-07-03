import '../shared/result.dart';
import 'imc_repository.dart';

class LocalImcRepositoryImpl implements ImcRepository {
  @override
  Result<double, String> calculateImc(double weight, double height) {
    if (weight <= 0 || height <= 0) {
      return Failure('Peso ou altura inválidos.');
    }

    final imc = weight / (height * height);
    return Success(imc);
  }
}
