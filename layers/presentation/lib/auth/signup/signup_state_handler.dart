import 'package:get/get_rx/get_rx.dart';
import 'package:presentation/widgets/error_snackbar.dart';

import 'signup_screen.dart';
import 'state/signup_events.dart';

extension SignupStateHandler on SignupScreen {
  void observeSignupEvents(Rxn<SignupEvent> event) {
    ever(event, (value) {
      if (value is SignupSuccessEvent) {
        // Handle signup success, e.g., navigate to the home screen
      } else if (value is SignupErrorEvent) {
        ErrorSnackbar.showValidationError(message: value.message);
      }
    });
  }
}
