import 'package:dartz/dartz.dart';

import 'package:family_guard/core/error/failure.dart';

import '../../../../usecases/usecases.dart';
import '../repositories/base_theme_repository.dart';

class SaveThemeUseCase extends BaseUseCases<void, int> {
  BaseThemeRepository baseThemeRepository;
  SaveThemeUseCase({required this.baseThemeRepository});
  @override
  Future<Either<Failure, void>> call(int params) async {
    return await baseThemeRepository.changeTheme(themeIndex: params);
  }
}
