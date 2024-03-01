part of 'registration_cubit.dart';

class RegistrationState extends Equatable {
  final Email email;
  final String name;
  final Password password;
  final String? errorMessage;
  final FormzSubmissionStatus status;
  final bool isValid;

  const RegistrationState({
    this.name = '',
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  RegistrationState copyWith({
    String? name,
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return RegistrationState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, password, status, isValid, errorMessage, name];
}

abstract class RegistrationEvent extends RegistrationState {}
