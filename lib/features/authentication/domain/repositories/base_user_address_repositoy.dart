import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';

import '../entities/address_entity.dart';

abstract class BaseUserAddressRepositoy {
 Future<Either<Failure,AddressEntity>> getUserAddress();
  Future<Either<Failure,AddressEntity>> saveUserAddress(AddressEntity addressParams);
  Future<Either<Failure,bool>> cacheSavedUserAddress();
  Future<Either<Failure,AddressEntity>> getCachedUserAddress();
}