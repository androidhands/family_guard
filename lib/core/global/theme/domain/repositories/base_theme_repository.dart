import 'package:dartz/dartz.dart';

import '../../../../error/failure.dart';

abstract class BaseThemeRepository {
  Future<Either<Failure, void>> changeTheme({required int themeIndex});
}
