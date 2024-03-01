import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';
import 'cubit/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  static const path = '/profile';
  static const name = 'Profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Профиль',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                SizedBox(height: AppSize.myHeight(context) * .1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueGrey,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.userName,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.userEmail,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SettingsAccountContainer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingsAccountContainer extends StatelessWidget {
  const SettingsAccountContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: AppSize.myWidth(context) * .8,
            height: AppSize.myHeight(context) * .07,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const ChangePasswordAlertDialog(),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.backgroundFormFild,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/settings.svg',
                    width: 30,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Изменить пароль',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: AppSize.myWidth(context) * .8,
            height: AppSize.myHeight(context) * .07,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.backgroundFormFild,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/myPortfolio.svg',
                    width: 35,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Мой портфель',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: AppSize.myWidth(context) * .8,
            height: AppSize.myHeight(context) * .07,
            child: ElevatedButton(
              onPressed: () {
                context.read<ProfileCubit>().logOut(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.backgroundFormFild,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/quit.svg',
                    width: 35,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Выйти',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextButton(
              onPressed: () {
                launchUrl(Uri.parse('https://forms.gle/d1LyYYZ1ppuaXHqq5'));
              },
              child: const Text(
                'Удалить аккаунт',
                style: TextStyle(
                  color: Color.fromARGB(231, 158, 158, 158),
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                  decorationColor: Color.fromARGB(231, 158, 158, 158),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChangePasswordAlertDialog extends StatelessWidget {
  const ChangePasswordAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProfileCubit>();
    const textStryle = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Builder(
        builder: (context) {
          return Container(
            height: AppSize.myHeight(context) * 0,
            width: AppSize.myWidth(context) * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
      backgroundColor: AppColors.backgroundColor,
      title: const Center(
          child: Text(
        'Change Password',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      )),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('New Password', style: textStryle),
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                cubit.changePasswrod(value);
              },
              decoration: InputDecoration(
                hintText: 'Insert Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Confirm Passwrod', style: textStryle),
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                cubit.changeConfirmPasswrod(value);
              },
              decoration: InputDecoration(
                hintText: 'Confirm  new passwrod',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                  cubit.state.isPasswordValid ? '' : 'Password do not match',
                  style: textStryle),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: AppSize.myWidth(context) * 0.3,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.button),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<ProfileCubit>()
                          .onPressedChangePassword(context);
                    },
                    child: const Text('Submit', style: textStryle),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
