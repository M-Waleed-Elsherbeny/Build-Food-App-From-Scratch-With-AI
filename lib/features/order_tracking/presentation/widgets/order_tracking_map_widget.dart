import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_text_style.dart';

/// Map placeholder widget simulating route visualization for order tracking.
/// Replace with google_maps_flutter when API key is available.
class OrderTrackingMapWidget extends StatelessWidget {
  final String orderId;

  const OrderTrackingMapWidget({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A2A4A), Color(0xFF0F172A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Simulated map roads
          CustomPaint(
            size: Size(double.infinity, 220.h),
            painter: _MapPainter(),
          ),
          // Delivery path line
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Origin icon (restaurant)
                _buildMapMarker(
                  icon: Icons.restaurant_rounded,
                  color: ColorsManager.primary,
                  label: 'Restaurant',
                ),
                SizedBox(height: 12.h),
                // Animated dashes (path)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (i) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      width: 10.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: i < 4 ? ColorsManager.primary : Colors.white24,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                // Driver icon (moving)
                _buildMapMarker(
                  icon: Icons.delivery_dining_rounded,
                  color: ColorsManager.success,
                  label: 'Driver is on the way',
                ),
              ],
            ),
          ),
          // Bottom overlay with order ID
          Positioned(
            bottom: 12.h,
            right: 12.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Order #$orderId',
                style: AppTextStyle.font12Grey500Regular.copyWith(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapMarker({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, spreadRadius: 2),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 18.sp),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(label, style: TextStyle(color: Colors.white, fontSize: 11.sp)),
        ),
      ],
    );
  }
}

/// Custom painter for simulated map grid lines.
class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    // Horizontal lines
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vertical lines
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
