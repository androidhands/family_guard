import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/entities/address_entity.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_user_address_repositoy.dart';

class SaveUserAddressUsecase
    extends BaseUseCases<AddressEntity, AddressEntity> {
  final BaseUserAddressRepositoy baseUserAddressRepositoy;

  SaveUserAddressUsecase({required this.baseUserAddressRepositoy});

  @override
  Future<Either<Failure, AddressEntity>> call(AddressEntity params) {
    return baseUserAddressRepositoy.saveUserAddress(params);
  }
}
