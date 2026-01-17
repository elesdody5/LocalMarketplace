import 'package:domain/user/entity/user.dart';

class SignupState {
  final User _user;
  final bool isLoading;

  SignupState({User? user, this.isLoading = false}) : _user = user ?? User();

  User get user => _user;

  SignupState copyWith({
    User? user,
    bool? isLoading,
  }) {
    return SignupState(
      user: user ?? _user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
