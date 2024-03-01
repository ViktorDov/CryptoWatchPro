import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../home/home_screen.dart';
import '../authentication/auth_screen.dart';
import 'cubit/registration_cubit.dart';

class RegistrationScreen extends StatefulWidget {
  static const path = '/registration';
  static const name = 'registration';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                      'Регистрация',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                  RegistTextFormWidget(),
                  SizedBox(height: 20),
                  ErrorMessage(),
                  SizedBox(height: 20),
                  ButtonFormWidget(),
                ],
              ),
            ),
          ),
        ));
  }
}

class RegistTextFormWidget extends StatefulWidget {
  const RegistTextFormWidget({super.key});

  @override
  State<RegistTextFormWidget> createState() => _RegistTextFormWidgetState();
}

class _RegistTextFormWidgetState extends State<RegistTextFormWidget> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isPasswordVisible = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Имя пользователя',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          onChanged: (value) {
            context.read<RegistrationCubit>().nameChanged(value);
          },
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Ваше имя',
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: AppColors.backgroundFormFild,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Почта',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Ваш адрес электронной почты',
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: AppColors.backgroundFormFild,
            labelStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onChanged: (value) {
            context.read<RegistrationCubit>().emailChanged(value);
          },
        ),
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
        TextFormField(
          obscureText: isPasswordVisible,
          enableSuggestions: false,
          autocorrect: false,
          style: const TextStyle(color: Colors.white),
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
          onChanged: (value) {
            context.read<RegistrationCubit>().passwordChanged(value);
          },
        ),
      ],
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
    final registrationCubit = context.watch<RegistrationCubit>();
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await registrationCubit.singUp();
              if (registrationCubit.state.status ==
                  FormzSubmissionStatus.success) {
                context.goNamed(HomeScreen.name);
              }
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
            child: const Text('Регистрация'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'У вас уже есть аккаунт?',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            TextButton(
              onPressed: () {
                context.goNamed(AuthScreen.name);
              },
              child: Text(
                'Войти',
                style: GoogleFonts.roboto(
                  color: AppColors.button,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
      builder: (context, state) {
        if (state.status.isFailure) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              state.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
