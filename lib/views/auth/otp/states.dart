part of 'cubit.dart';

abstract class OTPState {}

class OTPInitial extends OTPState {}

class OTPLoading extends OTPState {}

class OTPResendLoading extends OTPState {}

class OTPSuccess extends OTPState {
  final String message;
  final bool isFromCreateAccount;
  final String phone;

  OTPSuccess({
    required this.message,
    required this.isFromCreateAccount,
    required this.phone,
  });
}

class OTPResendSuccess extends OTPState {
  final String message;
  OTPResendSuccess(this.message);
}

class OTPError extends OTPState {
  final String message;
  OTPError(this.message);
}