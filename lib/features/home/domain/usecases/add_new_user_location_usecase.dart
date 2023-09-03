import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/home/domain/entity/tracking_entity.dart';
import 'package:family_guard/features/home/domain/repository/base_tracking_repository.dart';

class AddNewUserLocationUsecase extends BaseUseCases<String, TrackingParams> {
  final BaseTrackingRepository baseTrackingRepository;

  AddNewUserLocationUsecase({required this.baseTrackingRepository});

  @override
  Future<Either<Failure, String>> call(TrackingParams params) {
    return baseTrackingRepository.addNewUserLocation(params);
  }
}

class TrackingParams extends Equatable {
  final String accessToken;
  final TrackingEntity trackingEntity;

  const TrackingParams(
      {required this.accessToken, required this.trackingEntity});

  @override
  List<Object?> get props => [accessToken, trackingEntity];
}
