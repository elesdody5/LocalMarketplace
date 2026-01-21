import 'package:domain/user_preferences/entity/user_preferences.dart';

extension UserPreferencesExtension on UserPreferences {
  Map<String, dynamic> toJson() {
    return {
      'darkMode': darkMode,
      'language': language,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  static UserPreferences fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      darkMode: json['darkMode'] as bool,
      language: json['language'] as String,
      notificationsEnabled: json['notificationsEnabled'] as bool,
    );
  }
}