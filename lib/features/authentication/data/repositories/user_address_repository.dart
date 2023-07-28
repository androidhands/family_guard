import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/data/datasource/base_user_address_data_source.dart';
import 'package:family_guard/features/authentication/domain/entities/address_entity.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_user_address_repositoy.dart';

import '../../../../core/error/exceptions.dart';

class UserAddressRepository implements BaseUserAddressRepositoy {
  final BaseUserAddressDataSource baseUserAddressDataSource;

  UserAddressRepository({required this.baseUserAddressDataSource});

  @override
  Future<Either<Failure, bool>> cacheSavedUserAddress() {
    // TODO: implement cacheSavedUserAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AddressEntity>> getCachedUserAddress() {
    // TODO: implement getCachedUserAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AddressEntity>> getUserAddress() {
    // TODO: implement getUserAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AddressEntity>> saveUserAddress(
      AddressEntity addressParams) async {
    try {
      return Right(
          await baseUserAddressDataSource.saveUserAddress(addressParams));
    } on ServerException catch (ex) {
      return Left(ServerFailure(message: ex.message, code: ex.code));
    }
  }
}
