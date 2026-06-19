import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

/// A widget that handles the login form input and submission.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: context.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorsManager.grey900,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Sign in to continue ordering delicious food.',
            style: context.textTheme.bodyLarge?.copyWith(
              color: ColorsManager.grey500,
            ),
          ),
          SizedBox(height: 32.h),
          CustomTextField(
            controller: _emailController,
            hintText: 'Enter your email',
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
            validator: AppValidator.validateEmail,
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            controller: _passwordController,
            hintText: 'Enter your password',
            labelText: 'Password',
            isPassword: true,
            prefixIcon: const Icon(Icons.lock_outline),
            validator: AppValidator.validatePassword,
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 24.w,
                    width: 24.w,
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      activeColor: ColorsManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Remember me',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: ColorsManager.grey700,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => context.push(AppRoutes.forgotPassword),
                child: Text(
                  'Forgot Password?',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: ColorsManager.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return PrimaryButton(
                text: 'Login',
                isLoading: state.status == AuthStatus.loading,
                onPressed: _onLoginPressed,
              );
            },
          ),
        ],
      ),
    );
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }
}
