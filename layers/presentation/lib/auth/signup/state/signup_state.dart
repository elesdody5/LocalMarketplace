import 'package:domain/user/entity/user.dart';

class SignupState {
  final User _user;
  final bool isLoading;
  final String? password;
  SignupState({User? user, this.isLoading = false, this.password}) : _user = user ?? User();

  User get user => _user;

  SignupState copyWith({
    User? user,
    bool? isLoading,
    String? password,
  }) {
    return SignupState(
      user: user ?? _user,
      isLoading: isLoading ?? this.isLoading,
      password: password ?? this.password,
    );
  }
}
