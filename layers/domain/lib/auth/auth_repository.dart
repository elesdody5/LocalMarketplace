import 'package:domain/user/entity/user.dart';

abstract class AuthRepository {
  Future<void> signup(User user, String password);
  Future<void> login(String username, String password);
}