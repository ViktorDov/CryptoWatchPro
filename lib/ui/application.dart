import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation/navigation.dart';
import 'screens/coins/cubit/coins_cubit.dart';
import 'screens/login/authentication/cubit/auth_cubit.dart';
import 'screens/login/registration/cubit/registration_cubit.dart';
import 'screens/portfolio/cubit/portfolio_cubit.dart';
import 'screens/profile/cubit/profile_cubit.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<RegistrationCubit>(
          create: (BuildContext context) => RegistrationCubit(),
        ),
        BlocProvider<CoinsCubit>(
          create: (BuildContext context) => CoinsCubit(),
        ),
        BlocProvider<PortfolioCubit>(
          create: (BuildContext context) => PortfolioCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (BuildContext context) => ProfileCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: const Locale('en', 'US'),
        routerConfig: Navigation.router,
      ),
    );
  }
}
