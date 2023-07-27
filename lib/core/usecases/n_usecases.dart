

import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class NUseCases<Type>{
Future<Either<Failure, Type>> call();
}

