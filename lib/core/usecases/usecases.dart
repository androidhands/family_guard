import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class BaseUseCases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}


abstract class BaseUseCasesNoParams<Type> {
  Future<Either<Failure, Type>> call();
}





