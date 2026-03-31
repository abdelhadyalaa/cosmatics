part of 'cubit.dart';

abstract class NewPasswordStates {}

class NewPasswordInitial extends NewPasswordStates {}

class NewPasswordLoading extends NewPasswordStates {}

class NewPasswordSuccess extends NewPasswordStates {}

class NewPasswordError extends NewPasswordStates {
  final String message;

  NewPasswordError(this.message);
}