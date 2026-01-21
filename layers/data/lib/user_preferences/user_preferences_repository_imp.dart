import 'package:data/user_preferences/preferences/user_preferences_data_source.dart';
import 'package:domain/user_preferences/entity/user_preferences.dart';
import 'package:domain/user_preferences/user_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserPreferencesRepository)
class UserPreferencesRepositoryImp extends UserPreferencesRepository {
  final UserPreferencesDataSource _dataSource;

  UserPreferencesRepositoryImp(this._dataSource);

  @override
  UserPreferences? getUserPreferences() {
    return _dataSource.getUserPreference();
  }

  @override
  Future<void> updateUserPreferences(UserPreferences preferences) {
    return _dataSource.saveUserPreference(preferences);
  }
}
