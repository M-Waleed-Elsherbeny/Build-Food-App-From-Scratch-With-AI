import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

/// A widget that handles the signup form input and submission.
class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
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
            'Create Account',
            style: context.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorsManager.grey900,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Join us and get the best food delivered to your doorstep.',
            style: context.textTheme.bodyLarge?.copyWith(
              color: ColorsManager.grey500,
            ),
          ),
          SizedBox(height: 32.h),
          CustomTextField(
            controller: _nameController,
            hintText: 'Enter your full name',
            labelText: 'Full Name',
            prefixIcon: const Icon(Icons.person_outline),
            validator: AppValidator.validateName,
          ),
          SizedBox(height: 20.h),
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
          SizedBox(
            height: 50.h,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return PrimaryButton(
                text: 'Sign Up',
                isLoading: state.status == AuthStatus.loading,
                onPressed: _onSignupPressed,
              );
            },
          ),
        ],
      ),
    );
  }

  void _onSignupPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }
}
