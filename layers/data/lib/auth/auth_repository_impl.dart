import 'package:domain/auth/auth_repository.dart';
import 'package:domain/user/entity/user.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<void> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> signup(User user, String password) {
    // TODO: implement signup
    throw UnimplementedError();
  }
  
}