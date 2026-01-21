import 'package:domain/user_preferences/entity/user_preferences.dart';

abstract class UserPreferencesRepository {
  Future<void> updateUserPreferences(UserPreferences preferences);

  UserPreferences? getUserPreferences();
}
