import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String code;

  final String message;

  const Failure(this.code, this.message);

  @override
  List<Object?> get props => [
        code,
        message,
      ];
}

class ServerFailure extends Failure {
  const ServerFailure({required String code, required String message})
      : super(code, message);
}

class CacheFailure extends Failure {
  const CacheFailure({required String code, required String message})
      : super(code, message);
}

class UserFailure extends Failure {
  const UserFailure({required String code, required String message})
      : super(code, message);
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({required String code, required String message})
      : super(code, message);
}

class FailureException implements Exception {
  final String code;
  final String message;
  const FailureException({required this.code, required this.message});
}
