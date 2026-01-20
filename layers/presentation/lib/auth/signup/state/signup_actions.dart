import 'package:domain/user/entity/user.dart';

sealed class SignedUpAction {}

class Signup extends SignedUpAction {}

class SaveUserData extends SignedUpAction {
  final User user;

  SaveUserData(this.user);
}
class UpdatePassword extends SignedUpAction {
  final String password;

  UpdatePassword(this.password);
}
