
import 'signup_screen.dart';
import 'state/signup_events.dart';

extension SignupStateHandler on SignupScreen {
  void observeSignupEvents(SignupEvent event) {
    if (event is SignupSuccessEvent) {
      // Handle signup success, e.g., navigate to the home screen
    } else if (event is SignupErrorEvent) {
      // Handle signup failure, e.g., show an error message
    }
  }
}
