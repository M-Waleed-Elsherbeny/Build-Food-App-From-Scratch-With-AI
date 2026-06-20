import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/di/injection.dart';
import 'package:food_app/features/cart/presentation/pages/cart_screen.dart';
import 'package:food_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food_app/features/home/presentation/pages/home_page.dart';
import 'package:food_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:food_app/features/profile/presentation/pages/profile_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  bool _isBottomNavVisible = true;

  void _onScrollDirectionChanged(bool isScrollingDown) {
    if (isScrollingDown && _isBottomNavVisible) {
      setState(() => _isBottomNavVisible = false);
    } else if (!isScrollingDown && !_isBottomNavVisible) {
      setState(() => _isBottomNavVisible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onScrollDirectionChanged: _onScrollDirectionChanged),
      const Center(child: Text('Orders')),
      BlocProvider(
        create: (context) => getIt<CartCubit>()..getCartItems(),
        child: const CartScreen(),
      ),
      BlocProvider(
        create: (context) => getIt<ProfileCubit>(),
        child: const ProfileScreen(),
      ),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        isVisible: _isBottomNavVisible,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
            // Always show bottom nav when switching tabs
            _isBottomNavVisible = true;
          });
        },
      ),
    );
  }
}
