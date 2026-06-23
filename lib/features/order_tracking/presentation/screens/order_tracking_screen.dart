import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:food_app/features/order_tracking/data/models/order_tracking_model.dart';
import '../cubit/order_tracking_cubit.dart';
import '../cubit/order_tracking_state.dart';
import '../widgets/tracking_timeline_widget.dart';
import '../widgets/driver_info_card.dart';
import '../widgets/order_tracking_map_widget.dart';

/// Screen displaying real-time order tracking with map, timeline, and driver info.
class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderTrackingCubit>().loadTrackingInfo(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? ColorsManager.backgroundDark : ColorsManager.backgroundLight,
      appBar: AppBar(
        backgroundColor: ColorsManager.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isDark ? ColorsManager.grey800 : ColorsManager.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded,
                size: 18.sp,
                color: isDark ? ColorsManager.white : ColorsManager.grey900),
          ),
        ),
        title: Text('Track Order', style: AppTextStyle.font18Grey900SemiBold),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderTrackingCubit, OrderTrackingState>(
        builder: (context, state) {
          final isLoading = state.status == OrderTrackingStatus.loading;
          final data =
              isLoading ? OrderTrackingModel.fake() : state.trackingData;

          if (state.status == OrderTrackingStatus.failure) {
            return _buildErrorState(context, state.errorMsg);
          }

          return Skeletonizer(
            enabled: isLoading,
            child: RefreshIndicator(
              onRefresh: () =>
                  context.read<OrderTrackingCubit>().refreshTrackingData(),
              color: ColorsManager.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Map view
                    OrderTrackingMapWidget(orderId: widget.orderId),
                    SizedBox(height: 20.h),

                    // ETA Banner
                    if (data != null) _buildEtaBanner(context, data, isDark),
                    SizedBox(height: 20.h),

                    // Driver info card
                    if (data?.driver != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: DriverInfoCard(driver: data!.driver!),
                      ),
                    SizedBox(height: 20.h),

                    // Timeline
                    if (data != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: TrackingTimelineWidget(timeline: data.timeline),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEtaBanner(
      BuildContext context, OrderTrackingModel data, bool isDark) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            ColorsManager.primaryGradientStart,
            ColorsManager.primaryGradientEnd
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Estimated Delivery',
                    style: AppTextStyle.font14WhiteRegular),
                SizedBox(height: 4.h),
                Text('${data.etaMinutes} min',
                    style: AppTextStyle.font24WhiteBold),
                SizedBox(height: 4.h),
                Text(data.restaurantName,
                    style: AppTextStyle.font14WhiteRegular),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  data.status,
                  style: AppTextStyle.font14WhiteRegular,
                ),
              ),
              SizedBox(height: 8.h),
              Text('Order #${data.id}',
                  style: AppTextStyle.font12Grey500Regular
                      .copyWith(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 64.sp, color: ColorsManager.error),
            SizedBox(height: 16.h),
            Text('Something went wrong',
                style: AppTextStyle.font18Grey900SemiBold),
            SizedBox(height: 8.h),
            Text(message,
                style: AppTextStyle.font14Grey600Regular,
                textAlign: TextAlign.center),
            SizedBox(height: 24.h),
            TextButton(
              onPressed: () => context
                  .read<OrderTrackingCubit>()
                  .loadTrackingInfo(widget.orderId),
              child: Text('Retry', style: AppTextStyle.font16PrimaryBold),
            ),
          ],
        ),
      ),
    );
  }
}
