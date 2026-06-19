import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset successful. Please login.')),
          );
          context.go(AppRoutes.login);
          context.read<AuthCubit>().resetStatus();
        } else if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? 'Failed to reset password')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Password',
                    style: context.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.grey900,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Create a strong password to secure your account for ${widget.email}.',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.grey500,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter new password',
                    labelText: 'New Password',
                    isPassword: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: AppValidator.validatePassword,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm new password',
                    labelText: 'Confirm Password',
                    isPassword: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: 'Reset Password',
                        isLoading: state.status == AuthStatus.loading,
                        onPressed: _onResetPressed,
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onResetPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().resetPassword(widget.email, _passwordController.text.trim());
    }
  }
}

