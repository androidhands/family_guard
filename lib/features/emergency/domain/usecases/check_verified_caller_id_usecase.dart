import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/emergency/domain/repositories/base_emergency_calls_repository.dart';

class CheckVerifiedCallerIdUsecase extends BaseUseCases<bool, String> {
  final BaseEmergencyCallsRepository baseEmergencyCallsRepository;

  CheckVerifiedCallerIdUsecase({required this.baseEmergencyCallsRepository});

  @override
  Future<Either<Failure, bool>> call(String params) {
    return baseEmergencyCallsRepository.checkVerifiedCallerId(params);
  }
}
