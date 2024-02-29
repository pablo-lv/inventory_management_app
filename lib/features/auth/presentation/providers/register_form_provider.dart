import 'package:formz/formz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:inventory_management_app/features/shared/shared.dart';

class RegisterFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Name fullName;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.fullName = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmedPassword.pure()
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Name? fullName,
    Email? email,
    Password? password,
    ConfirmedPassword? confirmPassword
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword
  );

  @override
  String toString() {
    return 'RegisterFormState{isPosting: $isPosting, isFormPosted: $isFormPosted, isValid: $isValid, fullName: $fullName, email: $email, password: $password, confirmPassword: $confirmPassword}';
  }

}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {

  final Function(String, String, String) registerUserCallback;

  RegisterFormNotifier({
    required this.registerUserCallback,
  }): super(RegisterFormState());

  onFullNameChange(String value) {
    final fullName = Name.dirty(value);
    state = state.copyWith(
      fullName: fullName,
      isValid: Formz.validate([fullName, state.email, state.password, state.confirmPassword])
    );
  }

  onEmailChange(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password, state.fullName, state.confirmPassword])
    );
  }

  onPasswordChange(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.email, state.fullName, state.confirmPassword])
    );
  }

  onConfirmPasswordChange(String value) {
    final confirmPassword = ConfirmedPassword.dirty(password: state.password.value, value: value);
    state = state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate([confirmPassword, state.fullName, state.email, state.password])
    );
  }

  onFormSubmit() async{
    _touchEvertField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);
    await registerUserCallback(state.email.value, state.password.value, state.fullName.value);
    state = state.copyWith(isPosting: false);
  }

  _touchEvertField() {
    final fullName = Name.dirty(state.fullName.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmedPassword.dirty(password: state.password.value, value: state.confirmPassword.value);

    state = state.copyWith(
      fullName: fullName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isFormPosted: true,
      isValid: Formz.validate([fullName, email, password, confirmPassword])
    );
  }
}

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});