import 'package:formz/formz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient client = Supabase.instance.client;
  final Session? session = Supabase.instance.client.auth.currentSession;
  

  Future<void> singUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await client.auth.signUp(password: password, email: email, data: {
        'data': {'name': name},
      });
    } catch (error) {
      FormzSubmissionStatus.failure;
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
       await client.auth
          .signInWithPassword(password: password, email: email);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> singOut() async {
    try {
      await client.auth.signOut();
    } catch (error) {
      rethrow;
    }
  }

  Future<UserResponse> currentUser() async {
    try {
      final user = client.auth.getUser();
      return user;
    } catch (error) {
      rethrow;
    }
  }

  Future<Session?> getSession() async {
    try {
      return client.auth.currentSession;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateUserPassword({
    required String newPassword,
  }) async {
    try {
      await client.auth.updateUser(UserAttributes(password: newPassword));
    } catch (error) {
      rethrow;
    }
  }
}
