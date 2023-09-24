import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/emergency/domain/repositories/base_emergency_calls_repository.dart';
import 'package:family_guard/features/emergency/domain/usecases/get_call_log_by_sid_usecase.dart';

class GetCallRecordUrlUsecase extends BaseUseCases<String, CallLogParams> {
  final BaseEmergencyCallsRepository baseEmergencyCallsRepository;

  GetCallRecordUrlUsecase({required this.baseEmergencyCallsRepository});

  @override
  Future<Either<Failure, String>> call(CallLogParams params) {
    return baseEmergencyCallsRepository.getCallRecordingUrl(params);
  }
}
