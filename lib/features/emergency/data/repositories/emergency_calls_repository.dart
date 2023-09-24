import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/exceptions.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/emergency/data/data_source/emergency_calls_datasource.dart';
import 'package:family_guard/features/emergency/domain/entities/add_new_caller_id_entity.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/domain/repositories/base_emergency_calls_repository.dart';
import 'package:family_guard/features/emergency/domain/usecases/get_call_log_by_sid_usecase.dart';
import 'package:family_guard/features/emergency/domain/usecases/make_emergency_call_usecase.dart';

class EmergencyCallsRepository implements BaseEmergencyCallsRepository {
  final BaseEmergencyCallsDatasource baseEmergencyCallsDatasource;

  EmergencyCallsRepository({required this.baseEmergencyCallsDatasource});

  @override
  Future<Either<Failure, bool>> checkVerifiedCallerId(
      String accessToken) async {
    try {
      return Right(await baseEmergencyCallsDatasource
          .checkVerifiedCallerId(accessToken));
    } on ServerException catch (e) {
      return Left(ServerFailure(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<Failure, AddNewCallerIdEntity>> addNewCallerId(
      String accessToken) async {
    try {
      return Right(
          await baseEmergencyCallsDatasource.addNewCallerId(accessToken));
    } on ServerException catch (e) {
      return Left(ServerFailure(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<Failure, PhoneCallEntity>> makeEmergencyCall(
      EmergencyCallParams emergencyCallParams) async {
    try {
      return Right(await baseEmergencyCallsDatasource
          .makeEmergencyCall(emergencyCallParams));
    } on ServerException catch (e) {
      return Left(ServerFailure(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<Failure, PhoneCallEntity>> getCallLogBySid(
      CallLogParams callLogParams) async {
    try {
      return Right(
          await baseEmergencyCallsDatasource.getCallLogBySid(callLogParams));
    } on ServerException catch (e) {
      return Left(ServerFailure(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<PhoneCallEntity>>> getCallsLog(
      String accessToken) async {
    try {
      return Right(await baseEmergencyCallsDatasource.getCallsLog(accessToken));
    } on ServerException catch (e) {
      return Left(ServerFailure(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getCallRecordingUrl(
      CallLogParams callLogParams) async {
    try {
      return Right(await baseEmergencyCallsDatasource
          .getCallRecordingUrl(callLogParams));
    } on ServerException catch (e) {
      return Left(ServerFailure(code: e.code, message: e.message));
    }
  }
}
