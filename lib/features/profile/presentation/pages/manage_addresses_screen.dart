import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/profile/data/models/address_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ManageAddressesScreen extends StatelessWidget {
  const ManageAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? ColorsManager.backgroundDark : ColorsManager.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? ColorsManager.grey900 : ColorsManager.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? ColorsManager.white : ColorsManager.grey900,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Addresses',
          style: isDark
              ? AppTextStyle.font18WhiteSemiBold
              : AppTextStyle.font18Grey900SemiBold,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.failure && state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: ColorsManager.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == ProfileStatus.loading;
          final addresses = state.profile?.addresses ?? [];

          return Skeletonizer(
            enabled: isLoading && addresses.isEmpty,
            child: Column(
              children: [
                Expanded(
                  child: addresses.isEmpty
                      ? _buildEmptyState(context, isDark)
                      : ListView.separated(
                          padding: EdgeInsets.all(24.w),
                          itemCount: addresses.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            final address = addresses[index];
                            return _buildAddressCard(context, address, isDark);
                          },
                        ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: PrimaryButton(
                    text: 'Add New Address',
                    onPressed: () => _showAddAddressSheet(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off_outlined,
            size: 80.sp,
            color: ColorsManager.grey400,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Addresses Saved',
            style: GoogleFonts.poppins(
              color: isDark ? ColorsManager.white : ColorsManager.grey900,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add your shipping address to make checkout easier.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: isDark ? ColorsManager.grey400 : ColorsManager.grey600,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(
      BuildContext context, AddressModel address, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? ColorsManager.grey900 : ColorsManager.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color:
                ColorsManager.primary.withValues(alpha: isDark ? 0.02 : 0.05),
            offset: Offset(0, 8.h),
            blurRadius: 20.r,
          ),
        ],
        border: address.isDefault
            ? Border.all(color: ColorsManager.primary, width: 1.5.r)
            : Border.all(
                color: isDark ? ColorsManager.grey800 : ColorsManager.grey200,
                width: 1.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon badge
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: ColorsManager.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              address.title.toLowerCase() == 'home'
                  ? Icons.home_outlined
                  : (address.title.toLowerCase() == 'work'
                      ? Icons.work_outline
                      : Icons.location_on_outlined),
              color: ColorsManager.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      address.title,
                      style: GoogleFonts.poppins(
                        color: isDark
                            ? ColorsManager.white
                            : ColorsManager.grey900,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (address.isDefault) ...[
                      SizedBox(width: 8.w),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: Text(
                          'DEFAULT',
                          style: GoogleFonts.inter(
                            color: ColorsManager.primary,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  address.addressLine,
                  style: GoogleFonts.inter(
                    color:
                        isDark ? ColorsManager.grey400 : ColorsManager.grey600,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          // Action Buttons
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: ColorsManager.grey400),
            onSelected: (action) {
              if (action == 'default') {
                context.read<ProfileCubit>().setAsDefaultAddress(address.id);
              } else if (action == 'delete') {
                context.read<ProfileCubit>().deleteAddress(address.id);
              }
            },
            itemBuilder: (context) => [
              if (!address.isDefault)
                PopupMenuItem(
                  value: 'default',
                  child: Text('Set as Default',
                      style: GoogleFonts.inter(fontSize: 14.sp)),
                ),
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  'Delete',
                  style: GoogleFonts.inter(
                      color: ColorsManager.error, fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddAddressSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: const _AddAddressSheet(),
      ),
    );
  }
}

class _AddAddressSheet extends StatefulWidget {
  const _AddAddressSheet();

  @override
  State<_AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<_AddAddressSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isDefault = false;

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? ColorsManager.grey900 : ColorsManager.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 48.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: isDark
                          ? ColorsManager.grey700
                          : ColorsManager.grey300,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Add New Address',
                  style: GoogleFonts.poppins(
                    color: isDark ? ColorsManager.white : ColorsManager.grey900,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: _titleController,
                  hintText: 'e.g. Home, Work',
                  labelText: 'Address Label',
                  prefixIcon: const Icon(Icons.bookmark_outline),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a label';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: _addressController,
                  hintText: 'Enter complete address details',
                  labelText: 'Address Details',
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter address details';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Set as default address',
                      style: GoogleFonts.inter(
                        color: isDark
                            ? ColorsManager.white
                            : ColorsManager.grey900,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Switch(
                      value: _isDefault,
                      activeThumbColor: ColorsManager.primary,
                      onChanged: (value) {
                        setState(() {
                          _isDefault = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  text: 'Save Address',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newAddress = AddressModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: _titleController.text.trim(),
                        addressLine: _addressController.text.trim(),
                        isDefault: _isDefault,
                      );
                      context.read<ProfileCubit>().addAddress(newAddress);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
