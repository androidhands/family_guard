import '../../../../local_data/shared_preferences_services.dart';
import '../../../../services/dependency_injection_service.dart';
import '../../../../utils/app_constants.dart';

abstract class BaseThemeDataSource {
  Future<void> changeTheme({required int themeIndex});
}

class ThemeDataSource implements BaseThemeDataSource {
  @override
  Future<void> changeTheme({required int themeIndex}) async {
    await sl<SharedPreferencesServices>().saveData(
      key: AppConstants.storedThemeApp,
      value: themeIndex,
      dataType: DataType.int,
    );
  }
}
