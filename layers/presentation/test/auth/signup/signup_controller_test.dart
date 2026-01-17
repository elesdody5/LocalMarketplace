import 'package:domain/auth/usecase/signup_usecase.dart';
import 'package:domain/user/entity/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/auth/signup/signup_controller.dart';
import 'package:presentation/auth/signup/state/signup_actions.dart';
import 'package:presentation/auth/signup/state/signup_events.dart';

import 'signup_controller_test.mocks.dart';

@GenerateMocks([SignupUseCase])
void main() {
  late MockSignupUseCase mockSignupUseCase;
  late SignupController signupController;
  setUp(() {
    mockSignupUseCase = MockSignupUseCase();
    signupController = SignupController(mockSignupUseCase);
  });

 test(
      "when user sign up with valid data the event should be updated with success",
      () async {
        var user = User();
        when(mockSignupUseCase.call(user)).thenAnswer((_) async => Future.value());
        await signupController.signupAction(SaveUserData(user));
        await signupController.signupAction(Signup());
        var actual = signupController.event;
        var matcher = isA<SignupSuccessEvent>();
        verify(mockSignupUseCase.call(user)).called(1);
        expect(actual, matcher);
      },
    );

    test(
      "when user sign up and an error occurs the event should be updated with error",
      () async {
        var user = User();
        final exception = Exception("signup failed");
        when(mockSignupUseCase.call(user)).thenThrow(exception);
        await signupController.signupAction(SaveUserData(user));
        await signupController.signupAction(Signup());
        var actual = signupController.event;
        var matcher = isA<SignupErrorEvent>();
        verify(mockSignupUseCase.call(user)).called(1);
        expect(actual, matcher);
      },
    );
}
