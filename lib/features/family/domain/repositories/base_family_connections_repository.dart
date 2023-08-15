import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';

import '../../../authentication/domain/entities/user_entity.dart';

abstract class BaseFamilyConnectionsRepository {
Future<Either<Failure,List<UserEntity>>> getFamilyConnections();
}