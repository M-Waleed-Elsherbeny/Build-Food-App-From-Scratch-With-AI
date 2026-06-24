import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/utils/custom_snack_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/signup_form.dart';

/// The signup screen for the application.
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: const SingleChildScrollView(child: _SignupPageBody()),
    );
  }
}

class _SignupPageBody extends StatelessWidget {
  const _SignupPageBody();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success && state.user != null) {
          customSnackBar(context, message: 'Registration successful! Verification code sent.', isError: false);
          context.push(AppRoutes.otp, extra: state.user!.email);
          context.read<AuthCubit>().resetStatus();
        } else if (state.status == AuthStatus.failure) {
          customSnackBar(context, message: state.error!);
        }
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              const SignupForm(),
              SizedBox(height: 24.h),
              const _LoginLink(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginLink extends StatelessWidget {
  const _LoginLink();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppTextStyle.font14Grey600Regular,
        ),
        GestureDetector(
          onTap: () => context.push(AppRoutes.login),
          child: Text(
            'Login',
            style: AppTextStyle.font14PrimaryBold,
          ),
        ),
      ],
    );
  }
}
