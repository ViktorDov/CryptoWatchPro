part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final String userName;
  final String userEmail;
  final String password;
  final String confirmPasswrod;
  final bool isPasswordValid;

  const ProfileState({
    this.userName = '',
    this.userEmail = '',
    this.password = '',
    this.confirmPasswrod = '',
    this.isPasswordValid = false,
  });

  ProfileState copyWith({
    String? userName,
    String? userEmail,
    String? password,
    String? confirmPasswrod,
    bool? isPasswordValid,
  }) {
    return ProfileState(
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      password: password ?? this.password,
      confirmPasswrod: confirmPasswrod ?? this.confirmPasswrod,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }

  @override
  List<Object> get props => [userName, userEmail, password, confirmPasswrod];
}
