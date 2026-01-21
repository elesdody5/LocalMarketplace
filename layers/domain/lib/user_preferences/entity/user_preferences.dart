class UserPreferences {
  final bool darkMode;
  final String language;
  final bool notificationsEnabled;

  UserPreferences({
    required this.darkMode,
    required this.language,
    required this.notificationsEnabled,
  });

  UserPreferences copyWith({
    bool? darkMode,
    String? language,
    bool? notificationsEnabled,
  }) {
    return UserPreferences(
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

