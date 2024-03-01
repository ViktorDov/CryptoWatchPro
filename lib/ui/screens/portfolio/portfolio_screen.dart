import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';
import '../coins/cubit/coins_cubit.dart';
import '../widgets/portfolio_coin_card.dart';
import '../widgets/rhombus_button.dart';
import 'cubit/portfolio_cubit.dart';

class PortfolioScreen extends StatefulWidget {
  static const String path = '/Portfolio';
  static const String name = 'Portfolio';
  const PortfolioScreen({
    super.key,
  });

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        switch (state.status) {
          case PortfolioStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case PortfolioStatus.isEmpty:
            return EmptyPortfolioScreen(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AddCoinAlertDialog();
                    });
              },
            );
          case PortfolioStatus.isNotEmpty:
            return SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '\$${state.totalPortfolioBalance}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Expanded(
                    child: PortfolioCoinsPage(),
                  ),
                ],
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}

class PortfolioCoinsPage extends StatefulWidget {
  const PortfolioCoinsPage({super.key});

  @override
  State<PortfolioCoinsPage> createState() => _PortfolioCoinsPageState();
}

class _PortfolioCoinsPageState extends State<PortfolioCoinsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
      return Stack(
        children: [
          ListView.builder(
            itemCount: state.portfolioCoins.length,
            itemBuilder: (context, index) {
              final coin = state.portfolioCoins[index];
              return PortfolioCoinCard(
                symbol: coin.symbol,
                name: coin.name,
                currentPrice: coin.currentPrice,
                buyPrice: coin.buyPrice,
                image: coin.image,
              );
            },
          ),
          Positioned(
            bottom: 35,
            right: AppSize.myWidth(context) * 0.45,
            child: CustomButton(
              Colors.blue,
              Colors.black,
              Icons.add,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AddCoinAlertDialog();
                  },
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

class EmptyPortfolioScreen extends StatelessWidget {
  final VoidCallback onTap;
  const EmptyPortfolioScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Портфолио',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Center(
                  child: Text(
                    'У вас нет монет в портфолио',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.myHeight(context) * 0.7),
                CustomButton(
                  Colors.blue,
                  Colors.black,
                  Icons.add,
                  onTap: onTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddCoinAlertDialog extends StatefulWidget {
  const AddCoinAlertDialog({Key? key}) : super(key: key);

  @override
  AddCoinAlertDialogState createState() => AddCoinAlertDialogState();
}

class AddCoinAlertDialogState extends State<AddCoinAlertDialog> {
  late PageController _pageController;
  late TextEditingController _coinController;
  late TextEditingController _amountController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _coinController = TextEditingController();
    _amountController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _coinController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final coins = context.read<CoinsCubit>().state.coins;
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: Colors.grey[800],
      title: const Center(
        child: Text(
          'Добавить монету',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.32,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Выберете монету', style: textStyle),
                ),
                DropdownButtonFormField(
                  menuMaxHeight: AppSize.myHeight(context) * 0.25,
                  dropdownColor: Colors.grey[800],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  items: coins.map((coin) {
                    return DropdownMenuItem(
                      value: coin.name,
                      child: Text(coin.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context.read<PortfolioCubit>().requestAddCoinName(value);
                    }
                  },
                ),
                const Spacer(),
                Center(
                  child: SizedBox(
                    width: AppSize.myWidth(context) * 0.3,
                    child: ElevatedButton(
                      onPressed: nextPage,
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
                      child: const Text('Выбрать', style: textStyle),
                    ),
                  ),
                ),
              ],
            ),
            BuyPriceAleretDialogPage(onTapPrevious: previousPage),
          ],
        ),
      ),
    );
  }
}

class BuyPriceAleretDialogPage extends StatelessWidget {
  final VoidCallback onTapPrevious;
  const BuyPriceAleretDialogPage({super.key, required this.onTapPrevious});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text('Количество монет',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16)),
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Вставить сумму',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          onChanged: (value) =>
              context.read<PortfolioCubit>().requestAddCoinAmount(value),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Цена',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Цена монеты',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          onChanged: (value) =>
              context.read<PortfolioCubit>().requestAddCoinBuyPrice(value),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: onTapPrevious,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.button,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Назад'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<PortfolioCubit>().addCoinToPortfolio();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.button,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Добавить'),
            ),
          ],
        ),
      ],
    );
  }
}
