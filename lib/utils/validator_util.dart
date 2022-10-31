import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/utils/email_validator.dart';
import 'package:devfestbolivia/models/validator_result.dart';

class ValidatorUtil {
  static ValidatorResult validateEmail(String? value) {
    ValidatorResult result = ValidatorResult(true, null);
    if (value == null || value.isEmpty) {
      result.isValid = false;
      result.message = TextStrings.pleaseEnterYourEmail;
      return result;
    }
    if (!EmailValidator.validate(value)) {
      result.isValid = false;
      result.message = TextStrings.pleaseEnterYourEmail;
    }
    return result;
  }

  static ValidatorResult validatePassword(String? value) {
    ValidatorResult result = ValidatorResult(true, null);
    if (value == null || value.isEmpty) {
      result.isValid = false;
      result.message = TextStrings.pleaseEnterYourPassword;
      return result;
    }

    if (value.isEmpty) {
      result.isValid = false;
      result.message = TextStrings.pleaseEnterYourPassword;
      return result;
    }
    return result;
  }
}
