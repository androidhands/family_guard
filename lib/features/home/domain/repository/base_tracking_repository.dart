import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/home/domain/usecases/add_new_user_location_usecase.dart';

abstract class BaseTrackingRepository {
  Future<Either<Failure, String>> addNewUserLocation(TrackingParams params);
  Future<Either<Failure, List<UserEntity>>> trackMyMembers(String accessToken);
}
