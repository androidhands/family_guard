import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/network/api_endpoint.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/domain/repositories/base_emergency_calls_repository.dart';

class GetCallLogBySidUsecase
    extends BaseUseCases<PhoneCallEntity, CallLogParams> {
  final BaseEmergencyCallsRepository baseEmergencyCallsRepository;

  GetCallLogBySidUsecase({required this.baseEmergencyCallsRepository});

  @override
  Future<Either<Failure, PhoneCallEntity>> call(CallLogParams params) {
    return baseEmergencyCallsRepository.getCallLogBySid(params);
  }
}

class CallLogParams extends Equatable {
  final String accessToken;
  final String sid;

  const CallLogParams(this.accessToken, this.sid);

  @override
  List<Object?> get props => [accessToken, sid];

  Map<String, dynamic> toMap() {
    return {'api_password': ApiEndPoint.apiPassword, 'sid': sid};
  }
}
