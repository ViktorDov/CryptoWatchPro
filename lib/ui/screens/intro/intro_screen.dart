import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/app_colors.dart';
import '../login/authentication/auth_screen.dart';
import '../login/registration/regist_screen.dart';
import 'pages/intro.dart';

class IntroScreen extends StatefulWidget {
  static const path = '/intro';
  static const name = 'intro';

  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            scrollDirection: Axis.horizontal,
            children: [
              IntroPage(
                currentPage: _currentPage,
                pageController: _pageController,
                image: 'assets/images/introOne.svg',
                title: 'Приветствую!',
                buttonTitle: 'Далее',
                description:
                    "Добро пожаловать на CryptoWatchPro! Приготовьтесь изучать данные в режиме реального времени, отслеживать свои любимые криптовалюты и принимать взвешенные решения с легкостью. Давайте отправимся в это захватывающее крипто-путешествие!",
              ),
              IntroPage(
                currentPage: _currentPage,
                pageController: _pageController,
                image: 'assets/images/introTwo.svg',
                title: 'Функциональный',
                buttonTitle: 'Далее',
                description:
                    "CryptoWatch Pro предлагает удобное наблюдение за ценами на криптовалюты в режиме реального времени. Создавайте персональные портфели, чтобы отслеживать свои инвестиции, и легко добавляйте монеты, чтобы оставаться организованным.",
              ),
              IntroPage(
                currentPage: _currentPage,
                pageController: _pageController,
                image: 'assets/images/introThree.svg',
                title: 'Приступим!',
                buttonTitle: 'Get Started',
                description:
                    'Откройте для себя мир криптовалют в приложении CryptoWatch Pro',
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            right: 35,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.button,
                    dotHeight: 10,
                    dotWidth: 10,
                    type: WormType.thinUnderground,
                  ),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == 2) {
                        context.goNamed(RegistrationScreen.name);
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.button,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _currentPage == 2 ? 'Зарегистрироваться' : 'Далее',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_currentPage == 2)
            Positioned(
              bottom: 40,
              left: 85,
              child: Row(
                children: [
                  const Text(
                    'У вас уже есть аккаунт?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.goNamed(AuthScreen.name);
                    },
                    child: const Text(
                      'Войти',
                      style: TextStyle(
                        color: AppColors.button,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
