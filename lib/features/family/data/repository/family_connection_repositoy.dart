import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/exceptions.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/data/data_source/family_connections_data_source.dart';
import 'package:family_guard/features/family/domain/repositories/base_family_connections_repository.dart';

class FamilyConnectionRepositoy implements BaseFamilyConnectionsRepository {
  final BaseFamilyConnectionsDataSource baseFamilyConnectionsDataSource;

  FamilyConnectionRepositoy({required this.baseFamilyConnectionsDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getFamilyConnections() async {
    try {
      return Right(
          await baseFamilyConnectionsDataSource.getFamilyConnections());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}
