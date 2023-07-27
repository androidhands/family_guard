import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int code;

  final String message;

  const Failure(this.code, this.message);

  @override
  List<Object?> get props => [
        code,
        message,
      ];
}

class ServerFailure extends Failure {
  const ServerFailure({required int code, required String message})
      : super(code, message);
}

class CacheFailure extends Failure {
  const CacheFailure({required int code, required String message})
      : super(code, message);
}

class UserFailure extends Failure {
  const UserFailure({required int code, required String message})
      : super(code, message);
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({required int code, required String message})
      : super(code, message);
}

class FailureException implements Exception {
  final int code;
  final String message;
  const FailureException({required this.code, required this.message});
}
