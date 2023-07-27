import 'package:dartz/dartz.dart';

import 'package:family_guard/core/error/failure.dart';

import '../../domain/repositories/base_theme_repository.dart';
import '../datasource/theme_datasource.dart';

class ThemeRepository extends BaseThemeRepository {
  BaseThemeDataSource baseThemeDataSource;
  ThemeRepository({required this.baseThemeDataSource});

  @override
  Future<Either<Failure, void>> changeTheme({required int themeIndex}) async {
    try {
      return Right(
          await baseThemeDataSource.changeTheme(themeIndex: themeIndex));
    } on FailureException catch (ex) {
      return Left(CacheFailure( message: ex.message, code: ex.code));
    }
  }
}
