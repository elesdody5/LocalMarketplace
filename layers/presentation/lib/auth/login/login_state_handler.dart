import 'package:get/get_rx/get_rx.dart';
import 'package:get/get.dart';
import 'package:presentation/widgets/error_snackbar.dart';
import 'package:presentation/routes/routes.dart';

import 'state/login_events.dart';

void observeLoginEvents(Rxn<LoginEvent> event) {
  ever(event, (value) {
    if (value is LoginSuccessEvent) {
      // Navigate to home screen using offAllNamed to prevent back navigation
      Get.offAllNamed(homeRouteName);
    } else if (value is LoginErrorEvent) {
      ErrorSnackbar.showValidationError(message: value.message);
    }
  });
}
