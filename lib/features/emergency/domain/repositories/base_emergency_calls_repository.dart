import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/emergency/domain/entities/add_new_caller_id_entity.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/domain/usecases/get_call_log_by_sid_usecase.dart';
import 'package:family_guard/features/emergency/domain/usecases/make_emergency_call_usecase.dart';

abstract  class BaseEmergencyCallsRepository {
Future<Either<Failure,bool>> checkVerifiedCallerId(String accessToken);
Future<Either<Failure,AddNewCallerIdEntity>> addNewCallerId(String accessToken);
Future<Either<Failure,PhoneCallEntity>> makeEmergencyCall(EmergencyCallParams emergencyCallParams);
 Future<Either<Failure,List<PhoneCallEntity>>> getCallsLog(String accessToken);
  Future<Either<Failure,PhoneCallEntity>> getCallLogBySid(CallLogParams callLogParams);
}