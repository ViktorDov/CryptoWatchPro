import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../../data/repository/auth_supabase_repository.dart';
import '../../../home/home_screen.dart';
import '../../exeptions/exeptions.dart';
import '../../validation/credentials_validation.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  final _auth = AuthRepository();

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithCredentials(BuildContext context) async {
    if (!state.isValid) {
      print('sta: ${state.email.value}, state: ${state.password.value}');
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: 'Invalid email or password',
      ));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _auth.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      context.goNamed(HomeScreen.name); 
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
