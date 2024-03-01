import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/repository/auth_supabase_repository.dart';
import '../../login/authentication/auth_screen.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState()) {
    getUser();
  }
  final _authRepository = AuthRepository();

  void logOut(BuildContext context) {
    _authRepository.singOut();
    context.goNamed(AuthScreen.name);
  }

  getUser() async {
    final user = await _authRepository.currentUser();
    final email = user.user?.email;
    final name = user.user?.userMetadata?['data']['name'];
    emit(state.copyWith(userName: name, userEmail: email));
  }

  void changePasswrod(String passwrod) {
    emit(state.copyWith(isPasswordValid: true,password: passwrod));
  }

  void changeConfirmPasswrod(String confirmPasswrod) {
    emit(state.copyWith(isPasswordValid: true,confirmPasswrod: confirmPasswrod));
  }

  void onPressedChangePassword(BuildContext context) {
    if (state.password == state.confirmPasswrod && state.password.isNotEmpty && state.confirmPasswrod.isNotEmpty) {
       emit(state.copyWith(isPasswordValid: true));
      _authRepository.updateUserPassword(
        newPassword: state.password,
      );
      Navigator.pop(context);
    } else {
      emit(state.copyWith(isPasswordValid: false));
    }
  }
}
