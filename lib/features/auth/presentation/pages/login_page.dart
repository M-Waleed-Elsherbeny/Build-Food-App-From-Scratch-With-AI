import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/utils/custom_snack_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/login_form.dart';

/// The login screen for the application.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.canPop() ? context.pop() : null,
        ),
      ),
      body: const SingleChildScrollView(child: _LoginPageBody()),
    );
  }
}

class _LoginPageBody extends StatelessWidget {
  const _LoginPageBody();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          customSnackBar(context, message: 'Welcome back!', isError: false);
          context.go(AppRoutes.main);
          // context.read<AuthCubit>().resetStatus();
        } else if (state.status == AuthStatus.failure) {
          customSnackBar(context, message: state.error!);
        }
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              const LoginForm(),
              SizedBox(height: 24.h),
              const _SignupLink(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignupLink extends StatelessWidget {
  const _SignupLink();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account? ',
            style: AppTextStyle.font14Grey600Regular),
        GestureDetector(
          onTap: () => context.push(AppRoutes.signup),
          child: Text(
            'Sign Up',
            style: AppTextStyle.font14PrimaryBold,
          ),
        ),
      ],
    );
  }
}
