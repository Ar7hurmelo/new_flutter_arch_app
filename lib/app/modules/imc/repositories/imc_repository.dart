import '../shared/result.dart';

abstract class ImcRepository {
  Result<double, String> calculateImc(double weight, double height);
}
