import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/entities/address_entity.dart';
import 'package:family_guard/features/profile/domain/repositories/base_profile_repository.dart';

class GetUserAddressUsecase extends BaseUseCases<AddressEntity, String> {
  final BaseProfileRepository baseProfileRepository;

  GetUserAddressUsecase({required this.baseProfileRepository});

  @override
  Future<Either<Failure, AddressEntity>> call(String params) {
    return baseProfileRepository.getUserAddress(params);
  }
}
