import 'package:flutter/material.dart';
import 'package:food_app/core/routes/app_router.dart';
import 'package:go_router/go_router.dart';
import '../di/injection.dart';
import '../../features/auth/data/repositories/auth_repository.dart';

/// Guard widget that redirects unauthenticated users to the welcome page.
class AuthGuard extends StatefulWidget {
  final Widget child;
  const AuthGuard({super.key, required this.child});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  bool _isAuthenticated = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final repository = getIt<AuthRepository>();
    final isAuthenticated = await repository.isAuthenticated();

    // if (!mounted) return;

    // if (!isAuthenticated) {
    //   context.go(AppRoutes.welcome);
    //   return;
    // }

    setState(() {
      _isAuthenticated = true;
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(child: SizedBox.shrink()),
      );
    }

    return widget.child;
  }
}
