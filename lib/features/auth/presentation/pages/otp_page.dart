import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/utils/custom_snack_bar.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((e) => e.text).join();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.push(AppRoutes.resetPassword, extra: widget.email);
          context.read<AuthCubit>().resetStatus();
        } else if (state.status == AuthStatus.failure) {
          customSnackBar(context, message: state.error ?? 'Verification failed');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('OTP Verification'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify Email',
                  style: context.textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.grey900,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'We have sent a verification code to ${widget.email}. Enter it below.',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.grey500,
                  ),
                ),
                SizedBox(height: 48.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 70.w,
                      height: 70.h,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: context.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.primary,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(color: ColorsManager.grey200, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: const BorderSide(color: ColorsManager.primary, width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            _focusNodes[index + 1].requestFocus();
                          } else if (value.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                          if (_otp.length == 4) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                SizedBox(height: 48.h),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      text: 'Verify',
                      isLoading: state.status == AuthStatus.loading,
                      onPressed: _otp.length == 4 ? _onVerifyPressed : null,
                    );
                  },
                ),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthCubit>().forgotPassword(widget.email);
                    },
                    child: Text(
                      'Resend Code',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: ColorsManager.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onVerifyPressed() {
    context.read<AuthCubit>().verifyOtp(widget.email, _otp);
  }
}

