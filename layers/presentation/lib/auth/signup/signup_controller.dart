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
  Rxn<SignupEvent> event = Rxn<SignupEvent>();
  bool termsAgreed = false;
  String? selectedCountry;
  String? selectedState;
  SignupState get state => _state;

  // Sample data - replace with actual data source later
  final List<String> countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Spain',
    'Italy',
    'Japan',
    'China',
    'India',
    'Brazil',
    'Mexico',
    'Egypt',
    'Saudi Arabia',
    'UAE',
  ];

  final List<String> states = [
    'California',
    'Texas',
    'Florida',
    'New York',
    'Pennsylvania',
    'Illinois',
    'Ohio',
    'Georgia',
    'North Carolina',
    'Michigan',
  ];

  void setSelectedCountry(String? country) {
    selectedCountry = country;
    update();
  }

  void setSelectedState(String? state) {
    selectedState = state;
    update();
  }

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
      _state = _state.copyWith(isLoading: false);
      update();
      event.value = SignupSuccessEvent();
    } catch (e) {
      event.value = SignupErrorEvent(e.toString());
      _state = _state.copyWith(isLoading: false);
      update();
    }
  }
}
