import 'package:get/get.dart';
import 'package:domain/auth/usecase/login_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/auth/login/state/login_events.dart';
import 'package:presentation/auth/login/state/login_state.dart';

import 'state/login_actions.dart';

@injectable
class LoginController extends GetxController {
  final LoginUseCase loginUseCase;
  LoginController(this.loginUseCase);

  LoginState _state = LoginState();
  Rxn<LoginEvent> event = Rxn<LoginEvent>();

  LoginState get state => _state;

  void loginAction(LoginAction action) {
    if (action is SaveLoginCredentials) {
      _state = _state.copyWith(
        emailOrPhone: action.emailOrPhone ?? _state.emailOrPhone,
        password: action.password ?? _state.password,
      );
      update();
    } else if (action is Login) {
      handleLogin();
    }
  }

  Future<void> handleLogin() async {
    try {
      _state = _state.copyWith(isLoading: true);
      update();

      await loginUseCase.call(_state.emailOrPhone, _state.password);

      _state = _state.copyWith(isLoading: false);
      update();
      event.value = LoginSuccessEvent();
    } catch (e) {
      event.value = LoginErrorEvent(e.toString());
      _state = _state.copyWith(isLoading: false);
      update();
    }
  }
}
