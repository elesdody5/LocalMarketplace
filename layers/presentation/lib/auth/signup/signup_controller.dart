import 'package:get/get.dart';
import 'package:domain/auth/usecase/signup_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/auth/signup/state/signup_events.dart';
import 'package:presentation/auth/signup/state/signup_state.dart';

import 'state/signup_actions.dart';

@injectable
class SignupController extends GetxController {
  final SignupUseCase signupUseCase;
  SignupController(this.signupUseCase);

  SignupState _state = SignupState();
  SignupEvent? event;
  bool termsAgreed = false;
  String? selectedCountry;
  String? selectedState;
  SignupState get state => _state;

  Future<void> signupAction(SignedUpAction action) async {
    if (action is SaveUserData) {
      _state = _state.copyWith(user: action.user);
      update();
    } else if (action is Signup) {
      await handleSignup();
    }
  }

  void setTermsAgreed(bool value) {
    termsAgreed = value;
    update();
  }


  Future<void> handleSignup() async {
    try {
      _state = _state.copyWith(isLoading: true);
      update();
      await signupUseCase.call(_state.user);
      event = SignupSuccessEvent();
      _state = _state.copyWith(isLoading: false);
      update();
    } catch (e) {
      event = SignupErrorEvent(e.toString());
      _state = _state.copyWith(isLoading: false);
      update();
    }
  }
}
