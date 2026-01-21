class LoginState {
  final String emailOrPhone;
  final String password;
  final bool isLoading;

  LoginState({
    this.emailOrPhone = '',
    this.password = '',
    this.isLoading = false,
  });

  LoginState copyWith({
    String? emailOrPhone,
    String? password,
    bool? isLoading,
  }) {
    return LoginState(
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
