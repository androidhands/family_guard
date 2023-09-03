import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/exceptions.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/home/data/datasource/tracking_data_source.dart';
import 'package:family_guard/features/home/domain/repository/base_tracking_repository.dart';
import 'package:family_guard/features/home/domain/usecases/add_new_user_location_usecase.dart';

class TrackingRepository implements BaseTrackingRepository {
  final BaseTrackingDataSource baseTrackingDataSource;

  TrackingRepository({required this.baseTrackingDataSource});

  @override
  Future<Either<Failure, String>> addNewUserLocation(
      TrackingParams params) async {
    try {
      return Right(await baseTrackingDataSource.addNewUserLocation(params));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> trackMyMembers(String accessToken)async {
     try {
      return Right(await baseTrackingDataSource.trackMyMembers(accessToken));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}
