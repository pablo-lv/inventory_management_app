import 'package:formz/formz.dart';

// Define input validation errors
enum CategoryError { empty }

// Extend FormzInput and provide the input type and error type.
class Category extends FormzInput<String, CategoryError> {

  // Call super.pure to represent an unmodified form input.
  const Category.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Category.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == CategoryError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CategoryError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return CategoryError.empty;

    return null;
  }
}