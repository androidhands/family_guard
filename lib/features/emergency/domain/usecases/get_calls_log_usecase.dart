import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/domain/repositories/base_emergency_calls_repository.dart';

class GetCallsLogUsecase extends BaseUseCases<List<PhoneCallEntity>, String> {
  final BaseEmergencyCallsRepository baseEmergencyCallsRepository;

  GetCallsLogUsecase({required this.baseEmergencyCallsRepository});

  @override
  Future<Either<Failure, List<PhoneCallEntity>>> call(String params) {
    return baseEmergencyCallsRepository.getCallsLog(params);
  }
}
