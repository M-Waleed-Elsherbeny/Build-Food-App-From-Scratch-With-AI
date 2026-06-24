import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/utils/custom_snack_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.push(AppRoutes.otp, extra: _emailController.text.trim());
          context.read<AuthCubit>().resetStatus();
        } else if (state.status == AuthStatus.failure) {
          customSnackBar(context, message: state.error ?? 'Failed to send reset code');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
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
                    'Recover Account',
                    style: context.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.grey900,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Enter your email address and we will send you a code to reset your password.',
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
                  const Spacer(),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: 'Send Code',
                        isLoading: state.status == AuthStatus.loading,
                        onPressed: _onSendCodePressed,
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

  void _onSendCodePressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().forgotPassword(_emailController.text.trim());
    }
  }
}

