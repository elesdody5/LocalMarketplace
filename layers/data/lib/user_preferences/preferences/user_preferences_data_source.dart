import 'package:domain/user_preferences/entity/user_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

import 'dto/user_preferences_dto.dart';

const String userPreferencesKey = 'user_preferences';

@injectable
class UserPreferencesDataSource {
  final GetStorage _getStorage;

  UserPreferencesDataSource(this._getStorage);

  Future<void> saveUserPreference(UserPreferences value) async {
    await _getStorage.write(userPreferencesKey, value.toJson());
  }

  UserPreferences? getUserPreference() {
    final json = _getStorage.read(userPreferencesKey);
    if (json == null) return null;
    return UserPreferencesExtension.fromJson(json);
  }

  Future<void> deletePreference() async {
    await _getStorage.remove(userPreferencesKey);
  }
}
