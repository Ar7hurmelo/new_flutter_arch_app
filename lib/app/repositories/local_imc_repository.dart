import '../shared/result.dart';
import 'imc_repository.dart';

class LocalImcRepositoryImpl implements ImcRepository {
  @override
  Result<double, String> calculateImc(double weight, double height) {
    if (weight <= 0) {
      return Failure('Weight must be greater than zero.');
    }

    if (height <= 0) {
      return Failure('Height must be greater than zero.');
    }

    final imc = weight / (height * height);
    return Success(imc);
  }
}
