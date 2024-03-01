import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../data/repository/auth_supabase_repository.dart';
import '../../validation/credentials_validation.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(const RegistrationState());
  final SupabaseClient client = Supabase.instance.client;
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

  void nameChanged(String value) {
    emit(state.copyWith(name: value));
    print(state.name); 
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

  Future<void> singUp() async {
    
    log('NAME!!!!!! !  !!  ! ! ! !!  ${state.name}');
    if (!state.isValid) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'Invalid email or password',
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.inProgress,
          errorMessage: '',
        ),
      );
      try {
        await _auth.singUpWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
          name: state.name,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }
}
