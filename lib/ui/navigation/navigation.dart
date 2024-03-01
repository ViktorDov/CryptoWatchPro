import 'package:go_router/go_router.dart';
import '../../data/repository/auth_supabase_repository.dart';
import '../screens/coins/coins_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/intro/intro_screen.dart';
import '../screens/login/authentication/auth_screen.dart';
import '../screens/login/registration/regist_screen.dart';
import '../screens/portfolio/portfolio_screen.dart';
import '../screens/profile/profile_screen.dart';

class Navigation {
  final AuthRepository _authRepository = AuthRepository();
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: HomeScreen.path,
        name: HomeScreen.name,
        redirect: (context, state) async {
          final authRepository = Navigation()._authRepository;
          if (authRepository.session == null) {
            return state.namedLocation(IntroScreen.name);
          } 
          return null;
        },
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: IntroScreen.path,
        name: IntroScreen.name,
        builder: (context, state) => const IntroScreen(),
      ),
      GoRoute(
        path: AuthScreen.path,
        name: AuthScreen.name,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: RegistrationScreen.path,
        name: RegistrationScreen.name,
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: CoinsScreen.path,
        name: CoinsScreen.name,
        builder: (context, state) => const CoinsScreen(),
      ),
      GoRoute(
        path: PortfolioScreen.path,
        name: PortfolioScreen.name,
        builder: (context, state) => const PortfolioScreen(),
      ),
      GoRoute(
        path: ProfileScreen.path,
        name: ProfileScreen.name,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
