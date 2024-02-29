import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError {
  invalid,
  mismatch,
}

class ConfirmedPassword extends FormzInput<String, ConfirmedPasswordValidationError> {
  final String password;

  const ConfirmedPassword.pure({
    this.password = ''
  }) : super.pure('');

  const ConfirmedPassword.dirty({
    required this.password,
    String value = ''
  }) : super.dirty(value);

  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == ConfirmedPasswordValidationError.invalid ) return 'El campo es requerido';
    if ( displayError == ConfirmedPasswordValidationError.mismatch ) return 'Confirmación de contraseña invalida';

    return null;
  }

  @override
  ConfirmedPasswordValidationError? validator(String value) {
    if (value.isEmpty) return ConfirmedPasswordValidationError.invalid;
    return password == value ? null : ConfirmedPasswordValidationError.mismatch;
  }
}