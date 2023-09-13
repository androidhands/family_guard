import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/emergency/domain/entities/add_new_caller_id_entity.dart';
import 'package:family_guard/features/emergency/domain/repositories/base_emergency_calls_repository.dart';

class AddNewCallerIdUsecase extends BaseUseCases<AddNewCallerIdEntity, String> {
  final BaseEmergencyCallsRepository baseEmergencyCallsRepository;

  AddNewCallerIdUsecase({required this.baseEmergencyCallsRepository});

  @override
  Future<Either<Failure, AddNewCallerIdEntity>> call(String params) {
    return baseEmergencyCallsRepository.addNewCallerId(params);
  }
}
