import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../home/home_screen.dart';
import '../registration/regist_screen.dart';
import '../validation/credentials_validation.dart';
import 'cubit/auth_cubit.dart';

class AuthScreen extends StatefulWidget {
  static const path = '/auth';
  static const name = 'auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Войти',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                  ErrorMessage(),
                  SizedBox(height: 20),
                  AuthTextFormWidget(),
                  SizedBox(height: 40),
                  ButtonFormWidget(),
                  SizedBox(height: 20),
                  BlocWidget(),
                ],
              ),
            ),
          ),
        ));
  }
}

class AuthTextFormWidget extends StatefulWidget {
  const AuthTextFormWidget({super.key});

  @override
  State<AuthTextFormWidget> createState() => _AuthTextFormWidgetState();
}

class _AuthTextFormWidgetState extends State<AuthTextFormWidget> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Логин',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        const LoginInputTextField(),
        const SizedBox(height: 20),
        Text(
          'Пароль',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        const PasswordInputWidget(),
      ],
    );
  }
}

class LoginInputTextField extends StatelessWidget {
  const LoginInputTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) {
            if (EmailValidationError.invalid.name != null) {
              return EmailValidationError.invalid.name;
            } else {
              return null;
            }
          },
          onChanged: (value) => context.read<AuthCubit>().emailChanged(value),
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.white),
          decoration: const AppTextFiledDecorations(
            hintText: 'Введите электронную почту',
          ).inputDecoration,
        );
      },
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(context.watch<AuthCubit>().state.errorMessage ?? '',
        style: const TextStyle(color: Colors.red));
  }
}

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({super.key});

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.white),
          obscureText: isPasswordVisible,
          enableSuggestions: false,
          onChanged: (value) =>
              context.read<AuthCubit>().passwordChanged(value),
          autocorrect: false,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
            hintText: 'Введите пароль',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: AppColors.backgroundFormFild,
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        );
      },
    );
  }
}

class BlocWidget extends StatelessWidget {
  const BlocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state.status) {
          case FormzSubmissionStatus.initial:
            return const Text('init');
          case FormzSubmissionStatus.inProgress:
            return const CircularProgressIndicator();
          case FormzSubmissionStatus.failure:
            return Text(FormzSubmissionStatus.failure.name);
          case FormzSubmissionStatus.success:
            context.goNamed(HomeScreen.name);
            return const Text('success');

          default:
            return const Text('default');
        }
      },
    );
  }
}

class ButtonFormWidget extends StatefulWidget {
  const ButtonFormWidget({super.key});

  @override
  State<ButtonFormWidget> createState() => _ButtonFormWidgetState();
}

class _ButtonFormWidgetState extends State<ButtonFormWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().logInWithCredentials(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.button,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Войти'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'У вас нет учетной записи ?',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.goNamed(RegistrationScreen.name);
                  },
                  child: Text(
                    'Регистрация',
                    style: GoogleFonts.poppins(
                      color: AppColors.button,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
