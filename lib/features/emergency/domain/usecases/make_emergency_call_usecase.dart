import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/network/api_endpoint.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/domain/repositories/base_emergency_calls_repository.dart';

class MakeEmergencyCallUsecase
    extends BaseUseCases<PhoneCallEntity, EmergencyCallParams> {
  final BaseEmergencyCallsRepository baseEmergencyCallsRepository;

  MakeEmergencyCallUsecase({required this.baseEmergencyCallsRepository});

  @override
  Future<Either<Failure, PhoneCallEntity>> call(EmergencyCallParams params) {
    return baseEmergencyCallsRepository.makeEmergencyCall(params);
  }
}

class EmergencyCallParams extends Equatable {
  final String accessToken;
  final String emergencyCase;
  final String street;
  final String state;
  final String city;
  final String country;
  final double currentLat;
  final double currentLon;
  final String to;
  const EmergencyCallParams(
      {required this.accessToken,
      required this.emergencyCase,
      required this.street,
      required this.state,
      required this.city,
      required this.country,
      required this.currentLat,
      required this.currentLon,
      required this.to});

  @override
  List<Object?> get props => [
        accessToken,
        emergencyCase,
        street,
        state,
        city,
        country,
        currentLat,
        currentLon,
        to
      ];

  Map<String, dynamic> toMap() {
    return {
      'api_password': ApiEndPoint.apiPassword,
      'emergency_case': emergencyCase,
      'street': street,
      'state': state,
      'city': city,
      'country': country,
      'current_lat': currentLat,
      'current_lon': currentLon,
      'to':to
    };
  }
}
